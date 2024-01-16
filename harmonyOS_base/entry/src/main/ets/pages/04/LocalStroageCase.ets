import router from '@ohos.router'
export class UserInfoClass {
  name: string = ""
  age: number = 0
}
let user: Record<string, UserInfoClass> = { "user": {
  name: '老高',
  age: 34
}};
let storage: LocalStorage = new LocalStorage(user);
export {storage}
@Entry(storage)
@Component
struct LocalStorageCase {
  @State message: string = 'Hello World'
  @LocalStorageProp("user") myUser: Partial<UserInfoClass> = {}
  build() {
    Row() {
      Column({ space: 15 }) {
        Text("姓名：" + this.myUser.name)
        Text("年龄：" + this.myUser.age)
        Button("跳转到另一个页面")
          .onClick(() => {
            router.pushUrl({
              url:  "pages/04/LocalStorageCase2"
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}