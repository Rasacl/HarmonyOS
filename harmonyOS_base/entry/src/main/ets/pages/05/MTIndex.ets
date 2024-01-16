@Entry
@Component
struct MTIndex {
  @State showCar:boolean = false
  build() {
    //堆叠布局 后一个元素会盖在前一个元素上
    Stack({alignContent:Alignment.Bottom}){
      // 主内容区组件
      MTMain()
      //购物车组件
      if(this.showCar){
        MTCar()
      }
      //底部组件
      MTBottom({showCar:$showCar})
    }
    .height('100%')
  }
}

// 主内容区组件
@Component
struct MTMain {
  build() {
    Column(){

    }
    .backgroundColor(Color.Gray)
    .height('100%')
    .width('100%')
  }
}

//底部组件
@Component
struct MTBottom {
  @Link showCar:boolean
  build() {
    Row(){
      Row(){
        //徽标组件
        Badge(
          {
            value:'0',
            position:BadgePosition.Right,
            style:{
               badgeSize:18
            }
          }
        ){
          //要显示的结构是什么
          Image($r('app.media.cart'))
            .width(47)
            .height(69)
            .position({
              y:-14
            })

        }
        .width(50)
        .height(50)
        .margin({
          left:25,
          right:10
        })
        //右侧 配送费
        Column(){
          Text(){
            Span('￥')
              .fontColor('#fff')
            Span('0.00')
              .fontSize(24)
              .fontColor('#fff')
          }
          //底部
          Text('预估另需配送费￥5元')
            .fontSize(12)
            .fontColor('#999')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        //结算按钮
        Text('去结算')
          .backgroundColor('#f8c74e')
          .borderRadius({
            topRight:30,
            bottomRight:30
          })
          .height(60)
          .padding({
            left:15,
            right:15
          })
      }
      .height(60)
      .width('100%')
      .backgroundColor('#222426')
      .borderRadius(30)
      .onClick(() => {
        this.showCar = !this.showCar
      })

    }
    .width('100%')
    .padding({
      left:20,
      right:20,
      bottom:20
    })
  }
}

//购物车组件
@Component
struct MTCar {
  build() {
    Column(){

    }
    .height('50%')
    .width('100%')
    .backgroundColor(Color.Blue)
  }
}