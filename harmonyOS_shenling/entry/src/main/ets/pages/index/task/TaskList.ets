import { getTaskList } from '../../../api'
import { TaskInfoItem, TaskListParams, TaskListParamsModel, TaskTypeEnum } from '../../../models'
import TaskItemCard  from './TaskItemCard'
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
  taskListData: TaskInfoItem[] = []
  allPage: number = 1 // 总页数先设置为1页 后续会更新
  @State loading:boolean = false // 是否正在加载数据
  // aboutToAppear(){
  //   this.getTaskList()
  // }  //onReachEnd会触发请求
  async getTaskList(){
    const result = await getTaskList(this.queryParams)
    // ...是限制使用 在数组中可用
    this.taskListData = this.taskListData.concat(result.items) // 连接新的数组
    this.allPage = result.pages // 赋值总页数
    this.queryParams.page++ // 页码+1
  }
  build() {
    List(){
      ForEach(this.taskListData, (item:TaskInfoItem) => {
        ListItem(){
          TaskItemCard({taskItemData:item})
        }
      })
      ListItem() //Next版本不需要加ListItem依然可以触发onReachEnd
    }
    .onReachEnd(async () => {
      // 进行分页加载 还没有加载完的情况下还可以继续加载，如果加载完成就不能在继续加载了
      if(this.allPage >= this.queryParams.page){
        if(!this.loading){
          this.loading = true
          await this.getTaskList()
          this.loading = false
        }
      }else {
        promptAction.showToast({
          message:'到底啦😀😀😀'
        })
      }
    })
  }
}
export default  TaskList
