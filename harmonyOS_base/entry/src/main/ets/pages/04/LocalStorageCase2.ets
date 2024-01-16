
import { storage, UserInfoClass } from './LocalStroageCase'
@Entry(storage)
@Component
struct LocalStorageCase2 {
  @LocalStorageProp("user")
  myUser: Partial<UserInfoClass> = {}
  build() {
    Row() {
      Column() {
        Column({ space: 15 }) {
          Text("姓名：" + this.myUser.name)
          Text("年龄：" + this.myUser.age)
        }
        .width('100%')
      }
      .width('100%')
    }
    .height('100%')
  }
}