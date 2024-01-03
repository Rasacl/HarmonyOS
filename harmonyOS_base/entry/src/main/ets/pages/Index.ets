@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    // 它的子组件都会以纵向方式排列
   Column(){
     Header()
     main()
     footer()
   }
  }
}

@Component
struct Header {
  build() {
    Row(){
      Text('Header')
    }
      .width('100%')
      .height("8%")
      .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct main {
  build() {
    Row(){
      Text('Main')
        .fontColor(Color.White)
    }
    .width('100%')
    .height('82%')
    .backgroundColor(Color.Blue)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct footer {
  build() {
    Row(){
      Text('footer')
        .fontColor(Color.White)
    }
    .width('100%')
    .height("10%")
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)

  }
}