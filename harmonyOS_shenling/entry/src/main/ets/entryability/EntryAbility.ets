import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { TOKEN_KEY } from '../constants';
import { AdvertClass } from '../models';
import { UserSettingClass } from '../utils';
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import promptAction from '@ohos.promptAction';

export default class EntryAbility extends UIAbility {
  async onCreate(want, launchParam): Promise<void>  {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    const manger = abilityAccessCtrl.createAtManager()
    try {
      await manger.requestPermissionsFromUser(this.context,[
        'ohos.permission.MEDIA_LOCATION',
        'ohos.permission.LOCATION',
        'ohos.permission.APPROXIMATELY_LOCATION',
        // 'ohos.permission.LOCATION_IN_BACKGROUND' //加上不跳出权限授权
      ])
    } catch (err){
      promptAction.showToast({ message: '获取位置失败' })
    }
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    // 判断有没有广告
     const userSetting = new UserSettingClass(this.context)
    // // 请求网络, 先看看云端有没有  模拟一下
    // const result = await new Promise<AdvertClass>((resolve) => {
    //   setTimeout(() => {
    //     resolve({
    //       showAd:true,
    //       adTime:10,
    //       adImg:'https://img.zcool.cn/community/013b935e71dc2ba80120a895af0238.jpg@1280w_1l_2o_100sh.jpg'
    //     } as AdvertClass)
    //   },50)
    // })
    //
    // // 写入首选项
    //  await userSetting.setUserAd(result)
     const adSetting = await userSetting.getUserAd()
    if(adSetting.showAd){
      // 去广告页
      windowStage.loadContent('pages/start/Start');
    } else {
      const token = await userSetting.getUserToken()
      if(AppStorage.Get(TOKEN_KEY) || token){
        windowStage.loadContent('pages/index/Index');
      }else {
        windowStage.loadContent('pages/login/Login');
      }
    }
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
