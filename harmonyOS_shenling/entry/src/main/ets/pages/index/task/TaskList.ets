import { getTaskList } from '../../../api'
import { TaskInfoItem, TaskListParams, TaskListParamsModel, TaskTypeEnum } from '../../../models'
import TaskItemCard  from './TaskItemCard'
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
  aboutToAppear(){
    this.getTaskList()
  }
  async getTaskList(){
    const result = await getTaskList(this.queryParams)
    this.taskListData = result.items
  }
  build() {
    List(){
      ForEach(this.taskListData, (item:TaskInfoItem) => {
        ListItem(){
          TaskItemCard({taskItemData:item})
        }
      })
    }
  }
}
export default  TaskList
