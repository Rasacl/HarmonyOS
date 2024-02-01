@Preview
@Component
struct CheckBox {
  title:string = '车辆违章'
  confirmText:string = '是'
  cancelTexT:string = '否'
  @Prop
  value: boolean
  checkChange: (value: boolean) => void = () => {}
  build() {
    Row(){
      Row(){
        Text(this.title)
          .fontSize(14)
          .fontColor($r('app.color.text_primary'))
        Row({space:20}){
          Row(){
            Image(this.value ? $r('app.media.ic_radio_true'): $r('app.media.ic_radio_false'))
              .width(32)
              .aspectRatio(1)
            Text(this.confirmText)
              .fontColor($r('app.color.text_placeholder'))
          }
          .onClick(() => {
            this.value = true
            this.checkChange(this.value)
          })

          Row(){
            Image(!this.value ? $r('app.media.ic_radio_true'): $r('app.media.ic_radio_false'))
              .width(32)
              .aspectRatio(1)
            Text(this.cancelTexT)
              .fontColor($r('app.color.text_placeholder'))
          }
          .onClick(() => {
            this.value = false
            this.checkChange(this.value)
          })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .height(60)
      .borderRadius(10)
      .padding({
        left:15,
        right:15
      })
      .backgroundColor($r('app.color.white'))
    }
    .width('100%')
    .padding({
      left:15,
      right:15
    })
    .margin({
      top:15
    })
  }
}

export {CheckBox}