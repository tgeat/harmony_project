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
  private patientData: Array<Type1> = [
    { title: '患者姓名', count: '李四'},
    { title: '性别', count: '女' },
    { title: '年龄', count: '32' },
    { title: '电话号码', count: '188****1234' },
    { title: '身份证号', count: '110101********0012' },
    { title: '社保卡', count: '1201***9991' },
    { title: '地区', count: '北京 朝阳区' },
  ];
  @State egDivider: DividerTmp = new DividerTmp(1, '#ffe9f0f0');
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