@Builder
export function GeoFenceMainPageBuilder() {
  GeoFenceMainPage()
}

@Component
struct GeoFenceMainPage {
  pageInfos: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        Row() {
          Button("圆形围栏")
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFencePage', param: 1 });
            })
        }

        Row() {
          Button("多边形围栏")
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFencePage', param: 2 });
            })
        }

        Row() {
          Button("关键字围栏")
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFencePage', param: 3 });
            })
        }

        Row() {
          Button("周边围栏")
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFencePage', param: 4 });
            })
        }

        Row() {
          Button("行政区划围栏")
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFencePage', param: 5 });
            })
        }

        Row() {
          Button("综合展示")
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFencePage', param: 6 });
            })
        }
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }
}