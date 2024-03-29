import { Loading } from './Loading'

@Component
struct RefreshList {
  @State
  refreshing: boolean = false // 控制下拉刷新
  @State
  loading: boolean = false // 控制上拉加载
  @Prop
  finished: boolean // 是否结束
  @Link dataSource: object[] // 数据源
  @BuilderParam renderItem: (item: object) => void
  loadingText: string = "加载数据中" // 加载中文本
  finishText: string = "没有内容啦" // 结束文本
  showLoadingIcon: boolean = true // 是否显示加载进度

  onLoad: () => void = () => {
  } // 上拉加载函数

  onRefresh: () => void = () => {
  } // 下拉刷新函数

  // 获取底部显示的文本
  @Builder
  getBottomDisplay() {
    Row({ space: 10 }) {
      if (this.finished) {
        Text(this.finishText)
          .fontSize(14)
          .fontColor($r("app.color.text_secondary"))
      } else {
        if (this.loading) {
          Text(this.loadingText)
            .fontSize(14)
            .fontColor($r("app.color.text_secondary"))
          if (this.showLoadingIcon) {
            Loading({
              hWidth: 20
            })
          }
        }
      }
    }
    .height(50)
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Refresh({ refreshing: $$this.refreshing }) {
      List() {
        //4.0list里面必须有个子元素才会触发onReachEnd  next任何内容都可以
        // 每一个结构不一样，每一个数据不一样，而且不能再组件中写死
        //数据哪里来
        ForEach(this.dataSource, (item: object) => {
          ListItem() {
            if (this.renderItem) {
              this.renderItem(item)
            }
          }.width('100%')
        })
        ListItem() {
          this.getBottomDisplay()
        }
      }
      .onReachEnd(async () => {
        // 上拉加载
        if (!this.finished && !this.loading) {
          this.loading = true
          await this.onLoad()
          this.loading = false
        }
      })
    }
    .onStateChange(async (value) => {
      // 下拉刷新
      if (value === RefreshStatus.Refresh) {
        await this.onRefresh()
        this.refreshing = false //关闭下拉刷新的加载
        this.loading = false //关闭上拉加载状态
      }
    })
  }
}

export {
  RefreshList
}