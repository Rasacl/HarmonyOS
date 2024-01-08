@Entry
@Component
struct ZhiHu {
  @State message: string = 'Hello World'

  build() {
    Column(){
      Navbar()
      CommentItem()
    }
  }
}

@Component
struct Navbar {
  build() {
    Row(){
      Row(){
        Image($r("app.media.ic_public_arrow_left"))
          .fillColor('#848484')
          .width(16)
          .aspectRatio(1)
      }
      .width(24)
      .aspectRatio(1)
      .backgroundColor('#f5f5f5')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .margin({
        left:15
      })
      Text('评论回复')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(18)
        .padding({
          right:39
        })
    }
    .height(40)
    .border({
      color:'#f4f4f4',
      width:{
        bottom:1
      }
    })
  }
}

@Component
struct CommentItem {
  build() {
    Row(){
      //左侧头像
      Image('/assets/404.jpg')
        .width(32)
        .aspectRatio(1)
        .borderRadius(16)

      //评论区
      Column({space:10}){
        Text('周杰伦')
          .fontWeight(FontWeight.Bold)
        Text("意大利拌面应该使用42号钢筋混凝土再加上量子力学缠绕最后通过不畏浮云遮望眼")
        .fontSize(16)
        .fontColor('#565656')
        .lineHeight(20)

        Row(){
          Text('10-21 .IP属地北京')
          .fontSize(12)
          .fontColor('#c3c4c5')
          Row(){
            Image($r("app.media.favoriteblock"))
              .width(12)
              .aspectRatio(1)
              .fillColor('#c3c4c5') //填充颜色，阿里图标下载的需要改图标 fill="currentColor"
              .margin({
                right:5
              })
            Text('100')
              .fontSize(12)
              .fontColor('#c3c4c5')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({
        left:10
      })

    }
    .padding(15)
    .alignItems(VerticalAlign.Top)
  }
}