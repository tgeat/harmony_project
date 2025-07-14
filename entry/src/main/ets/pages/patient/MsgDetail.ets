import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { ListItemBasic } from '../../common/components'

@Component
struct MsgDetail {
  build() {
    let msg = patientStore.messages.find(m => m.id === Number(router.getParams().id))
    Column() {
      if (msg) {
        Text(msg.title).fontSize(18)
        Text(msg.createTime)
        Text(msg.content)
        ForEach(msg.receivers, (r: number) => {
          ListItemBasic({ left: `接收人ID：${r}` })
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}
