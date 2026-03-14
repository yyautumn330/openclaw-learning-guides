import { ArrayList } from "@kit.ArkTS";
import { BusLineItem } from "@amap/amap_lbs_search";

@CustomDialog
export struct BusLineDialog {
  controller: CustomDialogController
  @Link lineItems: BusLineItem[];
  @Link currentPage: number;
  @Prop totalPage: number
  onClickItem: (item: BusLineItem) => void = () => {
  }
  onClickPre: () => void = () => {}
  onClickNext: () => void = () => {}

  build() {
    Column() {
      Row() {
        Text('搜索结果')

        Row() {
          Text('前一页')
        }
        .height(40)
        .width(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.currentPage > 0 ? '#87CEEB' :'#dddddd')
        .borderRadius(5)
        .margin({
          left: 10,
          right: 10
        })
        .onClick(() => {
          this.onClickPre()
        })
        .enabled(this.currentPage > 0 ? true : false)

        Row() {
          Text('下一页')
        }
        .height(40)
        .width(60)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(this.currentPage < this.totalPage - 1 ? '#87CEEB' :'#dddddd')
        .borderRadius(5)
        .onClick(() => {
          this.onClickNext()
        })
        .enabled(this.currentPage < this.totalPage - 1 ? true : false)
      }
      .width('100%')
      .padding({
        left: 10
      })
      .margin({
        bottom: 10
      })

      List({ space: 10 }) {
        ForEach(this.lineItems, (item: BusLineItem, index: number) => {
          ListItem() {
            Column() {
              Text('公交名：' + item.getBusLineName())
                .margin({
                  bottom: 5
                })
              Text('公交id：' + item.getBusLineId())

              if (index === this.lineItems.length - 1) {
                Divider()
                  .strokeWidth(1)
                  .color('#999999')
                  .margin({
                    top: 5
                  })
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .onClick(() => {
            this.controller.close()
            this.onClickItem(item)
          })
        })
      }
      .width('100%')
      .divider({ strokeWidth: 1, color: '#999999' })
      .layoutWeight(1)
      .padding({
        left: 10
      })
    }
    .backgroundColor('#eeeeee')
    .width('100%')
    .layoutWeight(1)
    .padding({
      top: 45
    })
  }
}