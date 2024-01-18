import http from '@ohos.net.http'
export class FoodItem {
  id: number = 0
  name: string = ""
  like_ratio_desc: string = ""
  food_tag_list: string[] = []
  price: number = 0
  picture: string = ""
  description: string = ""
  tag: string = ""
  month_saled: number = 0
  count?:number = -1
}


export class Category {
  tag: string = ""
  name: string =""
  foods: FoodItem[] = []
}

@Entry
@Component
struct MTIndex {
  // 是否显示购物车
  @State showCar:boolean = false
  @State
  categoryList: Category[] = []
  @StorageLink('user_cart')
  @Watch('updateCartJson')  //第一次不生效
  cartJSon: string = ''
  @Provide cartList:FoodItem[] = []
  //获取数据，将数据进行动态渲染
  aboutToAppear(){
    //获取美团的餐饮数据
    this.getAllData()
    this.updateCartJson()
  }
  updateCartJson(){
    // 此时更新购物车
    this.cartList = getCart()
  }

  async getAllData () {
    try {
      const req = http.createHttp()
      const res = await  req.request("https://zhoushugang.gitee.io/fe2022/takeaway.json")
      this.categoryList =  JSON.parse(res.result as string) as Category[]
    }catch(err) {
      AlertDialog.show({
        message:  JSON.stringify(err)
      })
    }

  }
  build() {
    //堆叠布局 后一个元素会盖在前一个元素上
    Stack({alignContent:Alignment.Bottom}){
      // 主内容区组件
      MTMain({categoryList:$categoryList})
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
  @Link categoryList:Category[]
  @State selectIndex:number = 0
  build() {
    Column(){
      MTNav()
      // 左边是分类，右边是菜品结构
      Row(){
        //左侧是分类
        Column(){
          ForEach(this.categoryList, (item:Category, index:number) => {
            Text(item.name)
              .height(50)
              .width('100%')
              .textAlign(TextAlign.Center)
              .backgroundColor(this.selectIndex === index ? '#fff' : '#f5f5f5')
              .onClick(() => {
                this.selectIndex = index
              })
          })
        }
        .width(90)
        .height('100%')
        .backgroundColor('#f5f5f5')
        //右侧菜品内容
        List(){
          ForEach(this.categoryList[this.selectIndex]?.foods || [], (item:FoodItem) => {
            ListItem(){
              MTFoodItem({foodItem:item})
            }
          })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Top)
    }
    .height('100%')
    .width('100%')
  }
}

//底部组件
@Component
struct MTBottom {
  @Link showCar:boolean
  @Consume cartList:FoodItem[]
  getAllCount () {
    return this.cartList.reduce((preValue, item) => preValue + item.count, 0).toString()
  }
  getAllPrice () {
    return this.cartList.reduce((preValue, item) => preValue + item.count * item.price, 0).toFixed(2)
  }
  build() {
    Row(){
      Row(){
        //徽标组件
        Badge(
          {
            value:this.getAllCount(),
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
            Span(this.getAllPrice())
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
  @Consume cartList:FoodItem[]
  build() {
    Column(){
      //顶部标题
      Row(){
        Text('购物车')
          .fontSize(12)
        Text('清空购物车')
          .fontSize(12)
          .fontColor('#999')
          .onClick(() => {
            AppStorage.Set<string>('user_cart', '[]')
          })
      }
      .width('100%')
      .height(40)
      .padding({
        left:15,
        right:15
      })
      .border({
        color:'#f5f5f5',
        width:{
          bottom:0.5
        }
      })
      .justifyContent(FlexAlign.SpaceBetween)

      List({space:30}){
        ForEach(this.cartList, (item:FoodItem) => {
          ListItem(){
            MTcarItem({ item })
          }
        })

      }
      .padding({
        bottom:70
      })
    }
    .height('50%')
    .width('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct MTcarItem {
  item: Partial<FoodItem> = {}
  build() {
    Row(){
      Image(this.item.picture)
        .width(60)
        .aspectRatio(1)
        .borderRadius(8)
        .margin({
          right:10
         })
      Column(){
        Text(this.item.name)
          .fontSize(14)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })
          .maxLines(2)
        Row(){
          Text(){
            Span('￥')
              .fontSize(12)
              .fontColor('#ff8000')
            Span(this.item.price.toFixed(2))
              .fontSize(18)
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }

          MTAddCut({foodItem:this.item})
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .height(60)
      .layoutWeight(1)
    }
    .padding({
      left:20,
      right:20,
      top:2
    })
  }
}

// 顶部导航
@Component
struct MTNav {
  @Builder
  NavItem(active: boolean, title: string, subTitle?: string) {
    Column() {
      Text() {
        Span(title)
        if (subTitle) {
          Span(' ' + subTitle)
            .fontSize(10)
            .fontColor(active ? '#000' : '#666')
        }
      }.layoutWeight(1)
      .fontColor(active ? '#000' : '#666')
      .fontWeight(active ? FontWeight.Bold : FontWeight.Normal)

      Text()
        .height(1)
        .width(20)
        .margin({ left: 6 })
        .backgroundColor(active ? '#fa0' : 'transparent')
    }
    .width(73)
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 3 })
  }
  build() {
    Row() {
      this.NavItem(true, '点菜')
      this.NavItem(false, '评价', '1796')
      this.NavItem(false, '商家')
      Row() {
        Image($r('app.media.ic_public_input_search'))
          .width(14)
          .aspectRatio(1)
          .fillColor('#999')
        Text('请输入菜品名称')
          .fontSize(12)
          .fontColor('#999')
      }
      .backgroundColor('#eee')
      .height(25)
      .borderRadius(13)
      .padding({ left: 5, right: 5 })
      .layoutWeight(1)

    }
    .padding({ left: 15, right: 15 })
    .height(40)
    .border({ width: { bottom: 0.5 }, color: '#e4e4e4' })
  }
}

// 菜单项组件
@Component
struct MTFoodItem {
  foodItem:Partial<FoodItem> = {}
  build() {
    Row() {
      Image(this.foodItem.picture)
        .width(90)
        .aspectRatio(1)
      Column({ space: 5 }) {
        Text(this.foodItem.name)
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(2)
          .fontWeight(600)
        Text(this.foodItem.description)
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
          .maxLines(1)
          .fontSize(12)
          .fontColor('#333')
        Text(this.foodItem.food_tag_list[0] ? this.foodItem.food_tag_list[0] : '网友推荐')
          .fontSize(10)
          .backgroundColor('#fff5e2')
          .fontColor('#ff8000')
          .padding({ top: 2, bottom: 2, right: 5, left: 5 })
          .borderRadius(2)
        Text() {
          Span(`月销售40${this.foodItem.month_saled}`)
          Span(' ')
          Span(this.foodItem.like_ratio_desc)
        }
        .fontSize(12)
        .fontColor('#999')

        Row() {
          Text() {
            Span('¥ ')
              .fontColor('#ff8000')
              .fontSize(10)
            Span(this.foodItem.price.toString())
              .fontColor('#ff8000')
              .fontWeight(FontWeight.Bold)
          }

          MTAddCut({foodItem:this.foodItem})
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10, right: 10 })
    }
    .padding(10)
    .alignItems(VerticalAlign.Top)
  }
}

// 加减组件
@Component
struct MTAddCut {
  @Consume cartList:FoodItem[]
  foodItem:Partial<FoodItem> = {}

  getCount():number{
    return this.cartList.find(item => item.id === this.foodItem.id)?.count || 0
  }
  build() {
    Row({space:8}){
      Row(){
        Image($r('app.media.ic_screenshot_line'))
          .width(10)
          .aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#fff')
      .borderRadius(4)
      .border({
        width:0.5,
        color:'#f8c74e'
      })
      .visibility(this.getCount() ? Visibility.Visible : Visibility.Hidden )
      .onClick(() => {
        addCutCart('cut', this.foodItem as FoodItem)
      })

      Text(this.getCount().toString())
        .fontSize(14)
        .visibility(this.getCount() ? Visibility.Visible : Visibility.Hidden )

      Row(){
        Image($r('app.media.ic_public_add_filled'))
          .width(10)
          .aspectRatio(1)
      }
      .width(16)
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#f8c74e')
      .borderRadius(4)
      .onClick(() => {
        addCutCart('add', this.foodItem as FoodItem)
      })
    }
  }
}
//持久化数据
PersistentStorage.PersistProp<string>('user_cart','[]')

//提供加减组件的方法
const addCutCart = (type:'add' | 'cut', item:FoodItem) => {
  const list = getCart()
  const food = list.find(f => f.id == item.id)
  if(type === 'add'){
    if(food){
      food.count++
    }else {
      item.count = 1
      list.unshift(item)
    }
  } else {
    if(food&&food.count > 0){
      food.count--
      if(food.count === 0){
        const index = list.findIndex(ff => ff.id === item.id)
        list.splice(index, 1)
      }
    }
  }

  //重新写入磁盘
  AppStorage.Set<string>('user_cart', JSON.stringify(list))

}

//获取购物车的所有数据

const getCart = () => {
  return JSON.parse(AppStorage.Get<string>('user_cart') || '[]') as FoodItem[]
}

