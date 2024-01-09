@Entry
@Component
struct PropCase {
  @State pnum: number = 0
  build() {
    Row() {
      Column() {
        Text(this.pnum.toString())
        Button("+1")
          .onClick(() => {
            this.pnum++
          })

        Divider()
        Child({ num: this.pnum })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Child {
  @Prop num: number
  build() {
    Column() {
      Text("子组件")
      Text(this.num.toString())
    }.height(60)
    .width('100%')
    .backgroundColor(Color.Pink)
  }
}