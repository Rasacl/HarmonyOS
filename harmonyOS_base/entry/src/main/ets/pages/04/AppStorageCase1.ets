@Entry
@Component
struct AppStorageCase1 {
  //第一种方法
  @StorageProp('user_token') token:string = ''

  @StorageLink('user_token') token2:string = ''
  //第二种方法
  aboutToAppear(){
    AlertDialog.show({
      message:AppStorage.Get<string>('user_token')
    })
  }
  build() {
    Row() {
      Column({space:20}) {
        Text(this.token)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('更新token').onClick(() => {
          this.token2 = '67867867'
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}