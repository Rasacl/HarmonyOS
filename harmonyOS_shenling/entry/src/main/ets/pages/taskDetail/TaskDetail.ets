import {NavBar, ToggleCard} from '../../components'
import router from '@ohos.router'
import { CommonRouterParams,TaskDetailInfoModel,TaskDetailInfo } from '../../models'
import { getTaskDetail } from '../../api'
@Entry
@Component
struct TaskDetail {
  @State taskDetailData:TaskDetailInfoModel = new TaskDetailInfoModel({} as TaskDetailInfo)
  scroll:Scroller = new Scroller()  // 属于外力控制
  aboutToAppear(){
    const params = router.getParams() as CommonRouterParams
    if(params && params.id){
      this.getTaskDetail(params.id)
    }
  }

  async getTaskDetail(id:string){
    this.taskDetailData = await getTaskDetail(id)
  }
  build() {
    Column(){
      NavBar({title:'任务详情'})
      Scroll(this.scroll){
        //scroll里面只有一个组件
        Column(){
          ToggleCard({title:'任务详情'}){
            Text(JSON.stringify(this.taskDetailData))
          }
          ToggleCard({title:'任务详情'}){
            Text(JSON.stringify(this.taskDetailData))
          }
          ToggleCard({title:'任务详情'}){
            Text(JSON.stringify(this.taskDetailData))
          }
        }
        .padding({
          bottom:120
        })
      }
    }
    .backgroundColor($r('app.color.background_page'))
    .height('100%')
  }
}