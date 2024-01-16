import router from '@ohos.router'
PersistentStorage.PersistProp<string>('user_token', '') //初始化磁盘，做持久化存储
@Entry
@Component
struct PersistentStorageCase {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Row(){
          Button('登录')
            .width('100%')
            .height(40)
            .onClick(() => {
              AppStorage.SetOrCreate<string>('user_token','12344554')
              router.pushUrl({
                url:"pages/04/AppStorageCase1"
              })
            })
        }
        .padding({
          left:20,
          right:20
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}