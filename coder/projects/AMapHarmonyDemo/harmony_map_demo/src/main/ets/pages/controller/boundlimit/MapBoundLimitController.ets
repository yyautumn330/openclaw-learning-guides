import {
    AMap,
    CameraUpdateFactory,
    LatLng,
    LatLngBounds,
    MapView,
    MapViewComponent,
    MapViewCreateCallback,
    MapViewManager,
    MarkerOptions,
    PolygonOptions
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';

@Component
export struct MapBoundLimitController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    // 西南坐标
    private southwestLatLng = new LatLng(39.674949, 115.932873);
    // 东北坐标
    private northeastLatLng = new LatLng(40.159453, 116.767834);
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

    //限制显示区域
    @Builder
    buildBoundLimitShow() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_BOUND_LIMIT_FUNC }).zIndex(0)
            Column() {
                Button("设置")
                    .onClick(() => {
                        this.setMapBoundLimit();
                    })
            }
            .position({ x: 10, y: 10 })
            .align(Alignment.TopStart)
            .alignItems(HorizontalAlign.Start)
            .width('40%')
        }.width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
    }

    public setMapBoundLimit() : void {
        if (!this.aMap) {
            return
        }
        let zoom = this.aMap.getZoomToSpanLevel(this.southwestLatLng, this.northeastLatLng);
        this.aMap.moveCamera(CameraUpdateFactory.zoomTo(zoom));

        let latLngBounds = new LatLngBounds(this.southwestLatLng, this.northeastLatLng);
        this.aMap.setMapStatusLimits(latLngBounds);
    }

    private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_BOUND_LIMIT_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_BOUND_LIMIT_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true);
            this.aMap.addMarker(new MarkerOptions().setPosition(this.southwestLatLng));
            this.aMap.addMarker(new MarkerOptions().setPosition(this.northeastLatLng));

            this.aMap.moveCamera(CameraUpdateFactory.zoomTo(8));

            let pOption = new PolygonOptions().setZIndex(0);
            pOption.add(new LatLng(this.southwestLatLng.latitude, this.northeastLatLng.longitude));
            pOption.add(this.southwestLatLng);
            pOption.add(new LatLng(this.northeastLatLng.latitude, this.southwestLatLng.longitude));
            pOption.add(this.northeastLatLng);
            this.aMap.addPolygon(pOption.setStrokeWidth(4)
                .setStrokeColor(Constants.rgbaStringToArgbInt("rgba(1.0, 0.0, 0.0, 1.0)"))
                .setFillColor(Constants.rgbaStringToArgbInt("rgba(0.1, 0.1, 0.1, 0.26)")));
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_BOUND_LIMIT_FUNC, "aboutToAppear");
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
        hilog.info(0xff, Constants.MAP_BOUND_LIMIT_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildBoundLimitShow();
        }
        .title(Constants.MAP_BOUND_LIMIT_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

