import { ObservableObject } from '@ohos/state';
import type { Patient, Message } from '../model/patient';
import { getPatientsBySource } from '../service/patientService';

export class PatientStore extends ObservableObject {
  patientsMap: Map<string, Patient[]> = new Map();
  messages: Message[] = [];
  selectedIds: number[] = [];

  async fetchPatients(source: 'consult' | 'register' | 'prescribe'): Promise<void> {
    const list = await getPatientsBySource(source);
    this.patientsMap.set(source, list);
  }

  toggleSelect(id: number): void {
    const idx = this.selectedIds.indexOf(id);
    if (idx === -1) {
      this.selectedIds.push(id);
    } else {
      this.selectedIds.splice(idx, 1);
    }
  }
}

export const patientStore = new PatientStore();
