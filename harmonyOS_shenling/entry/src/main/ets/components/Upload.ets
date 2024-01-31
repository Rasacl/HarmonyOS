import picker from '@ohos.file.picker'
import fs from '@ohos.file.fs'
import util from '@ohos.util'
import request from '@ohos.request'
import { uploadImage } from '../api'
import { ImageList } from '../models'

@Preview
@Component
struct Upload {
  title:string = ''
  maxNumber:number = 3
  @ObjectLink upClass:UploadClass
  // 弹出相册选择器
  async selectImage(){
    const photoPicker = new picker.PhotoViewPicker()
    const result = await photoPicker.select({
      MIMEType:picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: this.maxNumber - this.upClass.images.length
    })
    //循环数组
    if(result.photoUris?.length){
      try {

        let files: request.File[] = []
        const addFolderName = 'chen'
        // 读取沙箱路径
        const defaultDir = getContext(this).cacheDir + '/' + addFolderName // 默认路径
        result.photoUris.forEach(url => {
          // url是media的地址
          // fs是操作文件的对象
          // 使用fs读文件
          const file = fs.openSync(url, fs.OpenMode.READ_ONLY)
          //拷贝文件到沙箱目录下cache
          // 起一个唯一的文件名 非常重要， 不然拿不到文件地址
          if (!fs.listFileSync(getContext(this).cacheDir).includes(addFolderName)) {  //判断是否存在这个目录
            fs.mkdirSync(defaultDir)
          }
          const tempFileName = util.generateRandomUUID() + '.jpg' // 生成一个唯一的文件名 后面有用
          const fileUrl = defaultDir + '/' + tempFileName
          fs.copyFileSync(file.fd, fileUrl) //沙箱路径 同步拷贝
          files.push({
            filename: tempFileName,
            name: 'file', //和接口对应
            uri: `internal://cache/${addFolderName}/${tempFileName}`,
            // 这里说明一下 internal协议会自动获取当前上下文协议的沙箱路径
            type: 'jpg'
          })
        })
        const images = await uploadImage(getContext(this), files)
        this.upClass.images = this.upClass.images.concat(images)  // 赋值数据
      } catch (err){
        AlertDialog.show({
          message: err.message
        })
      }

    }


  }
  build() {
    Column(){
      Text(this.title)
        .fontSize(14)
        .fontColor($r('app.color.text_secondary'))
        .margin({
          top:16,
          bottom:16
        })
      //渲染图片
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.upClass.images, (item: ImageList, index: number) => {
          Stack({ alignContent: Alignment.TopEnd }) {
            Image(item.url)
              .width(95)
              .height(95)
              .borderRadius(4)
            Image($r('app.media.ic_btn_delete'))
              .width(30)
              .height(30)
              .onClick(() => {
                this.upClass.images = this.upClass.images.filter((_, i) => i !== index)
              })
          }.margin({ right: 15, bottom: 10 })
        })
        if(this.maxNumber > this.upClass.images.length) {
          Row() {
            Image($r("app.media.ic_add_img")).width(30).height(30)
          }
          .width(95)
          .height(95)
          .backgroundColor('#F2F2F2')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.selectImage()
          })
        }
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)

  }
}
@Observed
class UploadClass {
  images: ImageList[] = []
}
export {
  Upload,
  UploadClass
}