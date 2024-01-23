@Entry
@Component
struct ACase {

  @State
  showImage: boolean = false
  build() {
    Row() {
      Column({ space: 20 }) {
        Row() {
          if(this.showImage) {
            Image($r("app.media.handsome"))
              .width(200)
              .aspectRatio(1)
              .borderRadius(100)
              .transition({
                type: TransitionType.Insert,
                translate: {
                  x: '-100%'
                },
                rotate: {
                  angle: -360
                },
                opacity: 0
              })
              .transition({
                type: TransitionType.Delete,
                translate: {
                  x: '100%'
                },
                rotate: {
                  angle: 360
                },
                opacity: 0
              })
          }
        }.height(200)

        Button("图片显示/隐藏")
          .onClick(() => {
            animateTo({ duration: 1000 } , () => {
              this.showImage = !this.showImage
            })
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}