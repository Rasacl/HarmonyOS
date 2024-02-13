import {TaskListDataModel, TaskListParamsModel, TaskDetailInfoModel,PickUpParamsModel, DeliverParamsTypeModel, CarRecordTypeModel, DelayParamsTypeModel, ExceptionParamsTypeModel} from '../models'
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

//交货
export const deliver = (data:DeliverParamsTypeModel) => {
  return Request.post<null>("/tasks/deliver", data)
}

// 回车登记
export const carRecord = (data: CarRecordTypeModel) => {
  return Request.post<null>("/tasks/truckRegistration", data)
}

// 延迟收货
export const delay = (data: DelayParamsTypeModel) => {
  return Request.put<null>("/tasks/delay", data)
}

// 上报异常
export const exceptionReport = (data: ExceptionParamsTypeModel) => {
  return Request.post<null>("/tasks/reportException", data)
}