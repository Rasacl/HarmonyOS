@Component
struct CardItem {
  leftTitle:string = ''
  @Prop rightText:string
  showRightIcon: boolean = true
  showBottomBorder: boolean = true
  onRightClick: () => void = () => {}
  build() {
    // row组件默认垂直方向居中
    Row(){
      Text(this.leftTitle).fontSize(16).fontWeight(400).fontColor($r('app.color.text_primary')).layoutWeight(1).textOverflow({
        overflow:TextOverflow.Ellipsis
      })
      .maxLines(1)
      Row(){
        if(this.rightText){
          Text(this.rightText).fontColor($r("app.color.text_secondary")).fontWeight(400).fontSize(14)
        }
        if (this.showRightIcon) {
          Image($r("app.media.ic_btn_more")).width(24).height(24)
        }
      }
      .onClick(() => {
        this.onRightClick()
      })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .border({
      width: {
        bottom: this.showBottomBorder ? 1 : 0
      },
      color: $r('app.color.background_divider')
    })
    .width('100%')
    .height(60)
    .alignItems(VerticalAlign.Center)
  }
}

export {CardItem}