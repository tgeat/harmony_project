export interface Patient {
  id: number
  name: string
  gender: string
  age: number
  mobile: string
  idCard: string
  ssn: string
  city: string
  avatar: string
  source: 'consult' | 'register' | 'prescribe'
  createTime: string
}

export interface Message {
  id: number
  title: string
  content: string
  createTime: string
  receivers: number[]
}
