


@Entry
@Component
struct ExtendCase {
  build() {
    Row() {
      Column({ space: 20 }) {
        Text("测试2")
          .text2Style()
        Button("按钮")
          .btnStyle()
        TextInput()
          .inputStyle()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Extend(Text) function text2Style () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
  .textAlign(TextAlign.Center)
  .fontSize(20)
}
@Extend(Button) function btnStyle () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
  .fontSize(20)
}
//
@Extend(TextInput) function inputStyle () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
  .textAlign(TextAlign.Center)
  .fontSize(20)
}

// 全局  原生组件                     参数
//  ↓     ↓                          ↓
@Extend(Text) function textInputAll (callback?: () => void) {
  .width(100)
  .height(50)
  .backgroundColor(Color.Pink)
  .borderRadius(25)
  .textAlign(TextAlign.Center)
  .fontColor(Color.White)
  .onClick(() => {
    callback && callback()
  })
}