import router from '@ohos.router';
import { getPatientsBySource } from '../../service/patientService';
class DividerTmp {
  strokeWidth: Length = 1;
  color: ResourceColor = '#ffe9f0f0';

  constructor(strokeWidth: Length,color: ResourceColor) {
    this.strokeWidth = strokeWidth;
    this.color = color;
  }
}
interface Type1 {
  title: string;
  count: string;
  icon: Resource;
}
@Entry
@Component
struct Huanzheguanli {
  @State message: string = 'Hello World';
  @State searchText: string = '';
  @State egDivider: DividerTmp = new DividerTmp(1, '#ffe9f0f0');
  @State patientData: Array<Type1> = [];
  async aboutToAppear() {
    const [consult, register, prescribe] = await Promise.all([
      getPatientsBySource('consult'),
      getPatientsBySource('register'),
      getPatientsBySource('prescribe')
    ]);
    this.patientData = [
      { title: '问诊患者', count: `${consult.length}人`, icon: $r('app.media.arrow_right') },
      { title: '挂号患者', count: `${register.length}人`, icon: $r('app.media.arrow_right') },
      { title: '开药患者', count: `${prescribe.length}人`, icon: $r('app.media.arrow_right') }
    ];
  }
  build() {
    Column() {
      Row() {
        Row(){
      Image($r("app.media.arrow_left"))
        .width(10)
        .height(30)
        .margin({left:10})
        Text('患者管理')
          .fontSize(20)
          .fontWeight(600)
          .margin({left:10})
        }
        Text('群发消息')
          .fontColor('#0062FF')
          .fontSize(16)
          .margin({right:10})
          .onClick(()=>{
            router.pushUrl({url:'pages/patient/xiaoxiliebiao'})
          })
      }.justifyContent(FlexAlign.SpaceBetween).width('100%')
      Divider()
        .width('100%')
        .strokeWidth(1)
      Row() {
        Search({
          placeholder: '搜索患者',
          value: this.searchText
        }).backgroundColor('#FFFFFF')
          .borderWidth(0.1).placeholderFont({size:15,weight:300})
      }.width('80%').justifyContent(FlexAlign.Center).height('10%')
      Column() {
        Row().width('100%').height(10).backgroundColor('#E4E4E4')
      }
      Column(){
            Row(){
            Image($r('app.media.img_2'))
              .width(22)
              .height(22)
              .borderRadius(11)
              .margin({left:15})
            Text('患者来源')
              .margin({left:8})
              .fontSize(16)
              .fontWeight(300)
            }.width('100%').margin({top:15})
        Divider()
          .strokeWidth(0.5)
          .color('#E5E5E5').margin({top:10})
          }

      List() {
        ForEach(this.patientData, (item: Type1, index) => {
          ListItem() {
            Row() {
              Text(item.title)
                .fontSize(16).margin({left:20})
              // 自动填充剩余空间，将文字和人数分开
            Row(){
              Text(item.count)
                .fontSize(16)
              Image(item.icon) // 右侧箭头图标
                .width(10)
                .height(20)
             }
            }.justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
            .height('8%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              // 根据不同的列表项跳转到不同的页面
              switch (index) {
                case 0:
                  router.pushUrl({ url: 'pages/patient/huanzheliebiao', params: { source: 'consult' } });
                  break;
                case 1:
                  router.pushUrl({ url: 'pages/patient/huanzheliebiao', params: { source: 'register' } });
                  break;
                case 2:
                  router.pushUrl({ url: 'pages/patient/huanzheliebiao', params: { source: 'prescribe' } });
                  break;
              }
            })
          }
        })
      }.width('100%').height('100%').divider(this.egDivider)
      .backgroundColor('#F5F5F5') // 列表背景色
    }
  }
}
