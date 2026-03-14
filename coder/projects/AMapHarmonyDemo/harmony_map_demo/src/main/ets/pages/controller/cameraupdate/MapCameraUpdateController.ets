import {
    AMap,
    CameraPosition,
    CameraUpdate,
    CameraUpdateFactory,
    LatLng,
    LatLngBounds,
    LatLngBoundsBuilder,
    MapView,
    MapViewComponent,
    MapViewManager,
    Point
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import display from '@ohos.display';

@Component
export struct MapCameraUpdateController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    public animate: boolean = false;
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
    buildCameraUpdateMap() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_CAMERA_UPDATE_FUNC })
            Column() {
                Row() {
                    Button("cBearig").onClick(() => {
                        this.changeBearing(50);
                    })

                    Button("cLatLng").onClick(() => {
                        this.changeLatLng(Constants.SHANGHAI);
                    })

                    Button("cTilt").onClick(() => {
                        this.changeTilt(50);
                    })

                    Button("nCameraPosition").onClick(() => {
                        this.newCameraPosition(new CameraPosition(Constants.SHANGHAI, 3, 50, 50));
                    })
                }

                Row() {
                    Button("nLatLng").onClick(() => {
                        this.newLatLng(Constants.SHANGHAI);
                    })

                    Button("nLatLngBounds").onClick(() => {
                        let b: LatLngBoundsBuilder = LatLngBounds.builder();
                        b.include(Constants.BEIJING);
                        b.include(Constants.SHANGHAI);
                        b.include(Constants.CHENGDU);
                        b.include(Constants.XIAN);
                        this.newLatLngBounds(b.build()!, 100, 100, 100);
                    })

                    Button("nLLBoundsRect").onClick(() => {
                        let b: LatLngBoundsBuilder = LatLngBounds.builder();
                        b.include(Constants.BEIJING);
                        b.include(Constants.SHANGHAI);
                        b.include(Constants.CHENGDU);
                        b.include(Constants.XIAN);
                        this.newLatLngBoundsRect(b.build()!, 100, 100, 100, 100);
                    })
                }

                Row() {
                    Button("nLLZm").onClick(() => {
                        this.newLatLngZoom(Constants.SHANGHAI, 15);
                    })

                    Button("sBy").onClick(() => {
                        this.scrollBy(100, 100);
                    })

                    Button("zBy").onClick(() => {
                        this.zoomBy(2);
                    })

                    Button("zIn").onClick(() => {
                        this.zoomIn();
                    })

                    Button("zOut").onClick(() => {
                        this.zoomOut();
                    })

                    Button("zTo").onClick(() => {
                        this.zoomTo(15);
                    })
                }

                Row() {
                    Checkbox({ name: "move or animate" })
                        .shape(CheckBoxShape.ROUNDED_SQUARE)
                        .selectedColor(0x39a2db)
                        .onChange((checked: boolean) => {
                            this.animate = checked;
                        })
                    Text("是否使用animate")
                }
            }.position({x: 0, y: 10})
        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_CAMERA_UPDATE_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC,
                `get map ${this.aMap?.getCameraPosition()?.zoom} ${this.aMap?.getCameraPosition()?.target.longitude} ${this.aMap?.getCameraPosition()?.target.latitude}`);

            let projection = this.aMap?.getProjection();

            if (projection) {
                let fromScreenLocationPoint = projection.fromScreenLocationSync(new Point(100, 100));
                hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC,
                    `fromScreenLocationPoint ${fromScreenLocationPoint.latitude} ${fromScreenLocationPoint.longitude}`);

                let toScreenLocationPoint = projection.toScreenLocationSync(new LatLng(30.069625, 120.282487));
                hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC,
                    `toScreenLocationPoint ${toScreenLocationPoint.x} ${toScreenLocationPoint.y}`);

                let toMapLocationPoint = projection.toMapLocation(new LatLng(30.069625, 120.282487));
                hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC, `toMapLocation ${toMapLocationPoint.x} ${toMapLocationPoint.y}`);

                let width = display.getDefaultDisplaySync().width;
                let toOpenGLWidth = projection.toOpenGLWidth(width);
                hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC, `toOpenGLWidth ${toOpenGLWidth}`);

                let visibleRegion = projection.getVisibleRegion();
                if (visibleRegion) {
                    hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC,
                        `visibleRegion ${visibleRegion.nearLeft.longitude} ${visibleRegion.nearLeft.latitude} ${visibleRegion.nearRight.longitude} ${visibleRegion.nearRight.latitude} ${visibleRegion.farLeft.longitude} ${visibleRegion.farLeft.latitude} ${visibleRegion.farRight.longitude} ${visibleRegion.farRight.latitude}`);
                }

                let mapBounds = projection.getMapBounds(new LatLng(30.069625, 120.282487), 10);
                if (mapBounds) {
                    hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC,
                        `mapBounds ${mapBounds.southwest.longitude} ${mapBounds.southwest.latitude} ${mapBounds.northeast.longitude} ${mapBounds.northeast.latitude}`);
                }
                this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
            }
        })

    }

    changeBearing(bearing: number) {
        let update = CameraUpdateFactory.changeBearing(bearing);
        this.moveOrAnimate(update);
    }

    changeLatLng(latLng: LatLng) {
        let update = CameraUpdateFactory.changeLatLng(latLng);
        this.moveOrAnimate(update);
    }

    changeTilt(tilt: number) {
        let update = CameraUpdateFactory.changeTilt(tilt);
        this.moveOrAnimate(update);
    }

    newCameraPosition(position: CameraPosition) {
        let update = CameraUpdateFactory.newCameraPosition(position)
        this.moveOrAnimate(update);
    }

    newLatLng(latLng: LatLng) {
        let update = CameraUpdateFactory.newLatLng(latLng);
        this.moveOrAnimate(update);
    }

    newLatLngBounds(bounds: LatLngBounds, padding: number, width: number, height: number) {
        let update = CameraUpdateFactory.newLatLngBounds(bounds, padding, width, height)
        this.moveOrAnimate(update);
    }

    newLatLngBoundsRect(latlngbounds: LatLngBounds, paddingLeft: number, paddingRight: number, paddingTop: number, paddingBottom: number) {
        let update = CameraUpdateFactory.newLatLngBoundsRect(latlngbounds, paddingLeft, paddingRight, paddingTop, paddingBottom);
        this.moveOrAnimate(update);
    }

    newLatLngZoom(latLng: LatLng, zoom: number) {
        let update = CameraUpdateFactory.newLatLngZoom(latLng, zoom);
        this.moveOrAnimate(update);
    }

    scrollBy(xPixel: number, yPixel: number) {
        let update = CameraUpdateFactory.scrollBy(xPixel, yPixel);
        this.moveOrAnimate(update);
    }

    zoomBy(zoom: number) {
        let update = CameraUpdateFactory.zoomBy(zoom);
        this.moveOrAnimate(update);
    }

    zoomIn() {
        let update = CameraUpdateFactory.zoomIn();
        this.moveOrAnimate(update);
    }

    zoomOut() {
        let update = CameraUpdateFactory.zoomOut();
        this.moveOrAnimate(update);
    }

    zoomTo(zoom: number) {
        let update = CameraUpdateFactory.zoomTo(zoom);
        this.moveOrAnimate(update);
    }

    private moveOrAnimate(update: CameraUpdate) {
        if (this.animate) {
            this.aMap?.animateCamera(update);
        } else {
            this.aMap?.moveCamera(update);
        }
    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_CAMERA_UPDATE_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildCameraUpdateMap();
        }
        .title(Constants.MAP_CAMERA_UPDATE_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

