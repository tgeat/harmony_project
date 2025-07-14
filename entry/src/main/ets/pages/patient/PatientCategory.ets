import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { SearchBar, ListItemBasic } from '../../common/components'

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
        ForEach(patientStore.patientsMap.get(router.getParams().type) || [], (item: any) => {
          ListItemBasic({
            left: item.name
          })
            .onClick(() => router.pushUrl({ url: `/patient/detail?id=${item.id}` }))
        })
      }
    }
    .width('100%')
    .height('100%')
    .onAppear(() => patientStore.fetchPatients(router.getParams().type))
  }
}
