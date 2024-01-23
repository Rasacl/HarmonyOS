@Entry
@Component
struct HeartCase {
  @State
  scaleValue: number = 1
  @State
  animationObj: AnimateParam = {
    duration: 500,
    playMode: PlayMode.Alternate,
    iterations: -1
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        Column() {
          Image($r('app.media.favoriteblock'))
            .width(60)
            .height(60)
            .fillColor(Color.Red)
            .scale({ x: this.scaleValue, y: this.scaleValue })
            .animation(this.animationObj)
        }.height(120)

        Button(this.scaleValue === 3 ? "结束心跳" : "开始心跳")
          .onClick(() => {
            if(this.scaleValue === 3) {
              // 清理
              this.scaleValue = 1
              this.animationObj = {
                duration: 0,
              }
            }else {
              this.scaleValue = 3
              this.animationObj = {
                duration: 500,
                playMode: PlayMode.Alternate,
                iterations: -1
              }
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}