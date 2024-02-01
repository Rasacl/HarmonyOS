import { Card, CardItem, CheckBox, NavBar,DateTimePicker } from '../../components'
import promptAction from '@ohos.promptAction'

@Entry
@Component
struct CarRecord {
  dateTimePicker:CustomDialogController = new CustomDialogController({
    autoCancel:false,
    customStyle:true,
    alignment:DialogAlignment.Bottom,
    builder:DateTimePicker({
      onFinish: (value) => {
        promptAction.showToast({
          message:value
        })
      }
    })
  })
  build() {
    Column() {
      NavBar({ title: '回车登记' })

      Card() {
        CardItem({ leftTitle: '出车时间', rightText: '2022.05.04 13:00', showRightIcon: false })
        CardItem({ leftTitle: '回车时间', rightText: '请选择', showBottomBorder: false, onRightClick: () => {
          this.dateTimePicker.open()
        } })
      }

      CheckBox({ value: false, title: '车辆违章' })
      CheckBox({ value: false, title: '车辆故障' })
      CheckBox({ value: false, title: '车辆事故' })

      Row(){
        Button('交车')
          .height(50)
          .width('80%')
          .backgroundColor($r('app.color.primary'))
      }
      .backgroundColor($r('app.color.white'))
      .height(70)
      .width('100%')
      .position({y:'100%'})
      .translate({y:-70})
      .justifyContent(FlexAlign.Center)
    }
    .backgroundColor($r('app.color.background_page'))
    .height('100%')
  }
}