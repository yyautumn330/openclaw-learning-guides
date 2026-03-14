import { LoadingDialog } from "./LoadingDialog";

@Component
export struct Loading {
  /**
   * 监听外部传入的isLoading变量，isLoading值发生变化时触发onChange回调函数
   */
  @Link @Watch("onLoadingStateChange") isLoading: boolean;
  /**
   * loading弹窗
   */
  controller: CustomDialogController | undefined = new CustomDialogController({
    builder: LoadingDialog({
      isLoading: $isLoading
    }),
    cancel: () => {
      this.isLoading = false
    },
    alignment: DialogAlignment.Center,
    customStyle: true,
  })

  /**
   * 当isLoading的值变化时触发回调
   */
  onLoadingStateChange() {
    if (this.isLoading) {
      this.controller?.open();
    } else {
      this.controller?.close();
    }
  }

  /**
   * 在自定义组件即将析构销毁时将controller置空
   */
  aboutToDisappear() {
    this.controller = undefined
  }

  // 二次封装的Dialog组件主要通过控制器控制弹窗，不需要任何界面
  build() {
  }
}