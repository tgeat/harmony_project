import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { SearchBar, ListItemBasic } from '../../common/components'

@Component
struct MsgList {
  build() {
    Column() {
      SearchBar({
        placeholder: '搜索',
        onChange: () => {}
      })
        .margin({ bottom: 10 })
      List() {
        ForEach(patientStore.messages, (msg: any) => {
          ListItemBasic({ left: msg.title })
            .onClick(() => router.pushUrl({ url: `/patient/msgDetail?id=${msg.id}` }))
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}
