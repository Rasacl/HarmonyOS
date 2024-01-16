import http from '@ohos.net.http'

@Entry
@Component
struct HttpCase {
  aboutToAppear() {
    this.getMeiTuanData()
  }

  async getMeiTuanData() {
    try {
      const req = http.createHttp()
      const res = await req.request(" https://zhoushugang.gitee.io/fe2022/takeaway.json")
      AlertDialog.show({
        message: JSON.parse(res.result as string)
      })
    } catch (e) {
      AlertDialog.show({
        message: e as string
      })
    }

  }

  build() {
    Row() {
      Column() {

      }
      .width('100%')
    }
    .height('100%')
  }
}