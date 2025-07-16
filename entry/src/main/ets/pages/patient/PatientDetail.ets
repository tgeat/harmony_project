import { getPatientDetail } from '../../service/patientService'
import router from '@ohos.router'
import type { Patient } from '../../model/patient'
import { AvatarIcon } from '../../common/components'

@Component
struct PatientDetail {
  @State patient: Patient | null = null

  build() {
    Column() {
      if (this.patient) {
        AvatarIcon({ src: this.patient.avatar, size: 60 })
          .margin({ bottom: 10 })
        Text(`姓名：${this.patient.name}`)
        Text(`性别：${this.patient.gender}`)
        Text(`年龄：${this.patient.age}`)
        Text(`手机号：${this.patient.mobile}`)
      }
    }
    .width('100%')
    .height('100%')
    .onAppear(async () => {
      const { id } = router.getParams() as { id: string }
      const detail = await getPatientDetail(Number(id))
      this.patient = detail
    })
  }
}
