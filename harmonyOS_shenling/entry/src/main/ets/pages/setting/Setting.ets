import { CardItem, Card, NavBar, Confirm } from '../../components'
import { TOKEN_KEY } from '../../constants'
import { UserSettingClass } from '../../utils'
import router from '@ohos.router'
@Entry
@Component
struct Setting {
  confirm:CustomDialogController = new CustomDialogController({
    builder: Confirm(
      {
        message: '确定要退出登录吗?',
        buttonList: [{
          text: '取消'
        },{
          text: '确定',
          fontColor: $r('app.color.primary'),
          action: () => {
            this.logout()
          }
        }]
      }
    ) ,//结构 CustomBuilder结构 可以穿组件结构
    alignment:DialogAlignment.Center,
    autoCancel:false,
    customStyle:true //自由设置样式-builder里面的样式才不会受到影响
  })

  logout () {
    // 删除token
    AppStorage.Set<string>(TOKEN_KEY, "")
    new UserSettingClass(getContext(this)).setUserToken("")
    router.replaceUrl({
      url: 'pages/login/Login'
    })
  }

  build() {
    Column(){
      NavBar({ title: '系统设置' })
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
          .onClick(() => {
            this.confirm.open() // 打开弹层
          })
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