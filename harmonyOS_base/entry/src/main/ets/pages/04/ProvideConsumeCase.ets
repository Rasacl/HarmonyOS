@Entry
@Component
struct ProvideConsumeCase {
  @Provide count: number = 100
  @Provide ('test') money:number = 20

  build() {
    Row() {
      Column({space: 10}) {
        Text(`老夫有碎银${this.count.toString()}两`).fontSize(30)
          .onClick(() => {
            this.count += 30
          })
        Divider().strokeWidth(6).color(Color.Red)
        Father()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Father {
  @Consume ('test') test:number
  build() {
    Column(){
      Text('父亲组件' + this.test)
      Divider().strokeWidth(6).color(Color.Green)
      Grand()
    }
  }
}


@Component
struct Grand {
  @Consume count:number
  build() {
    Text(`我接受到爷爷的钱${this.count.toString()}}`)
      .onClick(() => {
        this.count -= 10
      })
  }
}