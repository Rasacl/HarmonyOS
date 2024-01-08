//样式及链式调用  单位 vp 1vp == 3px vp会自动根据手机密度去适配
//layoutWeight 等比例、伸缩布局，相当于css的flex:1
//内容等比缩放 aspectRatio 先算宽度，根据宽度算出高度
@Entry
@Component
struct StyleCase {
  @State message: string = 'Hello World'

  build() {
    Row() {
      // Column() {
      //   //背景色设置成pink， 字体大小设置为40.对齐方式设置成居右，宽度200，高度50
      //   Text(this.message)
      //     .backgroundColor(Color.Pink)
      //     .fontSize(40)
      //     .textAlign(TextAlign.End)
      //     .width(200)
      //     .height(100)
      // }
      // .width('100%')
      // .justifyContent(FlexAlign.SpaceBetween)

      // Row(){
      //   Text('左侧内容')
      //   Row()
      //   .backgroundColor(Color.Red)
      //   .layoutWeight(1)
      //   .height(50)
      //     .margin({
      //       left:50
      //     })
      //   Row()
      //     .backgroundColor(Color.Black)
      //     .layoutWeight(2)
      //     .height(50)
      // }
      // .width('100%')


      Column(){

      }
      .width('50%')
      .aspectRatio(1)
      .backgroundColor(Color.Blue)
    }
    .height('100%')
  }
}