@Entry
@Component
struct BuilderParamCase {
@Builder renderButton() {
  Text('哈哈哈哈')
    .fontSize(24)
    .fontColor(Color.Red)
}

  build() {
    Row() {
      Column({space:20}) {
       Card({
         getContent:this.renderButton
       })
        //当我们的组件只有一个BuilderParam的时候
        // 此时可以使用尾随闭包的语法 也就是像我们原来使用Column或者Row组件时一样，直接在大括号中传入
        CardOne(){
          Text('efwdfewf32e413')
        }
        CardOne({
          getContent:this.renderButton
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Card {
  @BuilderParam // 相当于vue的插槽
   getContent:() => void = () => {}
  build() {
    Column(){
      this.getContent()
    }
    .width('100%')
    .height(200)
    .backgroundColor(Color.Gray)
  }
}

@Component
struct CardOne {
  @BuilderParam // 相当于vue的插槽
  getContent:() => void = () => {}
  build() {
    Column(){
      this.getContent()
    }
    .width('100%')
    .height(200)
    .backgroundColor(Color.Gray)
  }
}