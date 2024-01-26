import router from '@ohos.router'
import { ClockItemClass, MyClockStore } from './ClockStore'
import reminderAgentManager from '@ohos.reminderAgentManager'

@Entry
@Component
struct HuaweiClock {
  myStore: MyClockStore = new MyClockStore()
  @State list: ClockItemClass[] = []

  async onPageShow() {
    this.list = await this.myStore.getClockList()
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 15 }) {
        Text('闹钟')
          .fontSize('24')
          .width('100%')
        CanvasClock() //放置表盘

        List({ space: 20 }) {
          ForEach(this.list, (item: ClockItemClass) => {
            ListItem() {
              ClockItem({
                item,
                changeClockEnable: async (id: string) => {
                  const index = this.list.findIndex(item => item.id === id)
                  if (item.enabled) {
                    reminderAgentManager.cancelReminder(item.reminderId)
                  } else {
                    // 还得加上
                    let reminderObj: reminderAgentManager.ReminderRequestAlarm = {
                      hour: item.hour,
                      minute: item.minute,
                      daysOfWeek: [],
                      ringDuration: 60,
                      // 提醒类型为闹钟类型
                      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM
                    }
                    const reminderId = await reminderAgentManager.publishReminder(reminderObj)
                    item.reminderId = reminderId
                  }
                  item.enabled = !item.enabled
                  this.list.splice(index, 1)
                  this.list.splice(index, 0, item)
                  this.myStore.setClockList(JSON.stringify(this.list))
                }
              })
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/09/AddClock',
                    params: {
                      id: item.id
                    }
                  })
                })
            }

          })
        }
      }
      .padding(15)
      .height('100%')
      .width('100%')
      .backgroundColor('#f5f5f5')


      // 添加
      Text('+')
        .width(50)
        .aspectRatio(1)
        .backgroundColor('#06f')
        .fontSize(40)
        .fontWeight(100)
        .fontColor('#fff')
        .borderRadius(25)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 50 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/09/AddClock'
          })
        })
    }
  }
}
// 时钟组件 主要目的是画表盘
@Component
struct CanvasClock {
  canvasSize: number = 252
  panImage: ImageBitmap = new ImageBitmap('/assets/image/ic_clock_pan.png')
  hourImage: ImageBitmap = new ImageBitmap('/assets/image/ic_hour_pointer.png')
  minuteImage: ImageBitmap = new ImageBitmap('/assets/image/ic_minute_pointer.png')
  secondImage: ImageBitmap = new ImageBitmap('/assets/image/ic_second_pointer.png')
  timer: number = 0
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  drawClock() {
    this.timer = setInterval(() => {
      this.context.clearRect(0, 0, this.canvasSize, this.canvasSize)
      this.context.drawImage(this.panImage, 0, 0, this.canvasSize, this.canvasSize)
      const currentTime = new Date() // 获取当前时间
      const hourAngle = currentTime.getHours() % 12 / 12 * 360 + currentTime.getMinutes() / 60 * 30 // 时针转的弧度
      const minAngle = currentTime.getMinutes() / 60 * 360 + currentTime.getSeconds() / 60 * 6 // 分针转的弧度
      const secondAngle = currentTime.getSeconds() / 60 * 360 // 秒针转的弧度
      this.drawPointer(hourAngle, this.hourImage)
      this.drawPointer(minAngle, this.minuteImage)
      this.drawPointer(secondAngle, this.secondImage)
    }, 1000)
  }

  aboutToDisappear() {
    clearInterval(this.timer)
  }

  drawPointer(angle: number, img: ImageBitmap) {
    this.context.save() //保存路径
    this.context.translate(this.canvasSize / 2, this.canvasSize / 2) // 移动画布原点到表盘中央
    this.context.rotate((angle + 180) * Math.PI / 180) // 旋转180度的弧度 让图片能够指向12点
    this.context.translate(-this.canvasSize / 2, -this.canvasSize / 2) // 将原点挪回左上角 按照正常的思路画图
    this.context.drawImage(img, this.canvasSize / 2 - 4, 0, 8, this.canvasSize)
    this.context.restore() // 回复画布设置
  }

  build() {
    Canvas(this.context)
      .width(252)
      .aspectRatio(1)
      .onReady(() => {
        this.drawClock()
      })
  }
}

@Component
export struct ClockItem {
  item: Partial<ClockItemClass> = {}
  changeClockEnable: (id: string) => void = () => {
  }

  build() {
    Row() {
      Column({ space: 5 }) {
        Row({ space: 5 }) {
          Text(`${this.item.hour > 12 ? '下午' : '上午'}`)
            .fontColor('#666')
          Text(`${this.item.hour}:${this.item.minute}`)
            .fontWeight(600)
            .fontSize(18)
        }

        Row({ space: 15 }) {
          Text('闹钟')
            .fontColor('#999')
            .fontSize(14)
          Text('不重复')
            .fontColor('#999')
            .fontSize(14)
        }
      }
      .alignItems(HorizontalAlign.Start)

      // 开关
      Toggle({ type: ToggleType.Switch, isOn: this.item.enabled })
        .onChange(() => {
          // 只要值发生变化就要有所操作
          this.changeClockEnable(this.item.id)
        })
    }
    .height(64)
    .padding({ left: 20, right: 15 })
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(30)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}