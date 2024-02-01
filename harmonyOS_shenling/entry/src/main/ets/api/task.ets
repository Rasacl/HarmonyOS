import {TaskListDataModel, TaskListParamsModel, TaskDetailInfoModel,PickUpParamsModel} from '../models'
import { Request } from '../utils'

// 类型传值是既可以用interface也可以用class
export const getTaskList = (params: TaskListParamsModel) => {
  return Request.get<TaskListDataModel>('/tasks/list', params)
}

//根据id获取任务详情的接口
export const getTaskDetail = (id:string) => {
  return Request.get<TaskDetailInfoModel>(`/tasks/details/${id}`)
}

//提货

export const pickUp =(data:PickUpParamsModel) => {
  return Request.post<null>('/tasks/takeDelivery', data)
}