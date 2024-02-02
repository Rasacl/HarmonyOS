import { Card, CardItem, DateTimePicker, NavBar, Upload, UploadClass } from '../../components'
import { CommonRouterParams, ExceptionParamsType, ExceptionParamsTypeModel } from '../../models'
import router from '@ohos.router'

@Entry
@Component
struct ExceptionReport {
  @State exceptionImagesList: UploadClass = new UploadClass()
  @State exceptionForm:ExceptionParamsTypeModel = new ExceptionParamsTypeModel({} as ExceptionParamsType)
  dateTimePicker: CustomDialogController = new CustomDialogController({
    builder: DateTimePicker({
      onFinish: (value) => {
        this.exceptionForm.exceptionTime = value
      }
    }),
    alignment: DialogAlignment.Bottom,
    customStyle: true,
    autoCancel: false
  })
  aboutToAppear() {
    const params = router.getParams() as CommonRouterParams
    if(params && params.id) {
      this.exceptionForm.transportTaskId = params.id
    }
  }
  build() {
    Column() {
      NavBar({ title: '上报异常' })
      Card() {
        CardItem({ leftTitle: '异常时间', rightText: this.exceptionForm.exceptionTime || '请选择', onRightClick:() => {
          this.dateTimePicker.open()
        } })
        CardItem({ leftTitle: '上报位置', rightText: '请选择' })
        CardItem({ leftTitle: '异常类型', rightText: '请选择' })
        CardItem({ leftTitle: '异常描述', rightText: '', showRightIcon: false, showBottomBorder: false })
        TextArea({
          placeholder: '请输入异常描述'
        })
          .height(130).borderRadius(8).placeholderColor($r('app.color.text_secondary')).fontSize(14)
        Text(`0/50`)
          .margin({
            top: -30
          })
          .textAlign(TextAlign.End)
          .width('100%')
          .padding({ right: 15 })
          .fontColor($r('app.color.text_secondary'))
        Row().height(20)

      }

      Card() {
        Upload({ title: '上传图片(最多6张)', maxNumber: 6, upClass: this.exceptionImagesList, canUpload: true })
        Row().height(20)
      }

      Row() {
        Button("提交").height(50).width(207).backgroundColor($r('app.color.primary_disabled'))
      }
      .position({
        y: '100%'
      })
      .height(70)
      .translate({
        y: -70
      })
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.white'))
    }
    .height('100%').backgroundColor($r('app.color.background_page'))
  }
}