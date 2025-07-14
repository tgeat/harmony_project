import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { sendMessage } from '../../service/patientService'
import promptAction from '@ohos.promptAction'
import { ListItemBasic } from '../../common/components'

@Component
struct MsgCreate {
  @State content: string = ''
  @State count: number = 0

  build() {
    Column() {
      TextInput({ placeholder: '输入消息', text: this.content })
        .width('90%')
        .onChange((v: string) => { this.content = v; this.count = v.length })
      Text(`${this.count}/140`)
      ListItemBasic({ left: '接收人', right: patientStore.selectedIds.length.toString() })
        .onClick(() => router.pushUrl({ url: '/patient/receiverMode' }))
      Button('发送')
        .onClick(async () => {
          if (this.content.length === 0 || this.content.length > 140 || patientStore.selectedIds.length === 0) {
            return
          }
          await sendMessage({ content: this.content, receivers: patientStore.selectedIds })
          promptAction.showToast({ message: '发送成功' })
          router.replaceUrl({ url: '/patient/msgList' })
        })
    }
    .width('100%')
    .height('100%')
  }
}
