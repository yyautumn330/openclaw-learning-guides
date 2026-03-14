import {
    AMap,
    BitmapDescriptor,
    BitmapDescriptorFactory,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    Marker,
    MarkerOptions,
    OnMarkerDragListener
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import ArrayList from '@ohos.util.ArrayList';

let globalContext: Context;

@Component
export struct MapMarkerController {
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

    @Builder
    customMarkerBuilder() {
        // 自定义组件marker
        Column() {
            Text("自定义组件")
                .fontColor(Color.Black)
        }.width(50)
        .height(50)
        .backgroundColor(Color.Red)
    }

    //marker功能
    @Builder
    buildMapMarker() {
        Stack() {
            MapViewComponent({mapViewName: Constants.MAP_MARKER_FUNC }).zIndex(0)
            Button("自定义marker样式")
                .position({ x: 10, y: 10 })
                .zIndex(1)
                .onClick(async () => {
                    let amap = this.aMap;

                    if (amap) {
                        let options3: MarkerOptions = new MarkerOptions();
                        //116.452859,40.020751
                        options3.setPosition(new LatLng(40.020751, 116.452859));
                        let bitmapDes3 = await BitmapDescriptorFactory.fromView(() => {
                            this.customMarkerBuilder();
                        });
                        if (bitmapDes3) {
                            options3.setIcon(bitmapDes3);
                        }
                        let marker3 = amap.addMarker(options3);
                        marker3?.setTitle("marker3");
                        marker3?.setClickable(true);


                        let options4: MarkerOptions = new MarkerOptions();
                        //116.411286,39.857124
                        options4.setPosition(new LatLng(39.857124, 116.411286));
                        let bitmapDes4 = await BitmapDescriptorFactory.fromView(() => {
                            this.customMarkerBuilder();
                        });
                        if (bitmapDes4) {
                            options4.setIcon(bitmapDes4);
                        }
                        let marker4 = amap.addMarker(options4);
                        marker4?.setTitle("marker4");
                        marker4?.setClickable(true);
                    }
                });
           Button("clear")
                .position({ x: 10, y: 50 })
                .onClick(()=> {
                    this.aMap?.clear(true);
                })

        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_MARKER_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync(async (map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_MARKER_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true);
            this.aMap.setOnMarkerDragListener(new OnMarkerDragListener(
                // start
                (marker: Marker) => {
                    let position = marker.getPosition();
                    hilog.info(0xff, Constants.MAP_MARKER_FUNC, `marker drag start ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
                },
                // drap
                (marker: Marker) => {
                    let position = marker.getPosition();
                    hilog.info(0xff, Constants.MAP_MARKER_FUNC, `marker drag move ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
                },
                // end
                (marker: Marker) => {
                    let position = marker.getPosition();
                    hilog.info(0xff, Constants.MAP_MARKER_FUNC, `marker drag end ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
                }

            ));
            // add Marker
            let options1: MarkerOptions = new MarkerOptions();
            let bitmapDes = await BitmapDescriptorFactory.fromRawfilePath(globalContext, "common/marker_default.png");
            if (bitmapDes) {
                options1.setIcon(bitmapDes);
            }

            options1.setDraggable(true);
            options1.setPosition(new LatLng(39.992520, 116.336170));
            options1.setAnchor(0.5, 1.0);
            // options.setPosition(new LatLng(40.02380181476392, 116.43124537956452));
            options1.setTitle('Anno');
            options1.setSnippet('111111111')
            // options.setVisible(false);
            // options.setIcon(new BitmapDescriptor($rawfile('location_map_gps_locked.png'), 'location_map_gps_locked', 100, 100));
            let marker1 = this.aMap?.addMarker(options1);

            // if (marker) {
            //   marker.showInfoWindow();
            //   // this.aMap.removeOverlay(marker.getId());
            //   // marker.setVisible(true);
            //   marker.setIcon(new BitmapDescriptor($rawfile('lite/location_map_gps_locked.png'), 'location_map_gps_locked', 128, 128));
            //   // marker.setPosition(new LatLng(40.02380181476392, 116.43124537956452));
            //   marker.setDraggable(true);
            // }

            let options2: MarkerOptions = new MarkerOptions();
            // 116.294005,39.880586
            options2.setPosition(new LatLng(39.880586, 116.294005));
            let icons: ArrayList<BitmapDescriptor> = new ArrayList<BitmapDescriptor>();
            let bitmapDes1 =
                await BitmapDescriptorFactory.defaultMarkerASync(globalContext, BitmapDescriptorFactory.HUE_BLUE);
            if (bitmapDes1) {
                icons.add(bitmapDes1);
            }
            let bitmapDes2 =
                await BitmapDescriptorFactory.defaultMarkerASync(globalContext, BitmapDescriptorFactory.HUE_RED);
            if (bitmapDes2) {
                icons.add(bitmapDes2);
            }
            let bitmapDes3 =
                await BitmapDescriptorFactory.defaultMarkerASync(globalContext, BitmapDescriptorFactory.HUE_YELLOW);
            if (bitmapDes2) {
                icons.add(bitmapDes3);
            }
            options2.setIcons(icons);
            let marker2 = this.aMap?.addMarker(options2);

            this.aMap?.setOnMarkerClickListener((marker: Marker): boolean => {
                hilog.info(0xff, Constants.MAP_MARKER_FUNC, `marker click ${marker.getId()} ${marker.getTitle()}`);
                return true;
            });
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_MARKER_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_MARKER_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapMarker();
        }
        .title(Constants.MAP_MARKER_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

