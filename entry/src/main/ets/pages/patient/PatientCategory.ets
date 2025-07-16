import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { SearchBar, ListItemBasic } from '../../common/components'
import type { Patient } from '../../model/patient'

interface CategoryParams {
  type: 'consult' | 'register' | 'prescribe'
}

@Entry
@Component
struct PatientCategory {
  private type: 'consult' | 'register' | 'prescribe' = 'consult'
  build() {
    Column() {
      SearchBar({
        placeholder: '搜索',
        onChange: () => {}
      })
        .margin({ bottom: 10 })

        List() {
          ForEach(patientStore.patientsMap.get(this.type) || [], (item: Patient) => {
            ListItemBasic({ left: item.name })
              .onClick(() => router.pushUrl({ url: `/patient/detail?id=${item.id}` }))
          })
        }
    }
    .width('100%')
    .height('100%')
      .onAppear(() => {
        const params = router.getParams() as CategoryParams
        this.type = params.type
        patientStore.fetchPatients(this.type)
      })
  }
}
