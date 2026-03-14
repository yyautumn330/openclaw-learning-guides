import {
    AMap,
    AMapOptions,
    MapView,
    MapViewComponent,
    MapViewManager,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';

@Component
export struct MapUiSettingsController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    @State private zoomEnabled: boolean = true; // 默认开启
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

    //uisettings功能
    @Builder
    buildMapUiSettings() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_UISETTINGS_FUNC }).zIndex(0)
            Column() {
                Row() {
                    Checkbox({ name: "位置控件" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setMyLocationButtonEnabled(checked);
                            this.aMap?.setMyLocationEnabled(checked);
                        })
                    Text("位置控件")
                }

                Divider().strokeWidth(2).color('#ff030303')
                Row() {
                    Checkbox({ name: "比例尺控件" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setScaleControlsEnabled(checked);
                        })
                    Text("比例尺控件")
                }

                Divider().strokeWidth(2).color('#ff030303')
                Column() {
                    Row() {
                        Checkbox({ name: "缩放控件" })
                            .select(this.zoomEnabled)
                            .shape(CheckBoxShape.ROUNDED_SQUARE)
                            .selectedColor(0x39a2db)
                            .onChange((checked: boolean) => {
                                this.zoomEnabled = checked;
                                this.aMap?.getUiSettings()?.setZoomControlsEnabled(checked);
                            })
                        Text("缩放控件")
                    }

                    Divider().strokeWidth(2).color('#ff030303')

                    if (this.zoomEnabled) {
                        Column() {
                            Row() {
                                Radio({ value: "右下", group: "zoom_position_group" })
                                    .checked(false)
                                    .radioStyle({
                                        checkedBackgroundColor: Color.Pink
                                    })
                                    .onChange((checked: boolean) => {
                                        if (checked) {
                                            this.aMap?.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM);
                                        }
                                    })
                                Text("右下")

                                Divider()
                                    .vertical(true)
                                    .height(20)
                                    .strokeWidth(1)
                                    .color('#ff706d6d')
                                    .margin({ left: 5, right: 5 })

                                Radio({ value: "右中", group: "zoom_position_group" })
                                    .checked(false)
                                    .radioStyle({
                                        checkedBackgroundColor: Color.Pink
                                    })
                                    .onChange((checked: boolean) => {
                                        if (checked) {
                                            this.aMap?.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_CENTER);
                                        }
                                    })
                                Text("右中")
                            }
                        }
                        .alignItems(HorizontalAlign.Start)
                    }
                }
                .alignItems(HorizontalAlign.Start)

                Divider().strokeWidth(2).color('#ff030303')

                Text("logo水印")
                Column() {
                    Row() {
                        Radio({ value: "左下", group: "logo水印" })
                            .checked(true)
                            .radioStyle({
                                checkedBackgroundColor: Color.Pink
                            })
                            .onChange((checked: boolean) => {
                                if (checked) {
                                    this.aMap?.getUiSettings()?.setLogoPosition(AMapOptions.LOGO_POSITION_BOTTOM_LEFT);
                                }
                            })
                        Text("左下")
                    }

                    Row() {
                        Radio({ value: "底部居中", group: "logo水印" })
                            .checked(false)
                            .radioStyle({
                                checkedBackgroundColor: Color.Pink
                            })
                            .onChange((checked: boolean) => {
                                if (checked) {
                                    this.aMap?.getUiSettings()?.setLogoPosition(AMapOptions.LOGO_POSITION_BOTTOM_CENTER);
                                }
                            })
                        Text("底部居中")
                    }

                    Row() {
                        Radio({ value: "右下", group: "logo水印" })
                            .checked(false)
                            .radioStyle({
                                checkedBackgroundColor: Color.Pink
                            })
                            .onChange((checked: boolean) => {
                                if (checked) {
                                    this.aMap?.getUiSettings()?.setLogoPosition(AMapOptions.LOGO_POSITION_BOTTOM_RIGHT);
                                }
                            })
                        Text("右下")
                    }
                }
                .alignItems(HorizontalAlign.Start)

                Divider().strokeWidth(2).color('#ff030303')

                Row() {
                    Checkbox({ name: "指南针控件" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.aMap?.getUiSettings()?.setCompassEnabled(checked);
                        })
                    Text("指南针控件")
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

        if (mapViewName != Constants.MAP_UISETTINGS_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
            hilog.info(0xff, Constants.MAP_UISETTINGS_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);
        })
    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_UISETTINGS_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_UISETTINGS_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapUiSettings();
        }
        .title(Constants.MAP_UISETTINGS_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

