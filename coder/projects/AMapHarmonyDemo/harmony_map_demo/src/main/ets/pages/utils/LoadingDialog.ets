/**
 * 加载弹窗
 */

@CustomDialog
export struct LoadingDialog {
  @Link isLoading: boolean
  controller?: CustomDialogController
  @State rotateAngle: number = 0

  build() {

    Stack({ alignContent: Alignment.Center }) {
      Image($r('app.media.default_loading_icon'))
        .width(54)
        .objectFit(ImageFit.Cover)

      Image($r('app.media.default_loading'))
        .width(60)
        .height(60)
        .objectFit(ImageFit.Cover)
        .rotate({ angle: this.rotateAngle })
        .animation({
          duration: 600,
          curve: Curve.Linear,
          iterations: -1, // -1为无限播放
          playMode: PlayMode.Normal,
        })
        .onAppear(() => {
          this.rotateAngle = 360
        })
    }.width(56)
    .height(56)
    .borderRadius(10)
    .backgroundColor('#99ADAEB2')

  }
}