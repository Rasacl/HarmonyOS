import { NavBar, Card, CardItem } from '../../components'
import geoLocationManager from '@ohos.geoLocationManager'
import web_webview from '@ohos.web.webview'
import {WebSdkClass} from '../../utils'
import {AddressItem} from '../../models'
import router from '@ohos.router'
@Entry
@Component
struct SelectLocation {
  @State
  list: AddressItem[] = []
  //第一种通信方式
  // messagePorts:web_webview.WebMessagePort[] = []
  //第二种通信方式
  webSDK:WebSdkClass = new WebSdkClass()
  // webController: web_webview.WebviewController = new web_webview.WebviewController()
  // 需要先去去module.json5里面获取经纬度权限
  aboutToAppear() {
    // this.getLocation()
    WebSdkClass.Controller = new web_webview.WebviewController
    WebSdkClass.Context = getContext(this)
    WebSdkClass.Context.eventHub.on('search_list', (json: string) => {
      this.list = JSON.parse(json) as AddressItem[]
    })
  }
  aboutToDisappear(){
    // 释放资源
    WebSdkClass.Context.eventHub.off("search_list")
    WebSdkClass.Controller = null
    WebSdkClass.Context = null
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
  //创建窗口
  // createPorts(){
  //   this.messagePorts = this.webController.createWebMessagePorts()
  //   //两个端口 一个是原生自己用 一个要传递给html用
  //   this.messagePorts[1].onMessageEvent((msg) => {
  //     if(typeof msg === 'string') {
  //       const data = JSON.parse(msg)
  //       if(data.type === 'connect_ok'){
  //         AlertDialog.show({ message: '双向通信建立成功' })
  //       }
  //     }
  //   })
  //   this.webController.postMessage("__init_port__", [this.messagePorts[0]], "*")
  // }
  build() {
    Column() {
      NavBar({ title: '当前位置' })
      //  地图区域
      Web({ src: $rawfile('location.html'), controller: WebSdkClass.Controller! })
        .height('100%')
      .javaScriptProxy({
        object:this.webSDK,
        name:'shenling',
        methodList:['alert', 'toast', 'getLocation','receiveData'],
        controller:WebSdkClass.Controller!
      })
        // .onPageEnd(() => {
        //    this.createPorts()
        // })
      Column() {
        Card() {
          ForEach(this.list, (item: AddressItem) => {
            CardItem({ leftTitle: item.address, rightText: item.distance ? `${item.distance}米` : '' })
              .onClick(() => {
                router.back({
                  url: "pages/exception/ExceptionReport",
                  params: {
                    address: item.address.substring(0, 7)
                  }
                })
              })
          })
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