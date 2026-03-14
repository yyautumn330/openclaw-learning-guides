import {
    AMap,
    BasePointOverlay,
    BitmapDescriptorFactory,
    InfoWindowListener,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    Marker,
    MarkerOptions,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';

let globalContext: Context;

@Component
export struct MapInfoWindowController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    @State customInfoWindowTitle: string = ""
    @State customInfoWindowSnippet: string = ""
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

    @Builder
    customInfoWindowBuilder() {
        // 自定义组件marker
        Column() {
            Text(this.customInfoWindowTitle)
                .fontColor(Color.Black)
            Text(this.customInfoWindowSnippet)
                .fontColor(Color.Black)
        }
        .backgroundColor(Color.Red)
    }

    @Builder
    customInfoWindowBuilder2() {
        // 自定义组件marker
        Column() {
            Text(this.customInfoWindowTitle)
                .fontColor(Color.Black)
            Text(this.customInfoWindowSnippet)
                .fontColor(Color.Black)
        }
        .backgroundColor(Color.Yellow)
    }

    // infoWindow
    @Builder
    buildMapInfoWindow() {
        Stack() {
                MapViewComponent({ mapViewName: Constants.MAP_INFOWINDOW_FUNC, customInfoWindowBuilderParam: () => {
                    this.customInfoWindowBuilder();
                }
                }).zIndex(0)
            Column() {
                Button("自定义infoWindow样式")
                    .zIndex(1)
                    .onClick(async () => {
                        this.aMap?.addInfoWindowListener(new InfoWindowListener(
                            //show
                            (marker: BasePointOverlay) => {
                                this.customInfoWindowTitle = marker.getTitle();
                                this.customInfoWindowSnippet = marker.getSnippet();
                            },
                            //hide
                            (marker: BasePointOverlay) => {
                            }
                        ));

                        // add Marker
                        let options1: MarkerOptions = new MarkerOptions();
                        let bitmapDes =
                            await BitmapDescriptorFactory.fromRawfilePath(globalContext, "common/marker_default.png");
                        if (bitmapDes) {
                            options1.setIcon(bitmapDes);
                        }
                        options1.setPosition(new LatLng(39.992520, 116.336170));

                        let marker1 = this.aMap?.addMarker(options1);

                        if (marker1) {
                            marker1.setTitle("标题");
                            marker1.setSnippet("11111111111");

                            marker1.showInfoWindow();
                        }

                        // add Marker
                        let options2: MarkerOptions = new MarkerOptions();
                        let bitmapDes2 =
                            await BitmapDescriptorFactory.fromRawfilePath(globalContext, "common/marker_default.png");
                        if (bitmapDes2) {
                            options2.setIcon(bitmapDes2);
                        }
                        options2.setTitle("标题");
                        options2.setSnippet("222222222");
                        options2.setPosition(new LatLng(39.918796, 116.54432));

                        let marker2 = this.aMap?.addMarker(options2);
                    })
                Button("改变infoWindow样式")
                    .zIndex(1)
                    .onClick(() => {
                        if (this.aMap) {
                            this.aMap.setInfoWindowAdapter(() => {
                                this.customInfoWindowBuilder2();
                            })
                        }
                    })
            }
            .position({ x: 10, y: 10 })
        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }
        if (mapViewName != Constants.MAP_INFOWINDOW_FUNC) {
            return;
        }
        this.mapView = mapview;
        this.mapView.onCreate();
        this.mapView.getMapAsync(async (map) => {
            this.aMap = map;
            hilog.info(0xff, Constants.MAP_INFOWINDOW_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            this.aMap.setOnInfoWindowClickListener((marker: Marker) => {
                hilog.info(0xff, Constants.MAP_INFOWINDOW_FUNC, 'InfoWindow ' + marker.getId() + " " + marker.getTitle());
            });
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        });
    };

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_INFOWINDOW_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_INFOWINDOW_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapInfoWindow();
        }
        .title(Constants.MAP_INFOWINDOW_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

