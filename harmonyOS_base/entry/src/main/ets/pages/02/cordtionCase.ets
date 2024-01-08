@Entry
@Component
struct ConditionCase {
  @State showImg: boolean = false
  @State selectIndex: number = -1
  build() {
    Row() {
      Column({ space: 20 }) {
        Toggle({
          type: ToggleType.Switch,
          isOn: this.showImg
        })
          .onChange((isON) => {
            this.showImg = isON
          })
        if(this.showImg) {
          Image('/assets/404.jpg')
            .width(150)
            .height(150)
        }
        Image('/assets/404.jpg')
          .width(150)
          .height(150)
          .opacity(this.showImg ? 1 : 0)
        Image('/assets/404.jpg')
          .width(150)
          .height(150)
          .visibility(this.showImg ? Visibility.Visible : Visibility.None)

        // 放置一个select组件
        Select([{ value: '勇士' },{ value: '湖人' },{ value: '太阳' }])
          .onSelect((index) => {
            this.selectIndex = index
          })
        if(this.selectIndex === 0) {
          Text("库里")
        }else if(this.selectIndex === 1) {
          Text("詹姆斯")
        }
        else if(this.selectIndex === 2) {
          Text("杜兰特")
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}