@Entry
@Component
struct MulitiStateCase {

  @State
  user: IUserProfileModel  = new IUserProfileModel({
    username: '老高',
    age: 34,
    sex: "男",
    address: new IAddressModel({
      province: '河北',
      city: '衡水',
      area: '深州'
    })
  })

  build() {
    Row() {
      Column() {
        // UI更新只能监听到一层
        Row() {
          Text(this.user.username).fontSize(40)
          Text(this.user.age.toString()).fontSize(40)
          Text(this.user.address.province).fontSize(40)
          Text(this.user.address.city).fontSize(40)
          Text(this.user.address.area).fontSize(40)
        }
        .width('100%')
        .height(50)
        Button("更新名字和年龄")
          .onClick(() => {
            // this.user.username = "老高坏坏的"
            // this.user.age = 25
            this.user.address.city = "廊坊"
            this.user.address = new IAddressModel(this.user.address)

            // this.user.address = { ...this.user.address, city: '廊坊'   }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

interface IAddress {
  province: string
  city: string
  area: string
}

interface  IUserProfile {
  username: string
  age: number
  sex: '男' | '女'
  address: IAddress
}
export class IAddressModel implements IAddress {
  province: string = ''
  city: string = ''
  area: string = ''

  constructor(model: IAddress) {
    this.province = model.province
    this.city = model.city
    this.area = model.area
  }
}
export class IUserProfileModel implements IUserProfile {
  username: string = ''
  age: number = 0
  sex: '男' | '女' = '男'
  address: IAddress = new IAddressModel({} as IAddress)

  constructor(model: IUserProfile) {
    this.username = model.username
    this.age = model.age
    this.sex = model.sex
    this.address = model.address
  }
}
