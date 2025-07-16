import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { SearchBar } from '../../common/components'
import type { Patient } from '../../model/patient'

@Component
struct ReceiverSelect {
  build() {
    Column() {
      SearchBar({ placeholder: '搜索', onChange: () => {} })
        .margin({ bottom: 10 })
      List() {
        ForEach(patientStore.patientsMap.get('consult') || [], (p: Patient) => {
          ListItem() {
            Checkbox({ checked: patientStore.selectedIds.includes(p.id) })
            Text(p.name)
          }
          .onClick(() => patientStore.toggleSelect(p.id))
        })
      }
      Button('确定').onClick(() => router.back())
    }
    .width('100%')
    .height('100%')
  }
}
