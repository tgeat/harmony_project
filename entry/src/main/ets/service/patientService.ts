import http from '@ohos.net.http';
import type { Patient, Message } from '../model/patient';

const BASE_URL = 'http://localhost:3000/api';

interface HeadersMap {
  [key: string]: string;
}

interface RequestOptions {
  method?: string;
  header?: HeadersMap;
  extraData?: string;
}

async function requestJson<T>(url: string, options: RequestOptions = {}): Promise<T> {
  const httpRequest = http.createHttp();
  const response = await httpRequest.request(url, options);
  httpRequest.destroy();
  return JSON.parse(response.result as string) as T;
}

export function getPatientsBySource(source: 'consult' | 'register' | 'prescribe'): Promise<Patient[]> {
  return requestJson<Patient[]>(`${BASE_URL}/patients?source=${source}`);
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

export function sendMessage(payload: Partial<Message>): Promise<void> {
  return requestJson<void>(`${BASE_URL}/messages`, {
    method: 'POST',
    header: { 'Content-Type': 'application/json' },
    extraData: JSON.stringify(payload)
  }).then(() => {});
}
