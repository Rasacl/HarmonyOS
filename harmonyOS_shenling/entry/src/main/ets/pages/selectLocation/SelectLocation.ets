import { NavBar, Card, CardItem } from '../../components'
import geoLocationManager from '@ohos.geoLocationManager'
import web_webview from '@ohos.web.webview'

@Entry
@Component
struct SelectLocation {
  controller: web_webview.WebviewController = new web_webview.WebviewController()
  // 需要先去去module.json5里面获取经纬度权限
  aboutToAppear() {
    this.getLocation()
  }
  async getLocation () {
    try {
      const result = await geoLocationManager.getCurrentLocation()
      AlertDialog.show({
        message: JSON.stringify(result)
      })
    }catch (error) {
      AlertDialog.show({
        message: error.message
      })
    }

  }
  build() {
    Column() {
      NavBar({ title: '当前位置' })
      //  地图区域
      Web({ src: $rawfile('location.html'), controller: this.controller }).height('100%')
      Column() {
        Card() {
          CardItem({ leftTitle: '回龙观街道', rightText: '100m以内' })
          CardItem({ leftTitle: '金燕龙科研楼', rightText: '100m以内' })
          CardItem({ leftTitle: '春野画室', rightText: '100m以内' })
          CardItem({ leftTitle: '光滑时代(金艳龙科研楼店)', rightText: '100m以内' })
        }
      }.position({
        y: '100%'
      }).translate({
        y: -260
      })

    }
    .height('100%').backgroundColor($r('app.color.background_page'))
  }
}