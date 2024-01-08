@Entry
@Component
struct ImageCase {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column({space:20}) {
        // 1 使用本地图片
        Image('/assets/404.jpg')
          .width(100)
          .height(100)
          .borderRadius(50)
        //  2 使用资源引入  Resource类型
        // Image($r("app.media.handsome"))
        //   .width(200)
        //   .height(200)
        //   .borderRadius(50)

        //3 采用原始文件引用
        Image($rawfile('sun.jpg'))
          .width(200)
          .height(200)
          .borderRadius(50)

        //4 引用网路图片 需要在module.json5配置
        // "requestPermissions": [
        // {
        //   "name": "ohos.permission.INTERNET"
        // }
        // ],

        Image('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F9ed572e1-1741-4e8e-9f1e-72a8227e5a2c%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1707110697&t=7d6024413290c9ed081ff34aec9401cd')
          .width(200)
          .height(200)
          .borderRadius(50)
      }

      .width('100%')
    }
    .height('100%')
  }
}