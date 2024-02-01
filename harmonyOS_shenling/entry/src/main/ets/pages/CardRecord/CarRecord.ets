import { Card, CardItem, CheckBox, NavBar,DateTimePicker } from '../../components'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { CarRecordType, CarRecordTypeModel, CommonRouterParams, TaskDetailInfo, TaskDetailInfoModel } from '../../models'
import { carRecord, getTaskDetail } from '../../api'

@Entry
@Component
struct CarRecord {
  @State taskDetailData:TaskDetailInfoModel = new TaskDetailInfoModel({} as TaskDetailInfo)
  @State carRecord:CarRecordTypeModel = new CarRecordTypeModel({} as CarRecordType)
  dateTimePicker:CustomDialogController = new CustomDialogController({
    autoCancel:false,
    customStyle:true,
    alignment:DialogAlignment.Bottom,
    builder:DateTimePicker({
      onFinish: (value) => {
        this.carRecord.endTime = value // 赋值时间
      }
    })
  })
  aboutToAppear(){
    const params = router.getParams() as CommonRouterParams
    if(params&&params.id){
      this.getTaskDetail(params.id)
    }
  }

  async getTaskDetail(id:string){
    this.taskDetailData = await getTaskDetail(id)
  }
  async btnRecord() {
    this.carRecord.id = this.taskDetailData.transportTaskId // 交车的id是任务id
    this.carRecord.startTime = this.taskDetailData.actualDepartureTime //实际出发时间
    if(!this.carRecord.endTime) {
      promptAction.showToast({
        message: '回车时间不能为空'
      })
      return
    }
    await carRecord(this.carRecord)
    promptAction.showToast({
      message: '交车成功'
    })
    router.clear() // 销毁页面栈  清空当前的跳过的页面栈
    router.replaceUrl({
      url: 'pages/Index/Index'
    })
  }
  build() {
    Column() {
      NavBar({ title: '回车登记' })

      Card() {
        CardItem({ leftTitle: '出车时间', rightText: this.taskDetailData.actualDepartureTime, showRightIcon: false })
        CardItem({ leftTitle: '回车时间', rightText: this.carRecord.endTime || '请选择', showBottomBorder: false, onRightClick: () => {
          this.dateTimePicker.open()
        } })
      }

      CheckBox({ value: !!this.carRecord.isBreakRules, title: '车辆违章', checkChange: (value) => {
        this.carRecord.isBreakRules = value
      } })

      CheckBox({ value:  !!this.carRecord.isFault, title: '车辆故障' ,
        checkChange: (value) => {
          this.carRecord.isFault = value
        }})
      CheckBox({ value: !!this.carRecord.isAccident, title: '车辆事故',
        checkChange: (value) => {
          this.carRecord.isAccident = value
        } })

      Row(){
        Button('交车')
          .height(50)
          .width('80%')
          .backgroundColor($r('app.color.primary'))
          .onClick(() => {
            this.btnRecord()
          })
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