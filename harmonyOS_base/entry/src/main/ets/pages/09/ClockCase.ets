import reminderAgentManager from '@ohos.reminderAgentManager'
@Entry
@Component
struct ClockCase {
  @State reminderId: number = 0

  build() {
    Row() {
      Column() {
        Button('发布闹铃')
          .onClick(async () => {
            let obj: reminderAgentManager.ReminderRequestAlarm  = {
              reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM, // 代理类型
              hour: 1, // 指明提醒的目标时刻
              minute: 33, // 指明提醒的目标分钟
              daysOfWeek: [], // 指明每周哪几天需要重复提醒
              ringDuration:80,  // 指明响铃时长（单位：秒）
            }
         this.reminderId = await reminderAgentManager.publishReminder(obj)  //没响铃之前可以取消
          })

        Button('取消闹铃')
          .onClick(() => {
            reminderAgentManager.cancelReminder(this.reminderId) //取消
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}