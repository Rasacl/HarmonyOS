@Entry
@Component
struct ZhiHuCase {
  @State commentListCase: ReplyClass[] = [
    new ReplyClass({
      id: 1,
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      author: '偏执狂-妄想家',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '11-30',
      area: '海南',
      likeNum: 34
    }),
    new ReplyClass({
      id: 2,
      avatar: 'https://pic1.zhimg.com/v2-5a3f5190369ae59c12bee33abfe0c5cc_xl.jpg?source=32738c0c',
      author: 'William',
      content: '当年希腊可是把1：0发挥到极致了',
      time: '11-29',
      area: '北京',
      likeNum: 58
    }),
    new ReplyClass({
      id: 3,
      avatar: 'https://picx.zhimg.com/v2-e6f4605c16e4378572a96dad7eaaf2b0_l.jpg?source=06d4cd63',
      author: 'Andy Garcia',
      content: '欧洲杯其实16队球队打正赛已经差不多，24队打正赛意味着正赛阶段在小组赛一样有弱队。',
      time: '11-28',
      area: '上海',
      likeNum: 10
    }),
    new ReplyClass({
      id: 4,
      avatar: 'https://picx.zhimg.com/v2-53e7cf84228e26f419d924c2bf8d5d70_l.jpg?source=06d4cd63',
      author: '正宗好鱼头',
      content: '确实眼红啊，亚洲就没这种球队，让中国队刷',
      time: '11-27',
      area: '香港',
      likeNum: 139
    }),
    new ReplyClass({
      id: 5,
      avatar: 'https://pic1.zhimg.com/v2-eeddfaae049df2a407ff37540894c8ce_l.jpg?source=06d4cd63',
      author: '柱子哥',
      content: '我是支持扩大的，亚洲杯欧洲杯扩到32队，世界杯扩到64队才是好的，世界上有超过200支队伍，欧洲区55支队伍，亚洲区47支队伍，即使如此也就六成出现率',
      time: '11-27',
      area: '旧金山',
      likeNum: 29
    }),
    new ReplyClass({
      id: 6,
      avatar: 'https://picx.zhimg.com/v2-fab3da929232ae911e92bf8137d11f3a_l.jpg?source=06d4cd63',
      author: '飞轩逸',
      content: '禁止欧洲杯扩军之前，应该先禁止世界杯扩军，或者至少把亚洲名额一半给欧洲。',
      time: '11-26',
      area: '里约',
      likeNum: 100
    })
  ]
  addCommentCase(item: ReplyClass) {
    this.commentListCase.unshift(item)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          // 顶部组件
          HmNavBarCase()
          // 评论组件
          CommentItemCase({
            item: new ReplyClass({
              id: 1,
              avatar: $r('app.media.handsome'),
              author: '周杰伦',
              content: '意大利拌面应该使用42号钢筋混凝土再加上量子力学缠绕最后通过不畏浮云遮望眼',
              time: '11-30',
              area: '海南',
              likeNum: 100
            })
          })
          // 分割线
          Divider()
            .strokeWidth(6)
            .color("#f4f5f6")
          ForEach(this.commentListCase, (item: ReplyClass) => {
            CommentItemCase({
              item: item
            })
          })
        }
        .width('100%')
        .backgroundColor(Color.White)
      }.padding({
        bottom: 60
      })
      ReplyInputCase({
        addCommentCase: item => {
          this.addCommentCase(item)
        }
      })
    }
  }
}

@Component
struct HmNavBarCase {
  build() {
    Row() {
      Row() {
        Image($r('app.media.ic_public_arrow_left'))
          .width(20)
          .height(20)
      }
      .borderRadius(20)
      .backgroundColor('#f6f6f6')
      .justifyContent(FlexAlign.Center)
      .width(30)
      .aspectRatio(1)
      .margin({
        left: 15
      })

      Text("评论回复")
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .padding({
          right: 35
        })
    }
    .width('100%')
    .height(50)
    .border({
      width: {
        bottom: 1
      },
      color: '#f6f6f6',
    })
  }
}

@Component
struct CommentItemCase {
  @ObjectLink
  item: ReplyClass

  build() {
    Row() {
      Image(this.item.avatar)
        .width(32)
        .height(32)
        .borderRadius(16)
      Column({ space: 10 }) {
        Text(this.item.author)
          .fontWeight(600)
        Text(this.item.content)
          .lineHeight(20)
          .fontSize(14)
          .fontColor("#565656")

        Row() {
          Text(`${this.item.time} . IP属地 ${this.item.area}`)
            .fontColor("#c3c4c5")
            .fontSize(12)
          Row() {
            Image($r('app.media.favoriteblock'))
              .width(14)
              .aspectRatio(1)
              .fillColor(this.item.likeFlag ? 'red' : "#c3c4c5")

            Text(this.item.likeNum.toString())
              .fontSize(12)
              .margin({
                left: 5
              })
          } .onClick(() => {
            if(this.item.likeFlag) {
              this.item.likeNum--
              this.item.likeFlag = false
            }else {
              this.item.likeNum++
              this.item.likeFlag = true
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }.alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .padding({
        left: 15,
        right: 5
      })
    }.justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .padding(15)
  }
}


@Component
struct ReplyInputCase {
  @State commentStr: string = ''
  addCommentCase: (item: ReplyClass) => void = () => {}
  build() {
    Row() {
      TextInput({ placeholder: '回复', text: this.commentStr })
        .layoutWeight(1)
        .backgroundColor("#f4f5f6")
        .onChange(value => {
          this.commentStr = value
        })
      Text('发布')
        .fontColor("#6ecff0")
        .fontSize(14)
        .margin({
          left: 10
        })
        .onClick(() => {
          if(this.commentStr !== "") {
            let obj: ReplyItemCase = {
              id: Date.now(),
              content: this.commentStr,
              time: `${new Date().getMonth() + 1} - ${new Date().getDate()}` ,
              likeNum: 0,
              likeFlag: false,
              author: '老高',
              avatar:  $r('app.media.handsome'),
              area: "北京"
            }
            this.addCommentCase && this.addCommentCase(new ReplyClass(obj))
            this.commentStr = ""
          }
        })
    }
    .height(50)
    .padding({
      left: 10,
      right: 10
    })
    .backgroundColor(Color.White)
    .border({
      width: { top: 1 },
      color: "#f4f5f6"
    })
  }
}

class ReplyItemCase {
  id: number = 0
  avatar: string | Resource = ""
  author: string = ""
  content: string = ""
  time: string = ""
  area: string = ""
  likeNum: number = 0
  likeFlag?: boolean = false
}

@Observed
class ReplyClass  extends ReplyItemCase {
  constructor(obj: ReplyItemCase ) {
    super()
    this.id = obj.id
    this.avatar = obj.avatar
    this.author = obj.author
    this.content = obj.content
    this.time = obj.time
    this.likeNum = obj.likeNum
    this.likeFlag = obj.likeFlag
  }
}