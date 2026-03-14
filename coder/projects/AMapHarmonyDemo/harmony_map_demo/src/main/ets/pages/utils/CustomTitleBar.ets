@Component
export struct CustomTitleBar {
  @Prop title: string
  @Prop rightTitle?: string
  onPopClick?: () => void
  onRightClick?: () => void

  build() {
    Row() {
      Image($r('app.media.amap_map3d_title_back'))
        .width(40)
        .height(40)
        .onClick(() => {
          if (this.onPopClick) {
            this.onPopClick()
          }
        })
      Text(this.title)
        .fontWeight(600)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
      Text(this.rightTitle)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          if (this.onRightClick) {
            this.onRightClick()
          }
        })
    }
    .width('100%')
    .height(48)
    .padding({ left: 5, right: 20 })
  }
}