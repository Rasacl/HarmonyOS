import { getTaskList } from '../../../api'
import { TaskInfoItem, TaskListParams, TaskListParamsModel, TaskTypeEnum } from '../../../models'
import TaskItemCard  from './TaskItemCard'
import {Loading} from '../../../components'
import promptAction from '@ohos.promptAction'
@Preview
@Component
struct TaskList {
  @State queryParams:TaskListParamsModel = new TaskListParamsModel({
    page:1,
    pageSize:5,
    status: TaskTypeEnum.Waiting
  } as TaskListParams)
  @State
  refreshing: boolean = false //控制下拉状态的变量
  @State
  taskListData: TaskInfoItem[] = []
  allPage: number = 1 // 总页数先设置为1页 后续会更新
  @State loading:boolean = false // 是否正在加载数据
  // aboutToAppear(){
  //   this.getTaskList()
  // }  //onReachEnd会触发请求
  async getTaskList(append:boolean){
    const result = await getTaskList(this.queryParams)
    // ...是限制使用 在数组中可用
    this.taskListData = append ? this.taskListData.concat(result.items) : result.items // 连接新的数组
    this.allPage = result.pages // 赋值总页数
    this.queryParams.page++ // 页码+1
  }
  //下拉刷新的方法
  async onRefresh(){
    this.allPage = 1 //总页数也得回到第一页
    this.queryParams.page = 1 // 重置页码为1
    await this.getTaskList(false)
    this.refreshing = false
    this.loading = false // 控制上拉加载的  必须把这个地方设置为false
    promptAction.showToast({
      message:'刷新成功'
    })
  }
  @Builder getBottomDisplay(){
    Row({ space: 10 }) {
      if (this.loading) {
        Text(this.allPage < this.queryParams.page ? "已经没有内容拉" : "加载数据中")
          .fontSize(14)
          .fontColor($r("app.color.text_secondary"))
        if(this.allPage >= this.queryParams.page) {
          Loading({
            hWidth: 20
          })
        }
      }
    }
    .height(50)
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
  build() {
    // refresh 可以双向绑定
    Refresh({refreshing:$$this.refreshing}){
      List(){
        ForEach(this.taskListData, (item:TaskInfoItem) => {
          ListItem(){
            TaskItemCard({taskItemData:item})
          }
        })
        ListItem() {
          this.getBottomDisplay() // 底部显示内容
        }//Next版本不需要加ListItem依然可以触发onReachEnd
      }
      .onReachEnd(async () => {
        // 进行分页加载 还没有加载完的情况下还可以继续加载，如果加载完成就不能在继续加载了
        if(this.allPage >= this.queryParams.page){
          if(!this.loading){
            this.loading = true
            await this.getTaskList(true)
            this.loading = this.allPage < this.queryParams.page ? true : false // 如果请求完了 判断一下 是不是已经没有数据了
          }
        }
      })
    }
    .onStateChange((value) => {
      if(value === RefreshStatus.Refresh){
        // 重新加载数据
        this.onRefresh()

      }
    })
  }
}
export default  TaskList
