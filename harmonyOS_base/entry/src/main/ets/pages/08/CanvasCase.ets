// @ts-nocheck
@Entry
@Component
struct CanvasCase {
  // settings: RenderingContextSettings = new RenderingContextSettings(true)
  context: CanvasRenderingContext2D = new CanvasRenderingContext2D() // 显示声明 画笔对象
  @State widthSize:number = 0
  @State HeightSize:number = 0
  build() {
    Column({space:20}){
      Canvas(this.context)
        .width('100%')
        .aspectRatio(1.2)
        .backgroundColor(Color.Gray)
        .onReady(() => {
          // this.context.lineWidth = 4
          // this.context.strokeStyle = '#fff'
          // this.context.rect(0, 30, 100, 100)
          // this.context.stroke()  // 完成绘制，开始渲染
        })
      .onAreaChange((oldValue:Area, newValue: Area) => {
         this.widthSize = newValue.width
        this.HeightSize = newValue.height
      })

      Row({space:20}){
        Button('清除画布')
          .onClick(() => {
            this.context.clearRect(0,0, this.widthSize, this.HeightSize)
          })
        Button('画线')
          .onClick(() => {
            // 闭环隔离 开始绘制-结束绘制
            this.context.beginPath()
            this.context.lineWidth = 4
            this.context.strokeStyle = '#f40'
            this.context.moveTo(50,50)
            this.context.lineTo(250,200)
            this.context.stroke()
            this.context.closePath()

            this.context.beginPath()
            this.context.strokeStyle = '#980'
            this.context.moveTo(50,250)
            this.context.lineTo(250,250)
            this.context.stroke()
            this.context.closePath()
          })
        Button('画圆')
          .onClick(() => {
            this.context.beginPath()
            this.context.lineWidth = 6
            this.context.strokeStyle = '#3f4'
            this.context.arc(this.widthSize / 2, this.HeightSize / 2, 100, 0, 360)
            this.context.stroke() //只能绘制线框
            this.context.fillStyle = '#f50'
            this.context.fill()
            this.context.closePath()
          })
        Button('画矩形')
          .onClick(() => {
            this.context.beginPath()
            this.context.lineWidth = 4
            this.context.strokeStyle = '#fff'
            this.context.rect(100, 100, 100, 100)
            this.context.stroke()  // 完成绘制，开始渲染
            this.context.closePath()
          })
      }
    }
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}