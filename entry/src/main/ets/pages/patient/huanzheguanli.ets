import router from '@ohos.router';
import { getPatientsBySource } from '../../service/patientService';
import type { Patient } from '../../model/patient';
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
  @State searchResults: Patient[] = [];
  async onSearch() {
    if (!this.searchText) {
      this.searchResults = [];
      return;
    }
    const lists: Patient[][] = await Promise.all([
      getPatientsBySource('consult', this.searchText),
      getPatientsBySource('register', this.searchText),
      getPatientsBySource('prescribe', this.searchText)
    ]);
    this.searchResults = lists.reduce((acc: Patient[], cur: Patient[]) => acc.concat(cur), []);
  }
  async refreshCounts() {
    const results = await Promise.all([
      getPatientsBySource('consult'),
      getPatientsBySource('register'),
      getPatientsBySource('prescribe')
    ]);
    const consult: Patient[] = results[0];
    const register: Patient[] = results[1];
    const prescribe: Patient[] = results[2];
    this.patientData = [
      { title: '问诊患者', count: `${consult.length}人`, icon: $r('app.media.arrow_right') },
      { title: '挂号患者', count: `${register.length}人`, icon: $r('app.media.arrow_right') },
      { title: '开药患者', count: `${prescribe.length}人`, icon: $r('app.media.arrow_right') }
    ];
  }

  async aboutToAppear() {
    await this.refreshCounts();
  }

  async onPageShow() {
    await this.refreshCounts();
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
        Row(){
          Text('新建患者')
            .fontColor('#0062FF')
            .fontSize(16)
            .margin({right:20})
            .onClick(()=>{
              router.pushUrl({url:'pages/patient/xinjianhuanzhe'})
            })
          Text('群发消息')
            .fontColor('#0062FF')
            .fontSize(16)
            .margin({right:10})
            .onClick(()=>{
              router.pushUrl({url:'pages/patient/xiaoxiliebiao'})
            })
        }
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
          .onChange((value: string) => {
            this.searchText = value;
          })
          .onSubmit(() => {
            this.onSearch();
          })
      }.width('80%').justifyContent(FlexAlign.Center).height('10%')
      if (this.searchResults.length > 0) {
        List() {
          ForEach(this.searchResults, (p: Patient) => {
            ListItem() {
              Row() {
                Text(p.name)
                  .fontSize(16)
                  .margin({ left: 20 })
              }
              .width('100%')
              .height('8%')
              .padding(10)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                router.pushUrl({ url: 'pages/patient/huanzhexinxi', params: { id: p.id } });
              })
            }
          })
        }.width('100%').divider(this.egDivider)
      }
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
