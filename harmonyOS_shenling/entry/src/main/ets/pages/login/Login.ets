import { TOKEN_KEY } from '../../constants'
PersistentStorage.PersistProp(TOKEN_KEY, '')
@Entry
@Component
struct Login {
  @State message: string = '登陆'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            AppStorage.Set<string>(TOKEN_KEY, '1233')
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}