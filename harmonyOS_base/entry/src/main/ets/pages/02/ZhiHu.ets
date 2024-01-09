class ReplyItem {
  id: number = 0
  avatar: string | Resource = ""
  author: string = ""
  content: string = ""
  time: string = ""
  area: string = ""
  likeNum: number = 0
  likeFlag?: boolean = false
}

@Entry
@Component
struct ZhiHu {
  @State commentList: ReplyItem[] = [
    {
      id: 1,
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      author: '偏执狂-妄想家',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '11-30',
      area: '海南',
      likeNum: 34
    },
    {
      id: 2,
      avatar: 'https://pic1.zhimg.com/v2-5a3f5190369ae59c12bee33abfe0c5cc_xl.jpg?source=32738c0c',
      author: 'William',
      content: '当年希腊可是把1：0发挥到极致了',
      time: '11-29',
      area: '北京',
      likeNum: 58
    },
    {
      id: 3,
      avatar: 'https://picx.zhimg.com/v2-e6f4605c16e4378572a96dad7eaaf2b0_l.jpg?source=06d4cd63',
      author: 'Andy Garcia',
      content: '欧洲杯其实16队球队打正赛已经差不多，24队打正赛意味着正赛阶段在小组赛一样有弱队。',
      time: '11-28',
      area: '上海',
      likeNum: 10
    },
    {
      id: 4,
      avatar: 'https://picx.zhimg.com/v2-53e7cf84228e26f419d924c2bf8d5d70_l.jpg?source=06d4cd63',
      author: '正宗好鱼头',
      content: '确实眼红啊，亚洲就没这种球队，让中国队刷',
      time: '11-27',
      area: '香港',
      likeNum: 139
    },
    {
      id: 5,
      avatar: 'https://pic1.zhimg.com/v2-eeddfaae049df2a407ff37540894c8ce_l.jpg?source=06d4cd63',
      author: '柱子哥',
      content: '我是支持扩大的，亚洲杯欧洲杯扩到32队，世界杯扩到64队才是好的，世界上有超过200支队伍，欧洲区55支队伍，亚洲区47支队伍，即使如此也就六成出现率',
      time: '11-27',
      area: '旧金山',
      likeNum: 29
    },
    {
      id: 6,
      avatar: 'https://picx.zhimg.com/v2-fab3da929232ae911e92bf8137d11f3a_l.jpg?source=06d4cd63',
      author: '飞轩逸',
      content: '禁止欧洲杯扩军之前，应该先禁止世界杯扩军，或者至少把亚洲名额一半给欧洲。',
      time: '11-26',
      area: '里约',
      likeNum: 100
    }
  ]
  changeLike(item:ReplyItem){
    if(item.likeFlag){
      item.likeFlag = false
      item.likeNum--
    }else {
      item.likeFlag = true
      item.likeNum++
    }
    //State数据只能监听到第一层
    let index = this.commentList.findIndex(obj => obj.id === item.id)
    this.commentList.splice(index, 1, item)
  }

  addComment(obj:ReplyItem){
    //新增一条评论
    this.commentList.unshift(obj)
  }
  build() {
    Stack({alignContent:Alignment.Bottom}){
      Scroll(){
        Column(){
          Navbar()
          CommentItem({
            item: {
              id: 1,
              avatar: $r('app.media.handsome'),
              author: '周杰伦',
              content: '意大利拌面应该使用42号钢筋混凝土再加上量子力学缠绕最后通过不畏浮云遮望眼',
              time: '11-30',
              area: '海南',
              likeNum: 100
            }
          })
          //分割线
          Divider()
            .strokeWidth(6)
            .color('#f4f4f4')
          Row(){
            Text('回复7')
              .width('100%')
              .fontWeight(FontWeight.Bold)
          }
          .height(40)
          .padding({
            left:20
          })
          // 循环渲染多个数据
          ForEach(this.commentList, (item:ReplyItem) => {
            CommentItem({item, changeLike:item => {
              this.changeLike(item)
            }})
          })
        }
      }
      .padding({
        bottom:60
      })

      //回复组件
      ReplyInput({addComment:(obj:ReplyItem) => {
        this.addComment(obj)
      }})
    }
  }
}

@Component
struct Navbar {
  build() {
    Row(){
      Row(){
        Image($r("app.media.ic_public_arrow_left"))
          .fillColor('#848484')
          .width(16)
          .aspectRatio(1)
      }
      .width(24)
      .aspectRatio(1)
      .backgroundColor('#f5f5f5')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .margin({
        left:15
      })
      Text('评论回复')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(18)
        .padding({
          right:39
        })
    }
    .height(40)
    .border({
      color:'#f4f4f4',
      width:{
        bottom:1
      }
    })
  }
}

@Component
struct CommentItem {
  item:Partial<ReplyItem> = {}
  changeLike:(item:ReplyItem) => void = () => {}
  build() {
    Row(){
      //左侧头像
      Image(this.item.avatar)
        .width(32)
        .aspectRatio(1)
        .borderRadius(16)

      //评论区
      Column({space:10}){
        Text(this.item.author)
          .fontWeight(FontWeight.Bold)
        Text(this.item.content)
        .fontSize(16)
        .fontColor('#565656')
        .lineHeight(20)

        Row(){
          Text(`${this.item.time}.IP属地${this.item.area}`)
          .fontSize(12)
          .fontColor('#c3c4c5')
          Row(){
            Image($r("app.media.favoriteblock"))
              .width(12)
              .aspectRatio(1)
              .fillColor(this.item?.likeFlag ? 'red' : "#c3c4c5") //填充颜色，阿里图标下载的需要改图标 fill="currentColor"
              .margin({
                right:5
              })
            Text(this.item.likeNum?.toString())
              .fontSize(12)
              .fontColor('#c3c4c5')
          }
          .onClick(() => {
            //点赞
            this.changeLike(this.item as ReplyItem)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({
        left:10
      })

    }
    .padding(15)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct ReplyInput {
  @State commentStr:string = ''
  addComment:(obj:ReplyItem) => void = () => {}
  build() {
    Row(){
      TextInput({placeholder:'回复~', text:this.commentStr})
        .layoutWeight(1)
        .backgroundColor('#f4f5f6')
        .onChange((value) => {
          this.commentStr = value
        })
      Text('发布')
        .fontColor('#6ecff0')
        .margin({
          left:10
        })
        .onClick(() => {
          if(this.commentStr !== ''){
            let obj:ReplyItem = {
              id: Date.now(),
              content: this.commentStr,
              time: `${new Date().getMonth() + 1} - ${new Date().getDate()}`,
              likeNum: 0,
              likeFlag: false,
              author: '老高',
              avatar: $r('app.media.handsome'),
              area: "北京"
            }
            this.addComment && this.addComment(obj)
            this.commentStr = ''
          }
        })
    }
    .border({
      color:'#f4f5f6',
      width:1
    })
    .width('100%')
    .height(50)
    .backgroundColor(Color.White)
    .padding({
      right:10,
      left:10
    })
  }
}