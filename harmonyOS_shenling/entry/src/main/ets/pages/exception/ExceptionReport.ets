import { Card, CardItem, DateTimePicker, NavBar, SelectCard, Upload, UploadClass } from '../../components'
import { CommonRouterParams, ExceptionParamsType, ExceptionParamsTypeModel } from '../../models'
import router from '@ohos.router'

@Entry
@Component
struct ExceptionReport {
  @State exceptionImagesList: UploadClass = new UploadClass()
  @State exceptionForm: ExceptionParamsTypeModel = new ExceptionParamsTypeModel({} as ExceptionParamsType)
  @State exceptErrorList: string[] = ["发动机启动困难", "不着车、漏油", "照明失灵", "有异常响动", "排烟异常、温度异常", "其他问题"]
  @State selectIndex: number = 0
  //时间弹窗
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
  // 异常类型弹窗
  typeDialog: CustomDialogController = new CustomDialogController({
    builder: SelectCard({
      cardContent: () => {
      this.getCardContent()
    } ,
      confirm: () => {
        this.exceptionForm.exceptionType = this.exceptErrorList[this.selectIndex]
        this.typeDialog.close()
      }
    }),
    autoCancel: false,
    customStyle: true,
    alignment: DialogAlignment.Bottom
  })

  aboutToAppear() {
    const params = router.getParams() as CommonRouterParams
    if (params && params.id) {
      this.exceptionForm.transportTaskId = params.id
    }
  }

  @Builder getCardContent() {
    ForEach(this.exceptErrorList, (name: string, index: number) => {
      this.getSingleItem({ name, index } as ExceptionItemClass)
    })
  }

  // 单个的渲染选项
  @Builder
  getSingleItem(item: ExceptionItemClass) {
    Row() {
      Text(item.name).fontSize(14).fontWeight(400).fontColor($r('app.color.text_primary'))
      Row() {
        Image(this.selectIndex === item.index ? $r("app.media.ic_check_true") : $r("app.media.ic_check_false")).width(32).height(32)
      }
      .onClick(() => {
        this.selectIndex = item.index
      })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .border({
      width: {
        bottom:  item.index === this.exceptErrorList.length - 1 ? 0 : 1
      },
      color: $r('app.color.background_divider')
    })
    .width('100%')
    .height(60)
  }

  build() {
    Column() {
      NavBar({ title: '上报异常' })
      Card() {
        CardItem({ leftTitle: '异常时间', rightText: this.exceptionForm.exceptionTime || '请选择', onRightClick: () => {
          this.dateTimePicker.open()
        } })
        CardItem({ leftTitle: '上报位置', rightText: '请选择', onRightClick:() => {
          router.pushUrl({
            url: 'pages/selectLocation/SelectLocation'
          })
        } })
        CardItem({ leftTitle: '异常类型', rightText: this.exceptionForm.exceptionType || '请选择', onRightClick: () => {
          this.typeDialog.open()
        } })
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

class ExceptionItemClass {
  name: string = ""
  index: number = 0
}