import {TaskListDataModel, TaskListParamsModel} from '../models'
import { Request } from '../utils'

// 类型传值是既可以用interface也可以用class
export const getTaskList = (params: TaskListParamsModel) => {
  return Request.get<TaskListDataModel>('/tasks/list', params)
}