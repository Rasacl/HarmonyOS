//  负责存放所有的数据类型结构

export * from './advert' // 广告数据类型
export * from './user' //账号数据模型
export * from './tab'
export * from './task'
export * from './router'
export * from './task_detail'
export * from './pick_up'
export * from './common'
export * from './deliver'
export * from './car_record'
export * from './delay'
export * from './exception'
export * from './location'
// 统一的类型工具 用来处理所有接口的返回类型
export class ResponseData<T> {
  code: number = 0
  msg: string = ""
  data: T | null = null // 这里应该必须只能这么声明！！！！
}