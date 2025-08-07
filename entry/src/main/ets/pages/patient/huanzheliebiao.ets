import router from '@ohos.router';
import image from '@ohos.multimedia.image';
class DividerTmp {
  strokeWidth: Length = 1;
  color: ResourceColor = '#ffe9f0f0';

  constructor(strokeWidth: Length,color: ResourceColor) {
    this.strokeWidth = strokeWidth;
    this.color = color;
  }
}
interface type1{
  img:Resource;
  name:string;
  gender:string;
  years:string;
  lable:string;
  text:string;
  time:string;
}
@Entry
@Component
struct Huanzheliebiao {
  @State message: string = 'Hello World';
  @State searchText: string = '';
  @State egDivider: DividerTmp = new DividerTmp(1, '#ffe9f0f0');
  private patientlist:Array<type1>=
    [{ img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
      { img:$r('app.media.img_3'),name:'李四',gender:'男',years:'43岁',lable:'视频问诊',text:'添加时间',time:'2020-04-03', },
    ]


  build() {
    Column() {
      Row() {
        Row() {
          Image($r("app.media.arrow_left"))
            .width(10)
            .height(30)
            .margin({ left: 10 })
          Text('问诊患者')
            .fontSize(20)
            .fontWeight(600)
            .margin({ left: 10 })
        }
      }.width('100%').onClick(() => {
        router.pushUrl({ url: 'pages/keshi' })
      })

      Divider()
        .width('100%')
        .strokeWidth(1)
      Row() {
        Search({
          placeholder: '搜索患者',
          value: this.searchText
        }).backgroundColor('#FFFFFF')
          .borderWidth(0.1).placeholderFont({ size: 15, weight: 300 })
      }.width('80%').justifyContent(FlexAlign.Center).height('10%')

      Column() {
        Row().width('100%').height(10).backgroundColor('#E4E4E4')
      }
Column(){
        Row(){
          Text('患者列表')
            .margin({left:8})
            .fontSize(18)
            .fontWeight(300)
        }   .width('100%').margin({top:15})
  Divider()
    .strokeWidth(0.5)
    .color('#E5E5E5').margin({top:10})
}
      List() {
        ForEach(this.patientlist, (item: type1, index) => {
          ListItem() {
            Row() {
              Image(item.img)
                .width(20)
                .height(30)
             Column(){
                Row({space:10}){
                  Text(item.name)
                    .fontSize(16)
                    .margin({left:10})
                  Text(item.gender)
                    .fontSize(14)
                    .fontColor('#CDCDCD')
                  Text(item.years)
                    .fontSize(14)
                    .fontColor('#CDCDCD')
                  Text(item.lable)
                    .borderWidth(1)
                    .backgroundColor('#EDF0FD')
                    .borderRadius(5)
                }
                Row(){
                  Text(item.text)
                    .fontSize(14)
                    .fontColor('#CDCDCD')
                  Text(item.time)
                    .fontSize(14)
                    .fontColor('#CDCDCD')
                }.margin({top:10})
             }
            }

            .width('100%')
            .height('15%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .onClick(() => {
                  router.pushUrl({ url: 'pages/' });
              })
          }
        })
        ListItem(){
          Column(){
          }.height(40)
        }
      }.width('100%').divider(this.egDivider)
      .backgroundColor('#F5F5F5') // 列表背景
    }.height('100%')
  }
}