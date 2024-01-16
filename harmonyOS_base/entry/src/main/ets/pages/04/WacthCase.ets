import promptAction from '@ohos.promptAction'
@Entry
@Component
struct WacthCase {
  @State
  @Watch("updateMessage")
  message: string = 'Hello World'

  @State
  @Watch('updateNum1')
  num:number = 10

  updateMessage(){
    AlertDialog.show({message:'1111'})
  }

  updateNum1(){
    promptAction.showToast({message:'数据变了'})
  }
  build() {
    Row() {
      Column({space:10}) {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.message = 'hello Harmony' + Math.random().toFixed(5)
          })
        Divider().strokeWidth(6).color(Color.Green)
        Text(this.num.toString()).fontSize(30).fontColor(Color.Red).onClick(() => {
          this.num++
        })
        Divider().strokeWidth(6).color(Color.Green)
        ChildComp({num:this.num})
        Divider().strokeWidth(6).color(Color.Gray)
        ChildComp1({num:$num})
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct ChildComp {
  @Prop
  @Watch('updateNum')
  num:number

  updateNum(){
    AlertDialog.show({message:'当前的值是' + this.num})
  }
  build() {
    Text(this.num.toString()).fontSize(30)
  }
}

@Component
struct ChildComp1 {
  @Link
  num:number

  build() {
    Text(this.num.toString()).fontSize(30)
      .onClick(() => {
        this.num++
      })
  }
}