import router from '@ohos.router'
class ListItemInfo {
  title: string = ""
  id: number = 0
}
@Entry
@Component
struct RouterList {
  @State list: ListItemInfo[] = Array.from(Array(100), (_: number, index: number) => {
    return {
      title: `我是第${index + 1}个`,
      id: index + 1
    } as ListItemInfo
  })
  build() {
    Column({space:20}){
      Row(){
        Text('类表数据')
          .width('100%')
          .textAlign(TextAlign.Center)
          .height(40)
      }
      .border({
        color:'#f3f4f5',
        width:{
          bottom:1
        }
      })

      // list渲染数据
      List({space:10}){
        ForEach(this.list, (item:ListItemInfo) => {

          ListItem(){
            Row(){
              Text(item.title)
              Button('查看详情')
                .height(30)
                .onClick(() => {
                  router.pushUrl({
                    url:'pages/06/RouterDetil',
                    params:{
                      id:item.id
                    }
                  })
                })
            }
            .padding({
              left:20,
              right:20
            })
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
          }
        })
      }
    }
  }
}