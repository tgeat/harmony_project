import router from '@ohos.router'
import { ListItemBasic } from '../../common/components'

@Component
struct ReceiverMode {
  @State mode: string = 'all'

  build() {
    Column() {
      ListItemBasic({ left: '全部' })
        .onClick(() => { this.mode = 'all'; router.back() })
      ListItemBasic({ left: '部分' })
        .onClick(() => { this.mode = 'part'; router.pushUrl({ url: '/patient/receiverSelect?mode=part' }) })
      ListItemBasic({ left: '不发给谁' })
        .onClick(() => { this.mode = 'exclude'; router.pushUrl({ url: '/patient/receiverSelect?mode=exclude' }) })
    }
    .width('100%')
    .height('100%')
  }
}
