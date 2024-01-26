
import util from '@ohos.util'
import reminderAgentManager from '@ohos.reminderAgentManager'
import { ClockItemClass, MyClockStore } from './ClockStore'
import router from '@ohos.router'
@Entry
@Component
struct AddClock {
  clockStore: MyClockStore = new MyClockStore()
  @State
  currentDate: CurrentTime  =  {
    time: new Date()
  }
  @State currentClock: Partial<ClockItemClass> = {}
  // 添加闹铃
  async addClock () {
     const hour = this.currentDate.time.getHours()
     const minute = this.currentDate.time.getMinutes()

    const request: reminderAgentManager.ReminderRequestAlarm = {
      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM,
      hour: hour,
      minute: minute,
      title: '闹钟',
      ringDuration: 60
    }
    const list = await this.clockStore.getClockList()
    if(this.currentClock.id){
      // 编辑状态
      // 取消之前的闹钟，新增闹钟,存储首选项
      if(this.currentClock.reminderId){
        reminderAgentManager.cancelReminder(this.currentClock.reminderId)
      }
      const reminderId = await reminderAgentManager.publishReminder(request) //发布订阅
      this.currentClock.reminderId = reminderId
      this.currentClock.hour = hour
      this.currentClock.minute = minute
      const index = list.findIndex(item => item.id === this.currentClock.id)
      list.splice(index, 1, this.currentClock as ClockItemClass)
      this.clockStore.setClockList(JSON.stringify(list))
      router.back()
      return
    }
    let clock: ClockItemClass = {
      id: util.generateRandomUUID(),
      hour,
      minute,
      enabled: true
    }
    const reminderId = await reminderAgentManager.publishReminder(request) //发布订阅
    clock.reminderId = reminderId  // 记录id
    list.push(clock)
    this.clockStore.setClockList(JSON.stringify(list))
    router.back()
  }

  async delColok(){
    if(this.currentClock.id){
      if(this.currentClock.reminderId){
        reminderAgentManager.cancelReminder(this.currentClock.reminderId)
      }
      let list = await this.clockStore.getClockList()
      const  index = list.findIndex(item => item.id === this.currentClock.id)
      list.splice(index, 1)  //第一种
      // list = list.filter(item => item.id !== this.currentClock.id)
      this.clockStore.setClockList(JSON.stringify(list))
      router.back()
    }
  }

  async aboutToAppear(){
    //坑点， 如果不传参 params对象是个undefined
    const paramsObj = router.getParams() as ParamsClass
    if(paramsObj?.id){
      const list = await this.clockStore.getClockList()
      this.currentClock = list.find(item => item.id === paramsObj.id)  //记录目的是为了以后存储
      // 要把当前的闹钟的时分设置给时间选择器  整个arkts所有的更新都只能感知到第一层
      const date = new Date()
      date.setHours(this.currentClock.hour)
      date.setMinutes(this.currentClock.minute)
      this.currentDate.time = date  //只更新第一层
    }
  }

  build() {
    Navigation() {
      Column({ space: 15 }){
        TimePicker({
          selected: this.currentDate.time
        })
          .borderRadius(16)
          .clip(true)
          .onChange(value => {
            this.currentDate.time.setHours(value.hour)
            this.currentDate.time.setMinutes(value.minute)
          })

        Text('删除闹铃')
          .width(100)
          .height(40)
          .borderRadius(20)
          .backgroundColor('#c3c4c5')
          .textAlign(TextAlign.Center)
          .fontColor('#f00')
          .opacity(0.3)
          .onClick(() => {
            this.delColok()
          })
      }
      .padding(15)
    }
    .mode(NavigationMode.Stack)
    .title(this.currentClock.id ? '编辑闹钟' : "新建闹钟")
    .titleMode(NavigationTitleMode.Mini)
    .backgroundColor('#f5f5f5')
    .menus([
      { value: '', icon: '/assets/image/ic_confirm.png', action: () => {
        this.addClock()
      }}
    ])
  }
}

class CurrentTime  {
  time: Date = new Date()
}

class ParamsClass {
  id: string
}