// 用首选项读取广告，设置广告
import preferences from '@ohos.data.preferences';
import { USER_SETTING, USER_SETTING_AD, TOKEN_KEY } from '../constants'
import { AdvertClass } from '../models';
//用户广告只是用户设置的一种-还可以设置用户的其他行为

//默认的广告配置
const defaultAD:AdvertClass = {
  showAd:true,
  adTime:5,
  adImg:$r('app.media.start'),
}
export class UserSettingClass{
  context: Context
  constructor(context:Context) {
    this.context = context
  }
  // 1.获取首选项仓库
  getStore(){
    return preferences.getPreferences(this.context, USER_SETTING)
  }
  //读取广告
  async getUserAd():Promise<AdvertClass>{
    const adStore = await this.getStore()
    // 读取广告的配置 参数： 表名 默认配置
    return JSON.parse(await adStore.get(USER_SETTING_AD, JSON.stringify(defaultAD)) as string) as AdvertClass
  }

  //设置广告
  async setUserAd(ad:AdvertClass){
    const adStore = await this.getStore()
    await adStore.put(USER_SETTING_AD, JSON.stringify(ad))
    // 写入磁盘
    await adStore.flush()
  }

  // 读取token
  async getUserToken():Promise<string>{
    const tokenStore = await this.getStore()
    return await tokenStore.get(TOKEN_KEY, '') as string
  }

  // 设置token
  async setUserToken(token:string){
    const tokenStore = await this.getStore()
    await tokenStore.put(TOKEN_KEY, token)
    await tokenStore.flush()
  }
}