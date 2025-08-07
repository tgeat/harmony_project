const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const patients = [
  { id: 1, name: '李四', gender: 'male', age: 43, mobile: '18800000001', idCard: '110101199001010011', ssn: 'SN001', city: '北京', avatar: '', source: 'consult', createTime: '2020-04-03 10:00:00' },
  { id: 2, name: '王五', gender: 'female', age: 32, mobile: '18800000002', idCard: '110101199001010022', ssn: 'SN002', city: '上海', avatar: '', source: 'register', createTime: '2020-04-05 11:00:00' },
  { id: 3, name: '赵六', gender: 'male', age: 25, mobile: '18800000003', idCard: '110101199001010033', ssn: 'SN003', city: '广州', avatar: '', source: 'prescribe', createTime: '2020-04-08 12:00:00' }
];

const messages = [
  { id: 1, title: '停诊通知', content: '由于某种原因，原定于2020.04.13日停诊', createTime: '2020-04-13 13:00:21', receivers: [1, 2] },
  { id: 2, title: '节日问候', content: '祝您身体健康，节日快乐', createTime: '2020-05-01 08:30:00', receivers: [2, 3] }
];

app.get('/api/patients', (req, res) => {
  const { source } = req.query;
  let result = patients;
  if (source) {
    result = patients.filter(p => p.source === source);
  }
  res.json(result);
});

app.get('/api/patients/:id', (req, res) => {
  const patient = patients.find(p => p.id === Number(req.params.id));
  if (patient) {
    res.json(patient);
  } else {
    res.status(404).send();
  }
});

app.get('/api/messages', (req, res) => {
  res.json(messages);
});

app.get('/api/messages/:id', (req, res) => {
  const msg = messages.find(m => m.id === Number(req.params.id));
  if (msg) {
    res.json(msg);
  } else {
    res.status(404).send();
  }
});

app.post('/api/messages', (req, res) => {
  const id = messages.length ? messages[messages.length - 1].id + 1 : 1;
  const newMsg = {
    id,
    title: req.body.title || '',
    content: req.body.content || '',
    createTime: new Date().toISOString().replace('T', ' ').split('.')[0],
    receivers: req.body.receivers || []
  };
  messages.push(newMsg);
  res.status(201).json(newMsg);
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
