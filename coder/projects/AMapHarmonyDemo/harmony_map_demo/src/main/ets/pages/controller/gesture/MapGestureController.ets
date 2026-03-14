import {
    AMap,
    MapView,
    MapViewComponent,
    MapViewManager,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';

@Component
export struct MapGestureController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    @Consume('pageInfos') pageInfos: NavPathStack;
    @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
    @State selectList: boolean[] = [true, true, true, true]

    onPageShow(): void {
        this.mapView?.onResume();
    }

    onPageHide(): void {
        this.mapView?.onPause();
    }

    pageChange(changedPropertyName: string) {
        if (this.isPageHide === true) {
            this.onPageHide()
        } else {
            this.onPageShow()
        }
    }

    // gesture
    @Builder
    buildMapGesture() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_GESTURE_FUNC }).zIndex(0)
            Column() {
                Row() {
                    Checkbox({ name: "滑动手势" })
                        .select(this.selectList[0])
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setScrollGesturesEnabled(checked);
                        })
                    Text("滑动手势")
                }

                Divider().strokeWidth(2).color('#ff030303')
                Row() {
                    Checkbox({ name: "缩放手势" })
                        .select(this.selectList[1])
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setZoomGesturesEnabled(checked);
                        })
                    Text("缩放手势")
                }

                Divider().strokeWidth(2).color('#ff030303')
                Row() {
                    Checkbox({ name: "旋转手势" })
                        .select(this.selectList[2])
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setRotateGesturesEnabled(checked);
                        })
                    Text("旋转手势")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row() {
                    Checkbox({ name: "俯仰角手势" })
                        .select(this.selectList[3])
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setTiltGesturesEnabled(checked);
                        })
                    Text("俯仰角手势")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row() {
                    Checkbox({ name: "所有手势" })
                        .select(true)
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.selectList = [checked, checked, checked, checked]
                        })
                    Text("所有手势")
                }
            }
            .backgroundColor("#ccbebebe")
            .align(Alignment.TopStart)
            .alignItems(HorizontalAlign.Start)
            .position({ x: 0, y: 100 })
            .zIndex(1)
            .width('40%')
        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_GESTURE_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_GESTURE_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_GESTURE_FUNC, "aboutToAppear");
    }

    aboutToDisappear(): void {
        if (this.mapViewCreateCallback) {
            MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
        }

        if (this.mapView) {
            this.mapView.onDestroy();
            this.mapView = undefined;
            this.aMap = undefined;
        }

        hilog.info(0xff, Constants.MAP_GESTURE_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapGesture();
        }
        .title(Constants.MAP_GESTURE_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

