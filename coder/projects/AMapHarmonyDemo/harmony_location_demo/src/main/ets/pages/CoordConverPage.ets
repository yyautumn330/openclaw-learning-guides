import { CoordinateConverter, CoordType, DPoint, valueOfCoordType } from "@amap/amap_lbs_location";

@Builder
export function CoordConverPageBuilder() {
  CoordConverPage()
}

/**
 * 坐标系转换-示例
 */
@Component
export struct CoordConverPage {
  private sourceLatLng: DPoint = new DPoint(39.989646, 116.480864);
  @State desLatLng: DPoint | undefined = undefined
  @State titleStr: string = 'BAIDU'
  private itemCoords: string[] = ["BAIDU", "GPS", "MAPBAR", "MAPABC", "SOSOMAP", "ALIYUN", "GOOGLE"]

  aboutToAppear(): void {
    this.desLatLng = this.convert(this.sourceLatLng, CoordType.BAIDU)
  }

  /**
   * 根据类型 转换 坐标
   */
  private convert(sourceLatLng: DPoint, coord: CoordType): DPoint | undefined {
    const converter = new CoordinateConverter(getContext(this).getApplicationContext())
    // CoordType.GPS 待转换坐标类型
    converter.from(coord);
    // sourceLatLng待转换坐标点
    converter.coord(sourceLatLng);
    // 执行转换操作
    const desLatLng = converter.convert()

    return desLatLng;
  }

  @Builder
  SubMenu() {
    Menu() {
      ForEach(this.itemCoords, (content: string, index: number) => {
        MenuItem({ content: content })
          .onClick(() => {
            this.desLatLng = this.convert(this.sourceLatLng, valueOfCoordType(this.itemCoords[index]))
            this.titleStr = content
          })
      })
    }
  }

  build() {
    NavDestination() {
      Column({ space: 10 }) {
        Row() {
          Row() {
            Text('lat:')
              .width(30)
            TextInput({ text: this.sourceLatLng.getLatitude().toString() })
              .layoutWeight(1)
              .onChange((value: string) => {
                this.sourceLatLng = new DPoint(Number(value), this.sourceLatLng.getLongitude())
              })
          }.layoutWeight(1)

          Row() {
            Text('lng:')
              .width(30)
            TextInput({ text: this.sourceLatLng.getLongitude().toString() })
              .layoutWeight(1)
              .onChange((value: string) => {
                this.sourceLatLng = new DPoint(this.sourceLatLng.getLatitude(), Number(value))
              })
          }.layoutWeight(1)

        }.width('100%')

        Row({ space: 10 }) {

          Text(this.titleStr + '⬇️')
            .bindMenu(this.SubMenu())

          Text('转换为高德坐标系')
        }.width("100%")

        if (this.desLatLng) {
          Text(`lat/lng:(${this.desLatLng.getLatitude()},${this.desLatLng.getLongitude()})`)
            .width('100%')
        }
      }

      .width("100%")
      .height("100%")
      .padding({ left: 15, right: 15 })
    }
    .title("坐标转换")
  }
}