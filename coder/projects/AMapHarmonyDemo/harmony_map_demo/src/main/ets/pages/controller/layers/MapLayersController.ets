import {
    AMap,
    MapView,
    MapViewComponent,
    MapViewManager,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';

@Component
export struct MapLayersController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    @Consume('pageInfos') pageInfos: NavPathStack;
    @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

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

    // layer图层功能
    @Builder
    buildMapLayer() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_LAYER_FUNC }).zIndex(0)
            Column() {
                Row() {
                    Checkbox({ name: "路网图层" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            if (this.aMap) {
                                if (this.aMap.isTrafficEnabled()) {
                                    this.aMap.setTrafficEnabled(false);
                                } else {
                                    this.aMap.setTrafficEnabled(true);
                                }
                            }
                        })
                    Text("路网图层")
                }

                Divider().strokeWidth(2).color('#ff030303').margin({ top: 8, bottom: 8 })

                Row() {
                    Checkbox({ name: "图面文字标注" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.showMapText(checked);
                        })
                    Text("图面文字标注")
                }

                Divider().strokeWidth(2).color('#ff030303').margin({ top: 8, bottom: 8 })

                Row() {
                    Checkbox({ name: "3D建筑物" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.showBuildings(checked);
                        })
                    Text("3D建筑物")
                }

                Divider().strokeWidth(2).color('#ff030303').margin({ top: 8, bottom: 8 })

                Row() {
                    Checkbox({ name: "导航模式label" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.setNaviLabelEnable(checked, 10, 1);
                        })
                    Text("导航label")
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

        if (mapViewName != Constants.MAP_LAYER_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_LAYER_FUNC,
                `get map ${this.aMap?.getCameraPosition()?.zoom} ${this.aMap?.getCameraPosition()?.target.longitude} ${this.aMap?.getCameraPosition()?.target.latitude}`);
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })
    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_LAYER_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_LAYER_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapLayer();
        }
        .title(Constants.MAP_LAYER_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

