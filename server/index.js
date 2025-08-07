/* server.js ───────────────────────────────────────────── */
const express = require('express');
const cors = require('cors');
const Database = require('better-sqlite3');

const app = express();
app.use(cors());
app.use(express.json());

// ① 初始化 / 打开数据库文件（不存在会自动创建）
const db = new Database('./clinic.db');

// ② 初始化表（只在第一次运行时真正创建）
db.exec(`
  CREATE TABLE IF NOT EXISTS patients (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT    NOT NULL,
    gender      TEXT    NOT NULL,
    age         INTEGER NOT NULL,
    mobile      TEXT,
    idCard      TEXT,
    ssn         TEXT,
    city        TEXT,
    avatar      TEXT,
    source      TEXT    NOT NULL,
    createTime  TEXT    NOT NULL
  );

  CREATE TABLE IF NOT EXISTS messages (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    title       TEXT    NOT NULL,
    content     TEXT    NOT NULL,
    createTime  TEXT    NOT NULL
  );

  /* 关联表：一条消息可发给多名患者 */
  CREATE TABLE IF NOT EXISTS message_receivers (
    msgId       INTEGER,
    patientId   INTEGER,
    PRIMARY KEY (msgId, patientId)
  );
`);

/* ---------- PATIENTS ---------- */

/* 新增患者 */
app.post('/api/patients', (req, res) => {
  const {
    name        = '',
    gender      = 'male',
    age         = 0,
    mobile      = '',
    idCard      = '',
    ssn         = '',
    city        = '',
    avatar      = '',
    source      = 'consult'
  } = req.body;

  const stmt = db.prepare(`
    INSERT INTO patients
      (name, gender, age, mobile, idCard, ssn, city, avatar, source, createTime)
      VALUES (?,?,?,?,?,?,?,?,?,datetime('now','localtime'))
  `);
  const info = stmt.run(name, gender, age, mobile, idCard, ssn, city, avatar, source);
  const newPatient = db.prepare('SELECT * FROM patients WHERE id=?').get(info.lastInsertRowid);
  res.status(201).json(newPatient);
});

/* 查询患者 (支持 source / keyword) */
app.get('/api/patients', (req, res) => {
  const { source, keyword } = req.query;

  let sql = 'SELECT * FROM patients';
  const conds = [];
  const params = [];

  if (source) {
    conds.push('source = ?');
    params.push(source);
  }
  if (keyword) {
    const kw = `%${keyword}%`;
    conds.push('(name LIKE ? OR mobile LIKE ? OR idCard LIKE ? OR ssn LIKE ?)');
    params.push(kw, kw, kw, kw);
  }
  if (conds.length) sql += ' WHERE ' + conds.join(' AND ');

  const list = db.prepare(sql).all(...params);
  res.json(list);
});

/* 单个患者 */
app.get('/api/patients/:id', (req, res) => {
  const patient = db.prepare('SELECT * FROM patients WHERE id=?').get(req.params.id);
  patient ? res.json(patient) : res.sendStatus(404);
});

/* ---------- MESSAGES ---------- */

/* 获取所有消息（附带 receivers 数组）*/
app.get('/api/messages', (req, res) => {
  const msgs = db.prepare('SELECT * FROM messages ORDER BY id DESC').all();
  const receiversStmt = db.prepare('SELECT patientId FROM message_receivers WHERE msgId=?');

  const withReceivers = msgs.map(m => ({
    ...m,
    receivers: receiversStmt.all(m.id).map(r => r.patientId)
  }));
  res.json(withReceivers);
});

/* 获取单条消息 */
app.get('/api/messages/:id', (req, res) => {
  const msg = db.prepare('SELECT * FROM messages WHERE id=?').get(req.params.id);
  if (!msg) return res.sendStatus(404);

  const receivers = db.prepare('SELECT patientId FROM message_receivers WHERE msgId=?')
    .all(msg.id).map(r => r.patientId);
  res.json({ ...msg, receivers });
});

/* 新增消息 */
app.post('/api/messages', (req, res) => {
  const { title = '', content = '', receivers = [] } = req.body;

  const insertMsg = db.prepare(`
    INSERT INTO messages (title, content, createTime)
    VALUES (?,?,datetime('now','localtime'))
  `);
  const info = insertMsg.run(title, content);

  /* 批量插入收件人映射 */
  if (Array.isArray(receivers) && receivers.length) {
    const insertRel = db.prepare('INSERT OR IGNORE INTO message_receivers (msgId, patientId) VALUES (?,?)');
    const insertMany = db.transaction(ids => {
      for (const pid of ids) insertRel.run(info.lastInsertRowid, pid);
    });
    insertMany(receivers);
  }

  const newMsg = db.prepare('SELECT * FROM messages WHERE id=?').get(info.lastInsertRowid);
  res.status(201).json({ ...newMsg, receivers });
});

/* ---------- LISTEN ---------- */
const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server running on port ${port}`));
