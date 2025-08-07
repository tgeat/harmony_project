import router from '@ohos.router';
import { getPatientDetail } from '../../service/patientService';
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
}
@Entry
@Component
struct Huanzhexinxi {
  @State message: string = 'Hello World';
  @State patientData: Array<Type1> = [];
  @State egDivider: DividerTmp = new DividerTmp(1, '#ffe9f0f0');
  async aboutToAppear() {
    const params = router.getParams() as { id: number };
    const id = params?.id ?? 0;
    const p = await getPatientDetail(id);
    this.patientData = [
      { title: '患者姓名', count: p.name},
      { title: '性别', count: p.gender === 'male' ? '男' : '女' },
      { title: '年龄', count: `${p.age}` },
      { title: '电话号码', count: p.mobile },
      { title: '身份证号', count: p.idCard },
      { title: '社保卡', count: p.ssn },
      { title: '地区', count: p.city },
    ];
  }
  build() {
    Column() {
      Row() {

          Image($r("app.media.arrow_left"))
            .width(10)
            .height(30)
            .margin({ left: 10 })
          Text('患者信息')
            .fontSize(20)
            .fontWeight(600)
            .margin({ left: 10 })
      }.width('100%')
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
                  .margin({left:30})
              }
            }
            .width('100%')
            .height('7%')
            .padding(10)
            .backgroundColor('#FFFFFF')
            .onClick(() => {
              // 根据不同的列表项跳转到不同的页面
            })
          }
        })
      }.width('100%').height('100%').divider(this.egDivider)
      .backgroundColor('#F5F5F5') // 列表背景色
    }
  }
}
