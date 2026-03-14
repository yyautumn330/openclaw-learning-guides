import {
    AMap,
    CameraPosition,
    CircleOptions,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    OnCameraChangeListener,
    PolygonOptions,
    PolylineOptions
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import ArrayList from '@ohos.util.ArrayList';

@Component
export struct MapCircleController {
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

    //circle功能
    @Builder
    buildMapCircle() {
        Column() {
            MapViewComponent({ mapViewName: Constants.MAP_CIRCLE_FUNC })
        }.width('100%')
        .height('100%')
    }

    /**
     * 生成一个长方形的四个坐标点
     */
    private createRectangle(center: LatLng, halfWidth: number, halfHeight: number): ArrayList<LatLng> {
        let latLngs = new ArrayList<LatLng>();
        latLngs.add(new LatLng(center.latitude - halfHeight, center.longitude - halfWidth));
        latLngs.add(new LatLng(center.latitude - halfHeight, center.longitude + halfWidth));
        latLngs.add(new LatLng(center.latitude + halfHeight, center.longitude + halfWidth));
        latLngs.add(new LatLng(center.latitude + halfHeight, center.longitude - halfWidth));
        return latLngs;
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }
        if (mapViewName != Constants.MAP_CIRCLE_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;
            hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            let uisettings = this.aMap?.getUiSettings();
            let projection = this.aMap?.getProjection();

            this.aMap?.setOnMapClickListener((point: LatLng) => {
                hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, `map click ${point.longitude} ${point.latitude}`);
            });

            this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_CIRCLE_FUNC,
                        `map change ${position.target.longitude} ${position.target.latitude}`);
                },
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_CIRCLE_FUNC,
                        `map finish ${position.target.longitude} ${position.target.latitude}`);
                }));
            this.aMap?.setOnMapTouchListener((event: TouchEvent) => {
                hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, `map touch ${event.touches[0].x} ${event.touches[0].y}`);
            });
            this.aMap?.setOnMapLongClickListener((point: LatLng) => {
                hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, `map long click ${point.longitude} ${point.latitude}`);
            });
            this.aMap?.setAMapGestureListener((event: GestureEvent) => {
                hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, `map gesture ${event.offsetX} ${event.offsetY}`);
            });
            let pOptions: PolygonOptions = new PolygonOptions();
            this.createRectangle(Constants.SHANGHAI, 1, 1).forEach((latLng) => {
                pOptions.add(latLng);
            });
            // 绘制一个圆形
            this.aMap?.addCircle(new CircleOptions().setCenter(Constants.BEIJING)
                .setRadius(4000)
                .setStrokeColor(0x32010101)
                .setFillColor(0x32010101)
                .setStrokeWidth(25));
            this.addPolylinescircle(Constants.BEIJING, 5000);
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })
    }

    /**
     *
     * @param centerpoint 中心点坐标
     * @param radius      半径 米
     */
    private addPolylinescircle(centerpoint: LatLng, radius: number) {
        let r = 6371000.79;
        let options = new PolylineOptions();
        let numpoints = 360;
        let phase = 2 * Math.PI / numpoints;

        //画图
        for (let i = 0; i < numpoints; i++) {
            let dx = (radius * Math.cos(i * phase));
            let dy = (radius * Math.sin(i * phase)); //乘以1.6 椭圆比例
            let dlng = dx / (r * Math.cos(centerpoint.latitude * Math.PI / 180) * Math.PI / 180);
            let dlat = dy / (r * Math.PI / 180);
            let newlng = centerpoint.longitude + dlng;
            options.add(new LatLng(centerpoint.latitude + dlat, newlng));
        }
        this.aMap?.addPolyline(options.setWidth(10).setGradient(true).setDottedLine(true));

    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_CIRCLE_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapCircle();
        }
        .title(Constants.MAP_CIRCLE_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

