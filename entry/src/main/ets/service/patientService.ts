import http from '@ohos.net.http';
import type { Patient, Message } from '../model/patient';

const BASE_URL = 'http://localhost:3000/api';

async function requestJson<T>(url: string, options: http.HttpRequestOptions = {}): Promise<T> {
  const httpRequest = http.createHttp();
  const response: http.HttpResponse = await httpRequest.request(url, options);
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

export async function sendMessage(payload: Partial<Message>): Promise<void> {
  await requestJson<void>(`${BASE_URL}/messages`, {
    method: http.RequestMethod.POST,
    header: { 'Content-Type': 'application/json' },
    extraData: JSON.stringify(payload)
  });
}
