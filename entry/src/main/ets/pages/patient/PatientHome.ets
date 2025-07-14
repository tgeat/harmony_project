import router from '@ohos.router'
import { patientStore } from '../../store/patientStore'
import { SearchBar, ListItemBasic } from '../../common/components'

@Entry
@Component
struct PatientHome {
  @State search: string = ''

  private goto(source: string) {
    router.pushUrl({ url: `/patient/category?type=${source}` })
  }

  build() {
    Column() {
      SearchBar({
        placeholder: '搜索',
        value: this.search,
        onChange: (v: string) => { this.search = v }
      })
        .margin({ bottom: 10 })

      Column() {
        ListItemBasic({ left: '问诊' })
          .onClick(() => this.goto('consult'))
        ListItemBasic({ left: '挂号' })
          .onClick(() => this.goto('register'))
        ListItemBasic({ left: '开药' })
          .onClick(() => this.goto('prescribe'))
      }
    }
    .width('100%')
    .height('100%')
    .toolbar({
      title: '患者管理',
      menu: [{ value: '群发消息', action: () => router.pushUrl({ url: '/patient/msgList' }) }]
    })
  }
}
