
@Entry
@Component
struct BuilderCase02 {
  build() {
    Row() {
      Column({space:10}) {
        getCellContent('异常时间', '2023-12-12')
        getCellContent("异常位置", "回龙观")
        getCellContent("异常类型", "漏油")
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#ccc')
  }
}

@Builder function getCellContent(leftTitle:string, rightValue:string){
  Row() {
    Row() {
      Text(leftTitle)
      Text(rightValue)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 15,
      right: 15
    })
    .borderRadius(8)
    .height(40)
    .backgroundColor(Color.White)
  }.padding({
    left: 10,
    right: 10
  })
}