import preferences from '@ohos.data.preferences'
import http from '@ohos.net.http'
import util from '@ohos.util'
import promptAction from '@ohos.promptAction'
import notificationManager from '@ohos.notificationManager'
import wantAgent from '@ohos.app.ability.wantAgent'

@Entry
@Component
struct ChatMessage {
  @State
  contentStr: string = ""
  @State
  @Watch("updateMess")
  messList: MessageItem[] = []
  messStore: MessageStore = new MessageStore()
  scroller: Scroller = new Scroller()
  @State
  sendIng: boolean = false
  @State topY:number = 0

  aboutToAppear() {
    this.getMess()
  }

  updateMess() {
    this.messStore.setMessageList(JSON.stringify(this.messList))
  }

  async getMess() {
    this.messList = await this.messStore.getMessageList()
  }

  async sendMessage() {
    if (!this.contentStr) return
    this.sendIng = true
    const req = http.createHttp()
    let selfMessage: MessageItem = {
      id: util.generateRandomUUID(),
      timestamp: Date.now(),
      content: this.contentStr,
      avatar: $r('app.media.handsome'),
      username: '老高',
      self: true
    }
    this.messList.push(selfMessage)
    this.scroller.scrollToIndex(this.messList.length - 1)
    const url = `http://api.qingyunke.com/api.php?key=free&appid=0&msg=${encodeURI(this.contentStr)}`
    this.contentStr = "" // 清空内容
    console.log("my_log", url)
    const res = await req.request(url)
    const result = JSON.parse(res.result as string) as ResultClass
    this.sendIng = false
    if (result.result === 0) {
      let wantAgentInfo = {
        wants: [
          {
            deviceId: '',
            bundleName: 'com.example.harmonyos_base', //包名
            abilityName: 'Test_abilityAbility',
            moduleName:'Test_ability', // 模块名称
            parameters: {
              order_id:Date.now()
            }
          }
        ],
        operationType: wantAgent.OperationType.START_ABILITY,
        requestCode: 0,
        // wantAgentFlags:[wantAgent.WantAgentFlags.CONSTANT_FLAG]
      }
      // 需要声明wantAgent对象
      let wantAgentObj = await wantAgent.getWantAgent(wantAgentInfo)
      //给手机应用发送一条通知
      let req: notificationManager.NotificationRequest = {
        id:Date.now(),
        content:{
          contentType:notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: '你一条新的消息',
            text: result.content,
            additionalText: '如花的信息',
          }
        },
        wantAgent: wantAgentObj,
      }
      notificationManager.publish(req)
      // 回复成功
      let message: MessageItem = {
        id: util.generateRandomUUID(),
        timestamp: Date.now(),
        content: result.content,
        avatar: $r("app.media.cart"),
        username: '老婆大人',
        self: false
      }
      this.messList.push(message)
      this.scroller.scrollToIndex(this.messList.length - 1)

    } else {
      promptAction.showToast({
        message: result.content
      })
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Text("🙉 大哥")
            .fontSize(18)
        }
        .width('100%')
        .height(50)
        .justifyContent(FlexAlign.Center)

        List({ space: 20, scroller: this.scroller }) {
          ForEach(this.messList, (item: MessageItem) => {
            ListItem() {
              // 一左一右
              MessageCom({ item, delMessage: (id: string) => {
                // 删除消息
                const index = this.messList.findIndex(item => item.id === id)
                this.messList.splice(index, 1)
              } })
            }
          })
        }
        .padding({
          bottom: 80
        })
        .layoutWeight(1)
      }.height('100%').position({
        y:this.topY
      })

      // 消息列表
      Row({ space: 20 }) {
        TextInput({ text: this.contentStr })
          .layoutWeight(1)
          .backgroundColor(Color.White)
          .borderRadius(2)
          .height(40)
          .onChange((value) => {
            this.contentStr = value
          })
          .onSubmit(() => {
            if (this.contentStr) {
              this.sendMessage()
            }
          })
        Button() {
          Row() {
            if (this.sendIng) {
              LoadingProgress()
                .width(20)
                .height(20)
                .color('#fff')
                .margin({
                  right: 4
                })
            } else {
              Text("发送")
                .fontColor("#fff")
            }
          }
        }
        .onClick(async () => {
          if (!this.sendIng) {
            await this.sendMessage()
          }
        })
        .enabled(!!this.contentStr)
        .height(30)
        .width(60)
      }
      .width('100%')
      .backgroundColor('#f6f6f6')
      .height(70)
      .padding({
        left: 10,
        right: 10
      })
    }
    .onAreaChange((oldArea:Area, newArea:Area) => {
      this.topY = Math.abs(parseFloat(newArea.globalPosition.y.toString()))
    })
    .backgroundColor('#ededed')
    .height('100%')
  }
}

@Component
struct MessageCom {
  item: Partial<MessageItem> = {}
  @State
  showMenu: boolean = false
  delMessage: (id: string) => void = () => {
  }

  @Builder
  getDelContent() {
    Button("删除")
      .backgroundColor(Color.White)
      .fontColor("#0c2803")
      .height(30)
      .onClick(() => {
        this.delMessage(this.item.id)
      })
  }

  build() {
    Row() {
      Image(this.item.avatar)
        .height(40)
        .width(40)
        .borderRadius(6)
      Row() {
        Text(this.item.content)
          .backgroundColor(this.item.self ? "#8bec73" : Color.White)
          .fontColor("#0c2803")
          .padding(10)
          .lineHeight(24)
          .margin({
            left: 10,
            right: 10
          })
          .borderRadius(5)
          .gesture(
            LongPressGesture()
              .onAction(() => {
                this.showMenu = true // 显示菜单
              })
          )
          .bindPopup(this.showMenu, {
            builder: this.getDelContent,
            placement: Placement.Top,
            onStateChange: (event) => {
              this.showMenu = event.isVisible
            }
          })
      }.layoutWeight(5)
      .justifyContent(this.item.self ? FlexAlign.End : FlexAlign.Start)

      Text().layoutWeight(1)
    }
    .width('100%')
    .padding({
      left: 20,
      right: 20
    })
    .alignItems(VerticalAlign.Top)
    .direction(this.item.self ? Direction.Rtl : Direction.Ltr)
  }
}


export class ResultClass {
  result: number = 0
  content: string = ""
}

export class MessageItem {
  content: string = "" // 消息内容
  avatar: ResourceStr = "" // 用户头像
  username: string = "" // 用户名称
  self: boolean = false // 是不是用户自己
  timestamp: number = 0 // 消息收到时的时间戳
  id: string = "" // 唯一的id
}

export class MessageStore {
  KEY = 'message_list'

  getStore() {
    return preferences.getPreferences(getContext(this), 'my_message_store')
  }

  async getMessageList() {
    const store = await this.getStore()
    const data = await store.get(this.KEY, '[]') as string
    return JSON.parse(data) as MessageItem[]
  }

  async setMessageList(json: string) {
    const store = await this.getStore()
    await store.put(this.KEY, json)
    await store.flush()
  }
}