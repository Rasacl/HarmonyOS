import { getTaskList } from '../../../api'
import { TaskInfoItem, TaskListParams, TaskListParamsModel, TaskTypeEnum, TaskInfoItemModel } from '../../../models'
import TaskItemCard  from './TaskItemCard'
import {RefreshList} from '../../../components'
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
  @State allPage: number = 1 // 总页数先设置为1页 后续会更新
  // aboutToAppear(){
  //   this.getTaskList()
  // }  //onReachEnd会触发请求
  async getTaskList(append:boolean){
    const result = await getTaskList(this.queryParams)
    // ...是限制使用 在数组中可用
    this.taskListData = append ? this.taskListData.concat(result.items  || []) : result.items || [] // 连接新的数组
    this.allPage = result.pages // 赋值总页数
    this.queryParams.page++ // 页码+1
  }
  //下拉刷新的方法
  async onRefresh(){
    this.allPage = 1 //总页数也得回到第一页
    this.queryParams.page = 1 // 重置页码为1
    await this.getTaskList(false)
    promptAction.showToast({
      message:'刷新成功'
    })
  }
  @Builder
  renderItem (item: object) {
    TaskItemCard({ taskItemData: item as TaskInfoItemModel })
  }
  build() {
    Column(){
      RefreshList({
        onLoad: async () => {
          await this.getTaskList(true)
        },
        onRefresh: async () => {
          await this.onRefresh()
        },
        dataSource: $taskListData,
        renderItem: this.renderItem,
        finished: this.allPage < this.queryParams.page,
        finishText: '没啦没啦',
        loadingText: '拼命加载中'
      })
    }.height('100%')
  }
}
export default  TaskList
