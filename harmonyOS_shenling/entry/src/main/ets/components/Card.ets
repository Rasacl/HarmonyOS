@Preview
@Component
struct Card {
  @BuilderParam
  CardFn: () => void
  build() {
    Column(){
      Column(){
        // 内容应该是传入的
        if(this.CardFn){
          this.CardFn()
        }
      }
      .width('100%')
      .backgroundColor($r('app.color.white'))
      .borderRadius(10)
      .padding({
        left:15,
        right:15
      })
    }
    .width('100%')
    .padding(15)
  }
}

export { Card }