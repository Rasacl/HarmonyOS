class CardClass {
  time: string = ""
  location: string = ""
  type: string = ""
}
class CellParams {
  leftTitle: string = ""
  rightValue: string = ""
}
@Entry
@Component
struct BuilderCase02 {
  @State formData: CardClass = {
    time: "2023-12-12",
    location: '回龙观',
    type: '漏油'
  }

  @Builder
  getCellContent($$: CellParams) {
    Row() {
      Row() {
        Text($$.leftTitle)
        Text($$.rightValue)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: 15,
        right: 15
      })
      .borderRadius(8)
      .height(40)
      .backgroundColor(Color.White)
    }.padding({
      left: 10,
      right: 10
    })

  }
  build() {
    Row() {
      Column({space:10}) {
        this.getCellContent({ leftTitle: '异常时间', rightValue: this.formData.time })
        this.getCellContent({ leftTitle: '异常位置', rightValue: this.formData.location })
        this.getCellContent({ leftTitle: '异常类型', rightValue: this.formData.type })
        Button("修改数据").onClick(() => {
          this.formData.location = "望京"
        })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#ccc')
  }
}

@Builder function getCellContent($$:CellParams){
  Row() {
    Row() {
      Text($$.leftTitle)
      Text($$.rightValue)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 15,
      right: 15
    })
    .borderRadius(8)
    .height(40)
    .backgroundColor(Color.White)
  }.padding({
    left: 10,
    right: 10
  })
}