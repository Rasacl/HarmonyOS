//全局的样式复用 没啥用 不能导出 导出也没有办法用
@Styles function textStyle(){
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
}

@Entry
@Component
struct StylesCaseOne {
  //局部的样式复用 权重比全局高 只能设置通用属性
  @Styles textStyle(){
    .width(120)
    .height(60)
    .borderRadius(30)
    .backgroundColor(Color.Gray)
  }
  build() {
    Row() {
      Column({space:20}) {
        Text('测试')
          .textStyle()
          .textAlign(TextAlign.Center)
          .fontSize(20)

        Text('测试2')
          .textStyle()
          .textAlign(TextAlign.Center)
          .fontSize(20)
      }
      .width('100%')
    }
    .height('100%')
  }
}