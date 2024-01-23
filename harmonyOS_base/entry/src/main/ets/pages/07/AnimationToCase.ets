@Entry
@Component
struct AnimationToCase {
  @State showColumn: boolean = false

  build() {
    Row() {
      Column({ space: 20 }) {
        Column(){
          if(this.showColumn) {
            Column(){
              Text("元素内容")
                .fontSize(40)
                .fontColor(Color.White)
            }.width('100%')
            .height(100)
            .backgroundColor(Color.Blue)
            .transition({
              opacity: 0,
              type: TransitionType.All
            })
          }
        }.height(100)

        Button("显示/隐藏")
          .onClick(() => {
            animateTo({ duration: 1000 }, () => {
              if(this.showColumn) {
                this.showColumn = false
              }else {
                this.showColumn = true
              }

            })

          })
      }
      .width('100%')
    }
    .height('100%')
  }
}