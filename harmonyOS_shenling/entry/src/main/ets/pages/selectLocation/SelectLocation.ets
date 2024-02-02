import { NavBar, Card, CardItem } from '../../components'

@Entry
@Component
struct SelectLocation {
  build() {
    Column() {
      NavBar({ title: '当前位置' })
      //  地图区域
      Text("地图")
      Column() {
        Card() {
          CardItem({ leftTitle: '回龙观街道', rightText: '100m以内' })
          CardItem({ leftTitle: '金燕龙科研楼', rightText: '100m以内' })
          CardItem({ leftTitle: '春野画室', rightText: '100m以内' })
          CardItem({ leftTitle: '光滑时代(金艳龙科研楼店)', rightText: '100m以内' })
        }
      }.position({
        y: '100%'
      }).translate({
        y: -260
      })

    }
    .height('100%').backgroundColor($r('app.color.background_page'))
  }
}