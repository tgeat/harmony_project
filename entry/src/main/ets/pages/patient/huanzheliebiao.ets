import router from '@ohos.router';
import image from '@ohos.multimedia.image';
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
interface type1{
  id:number;
  img:Resource;
  name:string;
  gender:string;
  years:string;
  lable:string;
  text:string;
  time:string;
}

interface SourceParams {
  source: 'consult' | 'register' | 'prescribe';
}

interface LabelMap {
  consult: string;
  register: string;
  prescribe: string;
}

const labelMap: LabelMap = {
  consult: '问诊患者',
  register: '挂号患者',
  prescribe: '开药患者'
};
@Entry
@Component
struct Huanzheliebiao {
  @State message: string = 'Hello World';
  @State searchText: string = '';
  @State egDivider: DividerTmp = new DividerTmp(1, '#ffe9f0f0');
  @State patientList:Array<type1> = [];
  @State title: string = '';
  @State source: 'consult' | 'register' | 'prescribe' = 'consult';

  async loadPatients() {
    const list = await getPatientsBySource(this.source, this.searchText);
    this.patientList = list.map((p: Patient): type1 => ({
      id: p.id,
      img: $r('app.media.img_3'),
      name: p.name,
      gender: p.gender === 'male' ? '男' : '女',
      years: `${p.age}岁`,
      lable: labelMap[p.source],
      text: '添加时间',
      time: p.createTime
    }));
  }

  async aboutToAppear() {
    const params = router.getParams() as SourceParams;
    this.source = params?.source ?? 'consult';
    this.title = labelMap[this.source];
    await this.loadPatients();
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image($r("app.media.arrow_left"))
            .width(10)
            .height(30)
            .margin({ left: 10 })
          Text(this.title)
            .fontSize(20)
            .fontWeight(600)
            .margin({ left: 10 })
        }
      }.width('100%').onClick(() => {
        router.back()
      })

      Divider()
        .width('100%')
        .strokeWidth(1)
      Row() {
        Search({
          placeholder: '搜索患者',
          value: this.searchText
        })
          .backgroundColor('#FFFFFF')
          .borderWidth(0.1)
          .placeholderFont({ size: 15, weight: 300 })
          .onChange((value: string) => {
            this.searchText = value;
          })
          .onSubmit(() => {
            this.loadPatients();
          })
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
        ForEach(this.patientList, (item: type1, index) => {
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
                  router.pushUrl({ url: 'pages/patient/huanzhexinxi', params: { id: item.id } });
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
