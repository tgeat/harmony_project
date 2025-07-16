import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { SearchBar, ListItemBasic } from '../../common/components'
import type { Patient } from '../../model/patient'

@Component
struct PatientCategory {
  build() {
    Column() {
      SearchBar({
        placeholder: '搜索',
        onChange: () => {}
      })
        .margin({ bottom: 10 })

      List() {
        const { type } = router.getParams() as { type: string }
        ForEach(patientStore.patientsMap.get(type) || [], (item: Patient) => {
          ListItemBasic({
            left: item.name
          })
            .onClick(() => router.pushUrl({ url: `/patient/detail?id=${item.id}` }))
        })
      }
    }
    .width('100%')
    .height('100%')
    .onAppear(() => {
      const { type } = router.getParams() as { type: string }
      patientStore.fetchPatients(type)
    })
  }
}
