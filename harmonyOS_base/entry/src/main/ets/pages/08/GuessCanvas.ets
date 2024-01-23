class PointClass {
  X:number = 0
  Y:number = 0
  reset?:boolean = false // 是否重新开始一段路径
}
@Entry
@Component
struct GuessCanvas {
  private settings:RenderingContextSettings = new RenderingContextSettings(true)
  private context:CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private GuessContext:CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  drawing:boolean = false
  // 上一次坐标记录
  lastX:number = 0
  lastY:number = 0
  pointList:PointClass[] = [  ]

  @State imgUrl:string = '' // 用来存储签名的图片
  gLastX: number = 0
  gLastY: number = 0
  timer: number = -1
  drawLine(x:number, y:number){
    this.context.moveTo(this.lastX, this.lastY)
    this.context.lineTo(x,y)
    this.lastX = x
    this.lastY = y
    this.context.stroke()
  }
  // 开始绘制下面裁的画布
  drawGuess(){
    if (this.pointList.length && this.timer === -1) {
      this.timer = setInterval(() => {
        if (this.pointList.length === 0) {
          clearInterval(this.timer)
          this.timer = -1
          return
        }
        let p: PointClass = this.pointList.shift()
        this.guessLine(p)
      }, 100)
    }
  }

  guessLine(p: PointClass) {
    if (p.reset) {
      this.GuessContext.closePath()
      this.GuessContext.beginPath()
      this.gLastX = p.X
      this.gLastY = p.Y
    } else {
      this.GuessContext.moveTo(this.gLastX, this.gLastY) // 先将线移动到上一个点
      this.GuessContext.lineTo(p.X, p.Y)
      this.gLastX = p.X // 将当前内容的x记录
      this.gLastY = p.Y // 将当前的y记录
      this.GuessContext.stroke()
    }
  }

  build() {
    Scroll(){
      Column({ space: 20 }) {
        Canvas(this.context)
          .width('100%')
          .aspectRatio(1.2)
          .backgroundColor(Color.Gray)
          .onReady(() => {
            this.context.lineWidth = 4
            this.context.strokeStyle = "#000"
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              // 开始绘画
              this.drawing = true
              this.lastX = event.touches[0].x
              this.lastY = event.touches[0].y
              this.context.beginPath()
              //开始记录坐标点
              this.pointList.push({
                X: this.lastX,
                Y: this.lastY ,
                reset: true
              })
            }
            if (event.type === TouchType.Up) {
              // 结束绘画
              this.drawing = false
              this.context.closePath()
              // 一旦结束 就让下方画布作图
              this.drawGuess()
            }
            if (event.type === TouchType.Move) {
              // 进行绘画
              if (this.drawing) {
                this.drawLine(event.touches[0].x, event.touches[0].y)
                // 记录移动的坐标点
                this.pointList.push({
                  X: event.touches[0].x,
                  Y: event.touches[0].y,
                  reset: false
                })
              }
            }
          })

        Canvas(this.GuessContext)
          .width('100%')
          .aspectRatio(1.2)
          .backgroundColor(Color.Red)
          .onReady(() => {
            this.GuessContext.lineWidth = 4
            this.GuessContext.strokeStyle = "#fff"
          })

        Row({space:20}){
          Button('签字版保存')
            .onClick(() => {
              this.imgUrl = this.context.toDataURL('image/png')
            })

          Button('清空')
            .onClick(() => {
              this.context.clearRect(0, 0, 360, 300)
              this.GuessContext.clearRect(0, 0, 360, 300)
              this.pointList = []
            })
        }
        if(this.imgUrl){
          Image(this.imgUrl).width('100%').aspectRatio(1.2)
        }
      }
    }

  }
}
