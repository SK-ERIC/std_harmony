import preferences from '@ohos.data.preferences';

class PreferencesUtil {
  // 存储偏好设置的Map，键为偏好设置的名称，值为Preferences对象
  prefMap: Map<string, preferences.Preferences> = new Map()

  /**
   * 加载指定名称的偏好设置
   * @param context 上下文对象
   * @param name 偏好设置的名称
   */
  async loadPreference(context, name: string) {
    try {
      // 获取偏好设置对象
      let pref = await preferences.getPreferences(context, name);
      // 将获取到的偏好设置对象存储到Map中
      this.prefMap.set(name, pref);
      // 打印成功日志
      console.log('testTag', `加载Preferences[${name}]成功`);
    } catch (e) {
      // 打印失败日志和错误信息
      console.log('testTag', `加载Preferences[${name}]失败`, JSON.stringify(e));
    }
  }

  /**
   * 写入偏好设置的值
   * @param name 偏好设置的名称
   * @param key 要写入的键
   * @param value 要写入的值
   */
  async putPreferenceValue(name: string, key: string, value: preferences.ValueType) {
    // 检查是否已经加载了指定名称的偏好设置
    if (!this.prefMap.has(name)) {
      // 如果尚未加载，则打印日志并返回
      console.log('testTag', `Preferences[${name}]尚未初始化！`);
      return;
    }
    try {
      // 从Map中获取偏好设置对象
      let pref = this.prefMap.get(name);
      // 写入数据
      await pref.put(key, value);
      // 将数据刷写到磁盘
      await pref.flush();
      // 打印成功日志
      console.log('testTag', `保存Preferences[${name}.${key} = ${value}]成功`);
    } catch (e) {
      // 打印失败日志和错误信息
      console.log('testTag', `保存Preferences[${name}.${key} = ${value}]失败`, JSON.stringify(e));
    }
  }

  /**
   * 读取偏好设置的值
   * @param name 偏好设置的名称
   * @param key 要读取的键
   * @param defaultValue 如果键不存在，则返回的默认值
   * @returns 返回读取到的值
   */
  async getPreferenceValue(name: string, key: string, defaultValue: preferences.ValueType) {
    // 检查是否已经加载了指定名称的偏好设置
    if (!this.prefMap.has(name)) {
      // 如果尚未加载，则打印日志并返回
      console.log('testTag', `Preferences[${name}]尚未初始化！`);
      return;
    }
    try {
      // 从Map中获取偏好设置对象
      let pref = this.prefMap.get(name);
      // 读取数据
      let value = await pref.get(key, defaultValue);
      // 打印成功日志并返回读取到的值
      console.log('testTag', `读取Preferences[${name}.${key} = ${value}]成功`);
      return value;
    } catch (e) {
      // 打印失败日志和错误信息
      console.log('testTag', `读取Preferences[${name}.${key} ]失败`, JSON.stringify(e));
    }
  }
}

// 创建PreferencesUtil类的实例
const preferencesUtil = new PreferencesUtil()

// 导出PreferencesUtil类的实例
export default preferencesUtil as PreferencesUtil