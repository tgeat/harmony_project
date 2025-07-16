import router from '@ohos.router'
import { ListItemBasic } from '../../common/components'
import { getMessage } from '../../service/patientService'
import type { Message } from '../../model/patient'

@Component
struct MsgDetail {
  @State msg: Message | null = null

  build() {
    Column() {
      if (this.msg) {
        Text(this.msg.title).fontSize(18)
        Text(this.msg.createTime)
        Text(this.msg.content)
        ForEach(this.msg.receivers, (r: number) => {
          ListItemBasic({ left: `接收人ID：${r}` })
        })
      }
    }
    .width('100%')
    .height('100%')
    .onAppear(async () => {
      const { id } = router.getParams() as { id: string }
      this.msg = await getMessage(Number(id))
    })
  }
}
