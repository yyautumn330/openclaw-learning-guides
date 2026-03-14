import {
    AMap,
    CameraPosition,
    CameraUpdateFactory,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    OnCameraChangeListener,
    PolygonOptions
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import ArrayList from '@ohos.util.ArrayList';

@Component
export struct MapPolygonController {
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

    //polygon功能
    @Builder
    buildMapPolygon() {
        Column() {
            MapViewComponent({ mapViewName: Constants.MAP_POLYGON_FUNC })
        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_POLYGON_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_POLYGON_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            let uisettings = this.aMap?.getUiSettings();
            let projection = this.aMap?.getProjection();


            this.aMap?.setOnMapClickListener((point: LatLng) => {
                hilog.info(0xff, Constants.MAP_POLYGON_FUNC, `map click ${point.longitude} ${point.latitude}`);
            });

            this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_POLYGON_FUNC,
                        `map change ${position.target.longitude} ${position.target.latitude}`);
                },
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_POLYGON_FUNC,
                        `map finish ${position.target.longitude} ${position.target.latitude}`);
                }));

            this.aMap?.setOnMapTouchListener((event: TouchEvent) => {
                hilog.info(0xff, Constants.MAP_POLYGON_FUNC, `map touch ${event.touches[0].x} ${event.touches[0].y}`);
            });

            this.aMap?.setAMapGestureListener((event: GestureEvent) => {
                hilog.info(0xff, Constants.MAP_POLYGON_FUNC, `map gesture ${event.offsetX} ${event.offsetY}`);
            });

            this.aMap?.setOnMapLongClickListener((point: LatLng) => {
                hilog.info(0xff, Constants.MAP_POLYGON_FUNC, `map long click ${point.longitude} ${point.latitude}`);
            });

            let pOptions: PolygonOptions = new PolygonOptions();
            this.createRectangle(Constants.SHANGHAI, 1, 1).forEach((latLng) => {
                pOptions.add(latLng);
            });

            this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(Constants.BEIJING, 5)); // 设置指定的可视区域地图
            // 绘制一个长方形
            this.aMap?.addPolygon(pOptions.setFillColor(0xFFCCCCCC).setStrokeColor(0xffff0000).setStrokeWidth(1));
            let options = new PolygonOptions();
            let numPoints = 400;
            let semiHorizontalAxis = 5;
            let semiVerticalAxis = 2.5;
            let phase = 2 * Math.PI / numPoints;
            for (let i = 0; i <= numPoints; i++) {
                options.add(new LatLng(Constants.BEIJING.latitude
                    + semiVerticalAxis * Math.sin(i * phase),
                    Constants.BEIJING.longitude + semiHorizontalAxis
                        * Math.cos(i * phase)));
            }
            // 绘制一个椭圆
            this.aMap?.addPolygon(options.setStrokeWidth(25)
                .setStrokeColor(0x32010101)
                .setFillColor(0x32010101));


            // 定义多边形的5个点点坐标
            let latLng1 = new LatLng(42.742467, 79.842785);
            let latLng2 = new LatLng(43.893433, 98.124035);
            let latLng3 = new LatLng(33.058738, 101.463879);
            let latLng4 = new LatLng(25.873426, 95.838879);
            let latLng5 = new LatLng(30.8214661, 78.788097);

            // 声明 多边形参数对象
            let polygonOptions = new PolygonOptions();
            // 添加 多边形的每个顶点（顺序添加）
            polygonOptions.add(latLng1, latLng2, latLng3, latLng4, latLng5);
            polygonOptions.setStrokeWidth(15)// 多边形的边框
                .setStrokeColor(0x32010101)// 边框颜色
                .setFillColor(0x01010101); // 多边形的填充色

            // 添加一个多边形
            this.aMap?.addPolygon(polygonOptions);
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_POLYGON_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_POLYGON_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapPolygon();
        }
        .title(Constants.MAP_POLYGON_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })
    }
}

