import { AdvertClass } from '../../models/advert'
import { UserSettingClass } from '../../utils/setting'
import router from '@ohos.router'
@Entry
@Component
struct Start {
  userSetting:UserSettingClass = new UserSettingClass(getContext(this))
  @State adObj:AdvertClass = {
    showAd:false,
    adTime:5,
    adImg:''
  }
  timer:number = -1
  async aboutToAppear(){
    this.adObj = await this.userSetting.getUserAd()
    this.timer = setInterval(() => {
      if(this.adObj.adTime === 0){
        clearInterval(this.timer)
        router.replaceUrl({
          url:'pages/Index'
        })
        return
      }
      this.adObj.adTime--
    },1000)
  }
  aboutToDisappear(){
    clearInterval(this.timer)
  }

  build() {
    Stack({alignContent:Alignment.TopEnd}){
      Image(this.adObj.adImg)
        .objectFit(ImageFit.Cover)
      // 倒计时文本
      Text(`${this.adObj.adTime}s后跳过`)
        .padding({
          left:10,
          right:10
        })
        .margin({
          top:10,
          right:10,
        })
        .height(30)
        .fontSize(14)
        .borderRadius(15)
        .backgroundColor($r('app.color.background_page'))
        .textAlign(TextAlign.Center)
        .onClick(() => {
          router.replaceUrl({
            url:'pages/Index'
          })
        })
    }
    .width('100%')
    .height('100%')
  }
}