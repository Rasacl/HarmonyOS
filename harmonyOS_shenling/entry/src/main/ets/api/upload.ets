import request from '@ohos.request'
import { BASE_URL, TOKEN_KEY } from '../constants'

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

  try {
    const UploadTask = await request.uploadFile(context, config)
    //执行到这里并不意味这个上传完成，只是意味着任务队列执行完成
    UploadTask.on('fail', (state) => {
      AlertDialog.show({
        message: '图片上传失败'
      })
    })
    UploadTask.on('complete', () => {
      AlertDialog.show({
        message: '图片上传完成'
      })
    })
  } catch (err) {
    AlertDialog.show({
      message: err.message
    })
  }
}