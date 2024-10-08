@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  tag: string = "Index Page"

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
    }
  }
}