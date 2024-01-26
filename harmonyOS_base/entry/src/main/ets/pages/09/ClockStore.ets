import preferences from '@ohos.data.preferences'

export class ClockItemClass {
  hour: number = 0
  minute: number = 0
  id: string = ""
  reminderId?: number = 0 // 后台任务提醒id
  enabled: boolean = false
}
export class MyClockStore {
  getStore() {
    return preferences.getPreferences(getContext(this), 'clockStore')
  }
  async getClockList() {
    const store = await this.getStore()
    const data = await store.get("clock_table", "[]") as string
    return JSON.parse(data) as ClockItemClass[]
  }
  async setClockList (json: string) {
    const store = await this.getStore()
    await store.put("clock_table", json)
    await store.flush()
  }
}