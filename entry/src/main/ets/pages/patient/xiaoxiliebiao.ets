import router from '@ohos.router';
import { getMessages } from '../../service/patientService';
import type { Message } from '../../model/patient';
class DividerTmp {
  strokeWidth: Length = 1;
  color: ResourceColor = '#ffe9f0f0';

  constructor(strokeWidth: Length,color: ResourceColor) {
    this.strokeWidth = strokeWidth;
    this.color = color;
  }
}
interface type2{
  title:string;
  content:string;
  img:Resource;
  date:string;
  time:string;
}
@Entry
@Component
struct Xiaoxiliebiao {
  @State message: string = 'Hello World';
  @State searchText: string = '';
  @State egDivider: DividerTmp = new DividerTmp(1, '#ffe9f0f0');
  @State xiaoxilist:Array<type2>=[];
  async aboutToAppear() {
    const list = await getMessages();
    this.xiaoxilist = list.map((m: Message): type2 => {
      const parts = m.createTime.split(' ');
      const item: type2 = {
        title: m.title,
        content: m.content,
        img: $r('app.media.arrow_right'),
        date: parts[0],
        time: parts[1]
      };
      return item;
    });
  }
  build() {
    Column() {
      Row() {
        Row(){
          Image($r("app.media.arrow_left"))
            .width(10)
            .height(30)
            .margin({left:10})
          Text('消息列表')
            .fontSize(20)
            .fontWeight(600)
            .margin({left:10})
        }.onClick(() => {router.back()})
        Text('新建消息')
          .fontColor('#0062FF')
          .fontSize(16)
          .margin({right:10})
      }.justifyContent(FlexAlign.SpaceBetween).width('100%')
      Divider()
        .width('100%')
        .strokeWidth(1)
      Row() {
        Search({
          placeholder: '搜索消息关键字',
          value: this.searchText
        }).backgroundColor('#FFFFFF')
          .borderWidth(0.1).placeholderFont({size:15,weight:300})
      }.width('80%').justifyContent(FlexAlign.Center).height('10%')
      Column() {
        Row().width('100%').height(10).backgroundColor('#E4E4E4')
      }
      Column(){
        Row(){
          Text('消息列表')
            .margin({left:8})
            .fontSize(18)
            .fontWeight(300)
        }   .width('100%').margin({top:15})
        Divider()
          .strokeWidth(0.5)
          .color('#E5E5E5').margin({top:10})
      }

      List() {
        ForEach(this.xiaoxilist, (item: type2, index) => {
          ListItem() {
            Column({space:10}) {
             Row(){
               Text(item.title)
                 .fontSize(16)
             }.width('100%')  .margin({left:15})
                Row(){
               Text(item.content)
                 .fontSize(15)
                 .fontColor('#808080')
                 .margin({left:20})
                 .fontWeight(200)
                  Image(item.img)
                    .height(20)
                    .width(20)
                    .margin({left:30})
                }.width('100%')
              Row(){
               Text(item.date)
                 .fontSize(15)
                 .fontColor('#808080')
                 .fontWeight(200)
                 .margin({left:15})
                Text(item.time)
                  .fontSize(15)
                  .fontColor('#808080')
                  .fontWeight(200)
                  .margin({left:15})
              }.width('100%')
            }
          }
            .width('100%')
            .height('12%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              router.pushUrl({ url: 'pages/' });
            })
        })
        ListItem(){
          Column(){
          }.height(200)
        }
      }.width('100%').divider(this.egDivider)
      .backgroundColor('#F5F5F5') // 列表背景
    }
  }
  }
