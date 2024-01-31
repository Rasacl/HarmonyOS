import request from '@ohos.request'
import { BASE_URL, TOKEN_KEY } from '../constants'
import promptAction from '@ohos.promptAction'
import { Request as RequestClass } from '../utils' // 定义一个别名 怕冲突
import { ImageList, ImageListModel } from '../models'

export const uploadImage = async (context: Context, files: request.File[]) => {
  const config: request.UploadConfig = {
    url: `${BASE_URL}/files/imageUpload`,
    method: 'POST',
    header: {
      'Accept': '*/*',
      'Authorization': AppStorage.Get(TOKEN_KEY) || '',
      'Content-Type': 'multipart/form-data' //formData类型
    },
    files,
    data: [] //data本意是再传文件的过程中传递一些其他表单数据
  }

  return new Promise<ImageList[]>(async (resolve, reject) => {
    try {
      const UploadTask = await request.uploadFile(context, config)
      //执行到这里并不意味这个上传完成，只是意味着任务队列执行完成
      UploadTask.on('fail', (state) => {
        promptAction.showToast({
          message: '上传失败'
        })
        reject(new Error("图片上传失败"))
      })
      UploadTask.on('complete', async (data) => {
        const result = await Promise.all<string>(files.map(item => RequestClass.get<string>("/files/imageUrl", {
          imageName: item.filename.slice(0, item.filename.indexOf('.'))
        } as FileParams))) // NEXT版本中字面量{} 不能直接给object
        resolve(result.map(url => new ImageListModel({ url })))
      })
    } catch (error) {
      AlertDialog.show({
        message: error.message
      })
    }
  })

}

class FileParams {
  imageName: string = ""
}