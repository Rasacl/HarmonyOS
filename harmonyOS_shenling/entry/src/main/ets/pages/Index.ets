// 负责存放所有的页面
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor($r('app.color.primary_disabled'))
      }
      .width('100%')
    }
    .height('100%')
  }
}