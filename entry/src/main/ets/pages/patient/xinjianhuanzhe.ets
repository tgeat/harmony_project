import router from '@ohos.router';
import { createPatient } from '../../service/patientService';

@Entry
@Component
struct Xinjianhuanzhe {
  @State name: string = '';
  @State mobile: string = '';
  @State gender: 'male' | 'female' = 'male';
  @State age: string = '';
  @State idCard: string = '';
  @State ssn: string = '';
  @State city: string = '';
  @State source: 'consult' | 'register' | 'prescribe' = 'consult';

  async submit() {
    await createPatient({
      name: this.name,
      mobile: this.mobile,
      gender: this.gender,
      age: Number(this.age),
      idCard: this.idCard,
      ssn: this.ssn,
      city: this.city,
      source: this.source
    });
    router.back();
  }

  build() {
    Column() {
      Row() {
        Text('返回')
          .onClick(() => {
            router.back();
          })
        Text('新建患者')
          .fontSize(20)
          .fontWeight(600)
          .margin({ left: 10 })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .height('8%')

      TextInput({
        placeholder: '姓名',
        text: this.name
      })
        .margin({ top: 20, left: 20, right: 20 })
        .onChange((value: string) => {
          this.name = value;
        })

      TextInput({
        placeholder: '手机号',
        text: this.mobile
      })
        .margin({ top: 20, left: 20, right: 20 })
        .onChange((value: string) => {
          this.mobile = value;
        })

      Row() {
        Button('男')
          .onClick(() => {
            this.gender = 'male';
          })
        Button('女')
          .margin({ left: 10 })
          .onClick(() => {
            this.gender = 'female';
          })
      }
      .margin({ top: 20, left: 20, right: 20 })
      .justifyContent(FlexAlign.Center)

      TextInput({
        placeholder: '年龄',
        text: this.age
      })
        .margin({ top: 20, left: 20, right: 20 })
        .onChange((value: string) => {
          this.age = value;
        })

      TextInput({
        placeholder: '身份证号',
        text: this.idCard
      })
        .margin({ top: 20, left: 20, right: 20 })
        .onChange((value: string) => {
          this.idCard = value;
        })

      TextInput({
        placeholder: '社保号',
        text: this.ssn
      })
        .margin({ top: 20, left: 20, right: 20 })
        .onChange((value: string) => {
          this.ssn = value;
        })

      TextInput({
        placeholder: '城市',
        text: this.city
      })
        .margin({ top: 20, left: 20, right: 20 })
        .onChange((value: string) => {
          this.city = value;
        })

      Row() {
        Button('问诊患者')
          .onClick(() => {
            this.source = 'consult';
          })
        Button('挂号患者')
          .margin({ left: 10 })
          .onClick(() => {
            this.source = 'register';
          })
        Button('开药患者')
          .margin({ left: 10 })
          .onClick(() => {
            this.source = 'prescribe';
          })
      }
      .margin({ top: 20, left: 20, right: 20 })
      .justifyContent(FlexAlign.Center)

      Button('保存')
        .margin({ top: 40, left: 20, right: 20 })
        .onClick(() => {
          this.submit();
        })
    }
  }
}

