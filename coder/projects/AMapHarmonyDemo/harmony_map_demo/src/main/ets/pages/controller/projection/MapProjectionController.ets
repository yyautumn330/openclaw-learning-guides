import {
    AMap,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    Point
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import display from '@ohos.display';

@Component
export struct MapProjectionController {
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
    buildProjectionMap() {
        Column() {
            MapViewComponent({ mapViewName: Constants.MAP_PROJECTION_FUNC })
        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_PROJECTION_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_PROJECTION_FUNC,
                `get map ${this.aMap?.getCameraPosition()?.zoom} ${this.aMap?.getCameraPosition()?.target.longitude} ${this.aMap?.getCameraPosition()?.target.latitude}`);

            let projection = this.aMap?.getProjection();

            if (projection) {
                let fromScreenLocationPoint = projection.fromScreenLocationSync(new Point(100, 100));
                hilog.info(0xff, Constants.MAP_PROJECTION_FUNC,
                    `fromScreenLocationPoint ${fromScreenLocationPoint.latitude} ${fromScreenLocationPoint.longitude}`);

                let toScreenLocationPoint = projection.toScreenLocationSync(new LatLng(30.069625, 120.282487));
                hilog.info(0xff, Constants.MAP_PROJECTION_FUNC,
                    `toScreenLocationPoint ${toScreenLocationPoint.x} ${toScreenLocationPoint.y}`);

                let toMapLocationPoint = projection.toMapLocation(new LatLng(30.069625, 120.282487));
                hilog.info(0xff, Constants.MAP_PROJECTION_FUNC, `toMapLocation ${toMapLocationPoint.x} ${toMapLocationPoint.y}`);

                let width = display.getDefaultDisplaySync().width;
                let toOpenGLWidth = projection.toOpenGLWidth(width);
                hilog.info(0xff, Constants.MAP_PROJECTION_FUNC, `toOpenGLWidth ${toOpenGLWidth}`);

                let visibleRegion = projection.getVisibleRegion();
                if (visibleRegion) {
                    hilog.info(0xff, Constants.MAP_PROJECTION_FUNC,
                        `visibleRegion ${visibleRegion.nearLeft.longitude} ${visibleRegion.nearLeft.latitude} ${visibleRegion.nearRight.longitude} ${visibleRegion.nearRight.latitude} ${visibleRegion.farLeft.longitude} ${visibleRegion.farLeft.latitude} ${visibleRegion.farRight.longitude} ${visibleRegion.farRight.latitude}`);
                }

                let mapBounds = projection.getMapBounds(new LatLng(30.069625, 120.282487), 10);
                if (mapBounds) {
                    hilog.info(0xff, Constants.MAP_PROJECTION_FUNC,
                        `mapBounds ${mapBounds.southwest.longitude} ${mapBounds.southwest.latitude} ${mapBounds.northeast.longitude} ${mapBounds.northeast.latitude}`);
                }
            }
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_PROJECTION_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_PROJECTION_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildProjectionMap();
        }
        .title(Constants.MAP_PROJECTION_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })
    }
}

