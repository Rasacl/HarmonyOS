import picker from '@ohos.file.picker'
@Preview
@Component
struct Upload {
  title:string = ''
  maxNumber:number = 3
  // 弹出相册选择器
  async selectImage(){
    const photoPicker = new picker.PhotoViewPicker()
    const result = await photoPicker.select({
      MIMEType:picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber:this.maxNumber
    })


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

      Row(){
        Image($r('app.media.ic_add_img'))
          .width(30)
          .aspectRatio(1)
      }
      .width(95)
      .aspectRatio(1)
      .backgroundColor($r('app.color.gray_1'))
      .borderRadius(4)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.selectImage()
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)

  }
}

export {
  Upload
}