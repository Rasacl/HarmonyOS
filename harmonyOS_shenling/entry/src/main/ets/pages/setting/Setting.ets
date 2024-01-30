import { CardItem, Card } from '../../components'
@Entry
@Component
struct Setting {
  @State message: string = 'Hello World'

  build() {
    Column(){
      Card(){
        CardItem({ leftTitle: '换绑手机', rightText: '' })
        CardItem({ leftTitle: '修改密码', rightText: '' })
        CardItem({ leftTitle: '消息通知设置', rightText: '' })
        CardItem({ leftTitle: '清理缓存', rightText: '', showBottomBorder: false })
      }
      Row(){
        Button('退出', {type:ButtonType.Normal})
          .backgroundColor($r('app.color.white'))
          .fontColor($r("app.color.text_primary"))
          .width('100%')
          .borderRadius(8)
          .height(60)
      }
      .width('100%')
      .margin({
        top: 20
      })
      .padding({
        left: 15,
        right: 15
      })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.background_page'))
  }
}