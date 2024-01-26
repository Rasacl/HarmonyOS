import router from '@ohos.router'
@Entry
@Component
struct MainNav {
  @State
  routes: RouterClass[] = [{
    title: '知乎案例',
    url: 'pages/02/ZhiHu'
  },
    {
      title: '美团案例',
      url: 'pages/05/MTIndex'
    },
    {
      title: '抖音案例',
      url: 'pages/07/DouyinCase'
    },
    {
      title: '你画我猜案例',
      url: "pages/08/GuessCanvas"
    },
    {
      title: '聊天机器人',
      url: 'pages/08/PreferencesCase'
    },
    {
      title: '发布闹铃',
      url: 'pages/09/ClockCase'
    },
    {
      title: '华为时钟',
      url: "pages/09/huaweiClock"
    }
  ]

  build() {
    List({ space: 20 }) {
      // 循环
      ForEach(this.routes, (item: RouterClass) => {
        ListItem() {
          Row() {
            Button(item.title)
              .onClick(() => {
                if(item.url) {
                  router.pushUrl({
                    url: item.url
                  })
                }
              })
              .width('100%')
          }
          .width('100%')
          .height(100)
          .borderRadius(8)
          .padding(20)
        }
      })
    }
  }
}
// 数组-》 title- url

class RouterClass {
  title: string = ""
  url: string = ""
}