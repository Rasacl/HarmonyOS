@Entry
@Component
struct StateStylesCase {
  @State message: string = 'Hello World'
  @State textEnable: boolean = true
  @Styles
  pressStyle() {
    .width(200)
    .height(80)
    .borderRadius(40)
    .backgroundColor(Color.Pink)
  }

  @Styles
  disableStyle() {
    .backgroundColor(Color.Red)
  }
  @Styles
  inputFocusStyle() {
    .border({
      color: Color.Red,
      width: 1
    })
  }

  @Styles
  inputNormalStyle (){
    .border({
      color: Color.Red,
      width: 0
    })
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        Row() {
          TextInput()
            .height(40)
            .stateStyles({
              focused: this.inputFocusStyle,
              normal: this.inputNormalStyle
            })
        }.padding({
          left: 10,
          right: 10
        })
        Row() {
          TextInput()
            .height(40)
            .stateStyles({
              focused: this.inputFocusStyle,
              normal: this.inputNormalStyle
            })
        }.padding({
          left: 10,
          right: 10
        })

        Text("测试")
          .textStateStyle()
          .stateStyles({
            pressed: this.pressStyle,
            disabled: this.disableStyle
          }).enabled(this.textEnable)
        Button("文本设置禁用")
          .onClick(() => {
            this.textEnable = !this.textEnable
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Extend(Text) function textStateStyle() {
  .width(100)
  .height(40)
  .textAlign(TextAlign.Center)
  .borderRadius(20)
  .backgroundColor(Color.Gray)
  .fontColor(Color.White)
}
