@Preview
@CustomDialog
@Component
struct SelectCard {
  controller: CustomDialogController
  title: string = "请选择" // 显示标题
  showClose: boolean = true // 显示关闭按钮
  showButton: boolean = true // 显示底部按钮
  buttonText: string = "确定" // 底部按钮文本
  confirm: () => void = () => {}
  @BuilderParam
  cardContent: () => void // BuilderParam 修饰的函数给初始值的时候 必须给@Builder修饰的函数 但是实际传值的时候可以给普通的箭头函数
  build() {
    Column(){
      Row(){
        Text(this.title)
          .fontSize(16)
          .fontColor($r('app.color.text_primary'))
        if(this.showClose){
          Image($r('app.media.ic_btn_close'))
            .width(13)
            .aspectRatio(1)
            .onClick(() => {
              this.controller.close()
            })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .height(60)
      .borderRadius({
        topRight:16,
        topLeft:16
      })
      // 渲染内容
      if(this.cardContent) {
        this.cardContent()
      }
      if(this.showButton){
        Row(){
          Button(this.buttonText)
            .backgroundColor($r('app.color.primary'))
            .height(50)
            .width('80%')
            .onClick(() => {
              // 告诉外界我点了确定
              this.confirm()
              this.controller.close()
            })
        }
        .width('100%')
        .height(70)
        .backgroundColor($r('app.color.white'))
        .justifyContent(FlexAlign.Center)
      }
    }
    .backgroundColor($r('app.color.white'))
    .borderRadius({
      topRight:16,
      topLeft:16
    })
    .padding({
      left:21,
      right:21
    })
  }
}

export {SelectCard}