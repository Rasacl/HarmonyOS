import http from '@ohos.net.http'
import { BASE_URL, TOKEN_KEY } from '../constants'
import { UserSettingClass } from './setting'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import { ResponseData } from '../models'

const httpRequest = http.createHttp() //创建一个网络请求

// 支持get post put delete
// next版本不支持在箭头函数上传递泛型
async function requestHttp<T>(url:string = '', method:http.RequestMethod = http.RequestMethod.GET, data?:object): Promise<T>{
  let urlStr = BASE_URL + url //拼接地址
  if(method === http.RequestMethod.GET){
    if(data && Object.keys(data).length){
      urlStr += '?' + Object.keys(data).map(key => {
        if(data[key]){
          return `${key}=${data[key]}`
        }
        return ''
      }).join('&')
    }
  }

  // 设置请求对象
  //这里可以将返回结果指定为对象
  let config:http.HttpRequestOptions = {
    method,
    readTimeout:10000, // 超时时间
    extraData: method === http.RequestMethod.GET ? '' : data,
    //请求头
    header: {
      'Content-Type': 'application/json',
      "Authorization": AppStorage.Get(TOKEN_KEY) || ""
    }
  }

  // 发请求
  try {
    const res = await httpRequest.request(urlStr, config)
    if(res.responseCode === 401){
      // token超时
      AppStorage.Set<string>(TOKEN_KEY,'')  //delete 不可以 是个坑 删不掉持久化数据
      new UserSettingClass(getContext(this)).setUserToken('') // 删除首选项的token
      promptAction.showToast({
        message:'token超时了'
      })
      // 回登录页
      router.replaceUrl({
        url:'pages/login/Login'
      })
      // 返回错误， 停止执行
      return Promise.reject(new Error('token超时了'))
    } else if(res.responseCode === 404){
      promptAction.showToast({
        message:'请求地址不正确'
      })
      return Promise.reject(new Error('请求地址不正确'))
    } else {
      // res.result就是接口返回的结构
      const result = JSON.parse(res.result as string) as ResponseData<T>
      if (result.code === 200) {
        // 执行成功
        return result.data as T // 直接返回数据
      }
      else {
        promptAction.showToast({ message: '服务器异常' })
        return Promise.reject(new Error(result.msg))
      }
    }
  } catch (error){
    promptAction.showToast({ message: error.message })
    return Promise.reject(error)
  }
  finally {
    httpRequest.destroy(); // 销毁请求
  }
}

// 导出一个类的静态方法
export class Request {
  static get<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.GET, data)
  }

  static post<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.POST, data)
  }

  static delete<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.DELETE, data)
  }

  static put<T>(url: string, data?: object): Promise<T> {
    return requestHttp<T>(url, http.RequestMethod.PUT, data)
  }
}