import router from '@ohos.router'
class RouterParams {
  id: number = 0
}
@Entry
@Component
struct HmDetail {
  @State
  detailId: number = 0
  aboutToAppear() {
    const params = router.getParams() as RouterParams
    if(params?.id) {
      this.detailId = params?.id
    }
  }
  build() {
    Column() {
      Row() {
        Text("详情页")
          .width('100%')
          .textAlign(TextAlign.Center)

      }.height(40)
      .border({
        color: '#f3f4f5',
        width: {
          bottom: 1
        }
      })

      Column({ space: 20 }){
        Text("详情页" + this.detailId)
          .fontSize(50)
        Button("返回列表页")
          .onClick(() => {
            router.back()
          })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

    }
    .height('100%')
  }
}