import http from '@ohos.net.http';
import type { Patient, Message } from '../model/patient';

const BASE_URL = 'https://example.com/api';

export function getPatientsBySource(source: 'consult' | 'register' | 'prescribe'): Promise<Patient[]> {
  return http.fetch(`${BASE_URL}/patients?source=${source}`).then(resp => resp.json() as Promise<Patient[]>);
}

export function getPatientDetail(id: number): Promise<Patient> {
  return http.fetch(`${BASE_URL}/patients/${id}`).then(resp => resp.json() as Promise<Patient>);
}

export function getMessages(): Promise<Message[]> {
  return http.fetch(`${BASE_URL}/messages`).then(resp => resp.json() as Promise<Message[]>);
}

export function getMessage(id: number): Promise<Message> {
  return http.fetch(`${BASE_URL}/messages/${id}`).then(resp => resp.json() as Promise<Message>);
}

export function sendMessage(payload: Partial<Message>): Promise<void> {
  return http.fetch(`${BASE_URL}/messages`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(payload)
  }).then(() => {});
}
