import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import promptAction from '@ohos.promptAction'
@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Button('去支付')
          .onClick(async  () => {
            // 拉起另外一个ability
            // 上下文 当前页面所在的ability的一些公有的参数和方法
            const context = getContext(this) as common.UIAbilityContext
            // 拉起同个模块下的另一个anility
            // let want:Want = {
            //   bundleName:'com.example.harmonyos_base', //包名
            //   abilityName:'PlayAbility'
            // }
            // 拉起不同模块下的另一个anility
            let want:Want = {
              bundleName:'com.example.harmonyos_base', //包名
              abilityName:'Test_abilityAbility',
              moduleName:'Test_ability',
              parameters:{ //传递参数
                order_id: Date.now()
              }
            }
           const result = await context.startAbilityForResult(want)
           const params = result.want.parameters as resultParams
            if(params.paySuccess){
              promptAction.showToast({
                message:'支付成功'
              })
            }else {
              promptAction.showToast({
                message:'支付失败'
              })
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

type resultParams = Record<string, boolean>