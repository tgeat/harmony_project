import http from '@ohos.net.http';
import type { Patient, Message } from '../model/patient';

const BASE_URL = 'http://192.168.101.159:3000/api';

export class HttpError extends Error {
  constructor(
    /** HTTP 状态码或业务 code */
    public readonly code: number,
    msg: string
  ) {
    super(msg);
  }
}

export async function requestJson<T>(
  url: string,
  options: http.HttpRequestOptions = {}
): Promise<T> {
  const client = http.createHttp();

  const merged: http.HttpRequestOptions = {
    expectDataType: http.HttpDataType.STRING, // 让 SDK 返回字符串，自己再 JSON.parse
    connectTimeout: 5000,
    readTimeout: 8000,
    ...options
  };

  try {
    /* ① 网络 / DNS / 超时：SDK 会直接 throw BusinessError */
    const resp = await client.request(url, merged);

    /* ② HTTP 层：非 2xx 均视为失败 */
    if (resp.responseCode < 200 || resp.responseCode >= 300) {
      throw new HttpError(resp.responseCode, `HTTP ${resp.responseCode}`);
    }

    /* ③ 业务层：假设后端统一返回 { code, data, msg } */
    const body = JSON.parse(resp.result as string);
    if (typeof body === 'object' && body !== null && 'code' in body) {
      if (body.code !== 0) {
        throw new HttpError(body.code, body.msg ?? '业务错误');
      }
      return body.data as T;
    }

    /* 后端直接返回目标 JSON，则直接强转 */
    return body as T;
  } finally {
    client.destroy();          // 释放连接
  }
}

export async function getPatientsBySource(
  source: 'consult' | 'register' | 'prescribe',
  keyword: string = ''
): Promise<Patient[]> {
  try {
    // ① 发送请求
    const url = `${BASE_URL}/patients?source=${source}` +
      (keyword ? `&keyword=${encodeURIComponent(keyword)}` : '');
    const list = await requestJson<Patient[]>(url);

    // ② 成功日志
    console.info('AppLog', `getPatientsBySource 成功 (${source})`, list);
    return list;

  } catch (err) {
    // ③ 失败日志分类
    console.error(
      'AppLog',
      `getPatientsBySource 业务/HTTP 错误 code=${err.code} (${source})`,
      err.message
    );
    }


}

export function getPatientDetail(id: number): Promise<Patient> {
  return requestJson<Patient>(`${BASE_URL}/patients/${id}`);
}

export function getMessages(): Promise<Message[]> {
  return requestJson<Message[]>(`${BASE_URL}/messages`);
}

export function getMessage(id: number): Promise<Message> {
  return requestJson<Message>(`${BASE_URL}/messages/${id}`);
}

export async function sendMessage(payload: Partial<Message>): Promise<void> {
  await requestJson<void>(`${BASE_URL}/messages`, {
    method: http.RequestMethod.POST,
    header: { 'Content-Type': 'application/json' },
    extraData: JSON.stringify(payload)
  });
}

export async function createPatient(payload: Partial<Patient>): Promise<Patient> {
  return await requestJson<Patient>(`${BASE_URL}/patients`, {
    method: http.RequestMethod.POST,
    header: { 'Content-Type': 'application/json' },
    extraData: JSON.stringify(payload)
  });
}
