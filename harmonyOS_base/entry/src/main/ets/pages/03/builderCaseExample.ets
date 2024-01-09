@Entry
@Component
struct builderCaseExample {
  @State message: string = 'Hello World'

  build() {
    Column() {
      HmCard() {
        HmCardItem({ leftTitle: '员工姓名', rightValue: '张三' })
        HmCardItem({ leftTitle: '员工编号', rightValue: '30032' })
        HmCardItem({ leftTitle: '员工权限', rightValue: '普通' })
        HmCardItem({ leftTitle: '员工组织', rightValue: '研发部' })
        HmCardItem({ leftTitle: '员工上级', rightValue: '老高' })
      }
    }
    .height('100%')
    .backgroundColor("#ccc")
  }
}

@Component
struct HmCard {
  @BuilderParam
  CardFn: () => void
  build() {
    Column() {
      Column() {
        if(this.CardFn) {
          this.CardFn()
        }
      }.borderRadius(8)
      .backgroundColor(Color.White)

    }.padding({
      left: 15,
      right: 15
    })
    .margin({
      top: 10
    })


  }
}
@Component
struct HmCardItem {
  leftTitle: string = ''
  rightValue: string = ''
  build() {
    Row() {
      Text(this.leftTitle)
      Text(this.rightValue).fontColor("#ccc")
    }.width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 10,
      right: 10
    })
    .height(50)
    .border({
      width: {
        bottom: 1
      },
      color: '#f4f5f6'
    })
  }
}