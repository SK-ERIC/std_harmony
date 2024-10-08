import router from '@ohos.router'
import PreferencesUtil from '../common/util/PreferencesUtil'
import RouterInfo from '../viewmodel/RouterInfo'


const routers: RouterInfo[] = []


@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State showPanel: boolean = false
  @Provide fontSize: number = 16
  tag: string = "Index Page"

  async aboutToAppear() {
    console.log(this.tag, 'about to appear')
    this.fontSize = await PreferencesUtil.getPreferenceValue('MyPreferences', 'IndexFontSize', 16) as number
  }

  onPageShow() {
    console.log(this.tag, 'onPageShow')
  }

  onBackPress() {
    console.log(this.tag, 'onBackPress');
  }

  onPageHide() {
    console.log(this.tag, 'onPageHide')
  }

  aboutToDisappear() {
    console.log(this.tag, 'about to Disappear');
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }

  @Builder
  Title() {
    Row() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .height(80)
      Image($r('app.media.ic_public_settings'))
        .width(30)
        .onClick(() => {
          animateTo({ duration: 500, curve: Curve.EaseOut }, () => this.showPanel = !this.showPanel)
        })
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
  }

  @Builder
  RouterItem(r: RouterInfo, i: number) {
    Row() {
      Text(i + '.')
        .fontSize(this.fontSize)
        .fontColor(Color.White)
      Blank()
      Text(r.title)
        .fontSize(this.fontSize)
        .fontColor(Color.White)
    }
    .width('90%')
    .padding(12)
    .backgroundColor('#38f')
    .borderRadius(20)
    .shadow({ radius: 6, color: "#4f0000", offsetX: 2, offsetY: 2 })
    .onClick(() => {
      router.pushUrl({
        url: r.url,
        params: { id: i }
      },
        router.RouterMode.Single,
        err => {
          if (err) {
            console.log(`路由失败，errCode：${err.code} errMsg: ${err.message}`)
          }
        })
    })
  }
}