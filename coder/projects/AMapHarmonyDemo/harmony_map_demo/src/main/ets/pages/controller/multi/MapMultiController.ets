import {
    AMap,
    BitmapDescriptorFactory,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewCreateCallback,
    MapViewManager,
    MarkerOptions,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import HashMap from '@ohos.util.HashMap';

const multiMapName1 = "multiMap1";
const multiMapName2 = "multiMap2";
const multiMapName3 = "multiMap3";
let globalContext: Context;


@Component
export struct MapMultiController {
    @State multiMap1Show: boolean = false
    @State multiMap2Show: boolean = false
    @State multiMap3Show: boolean = false
    private mapView?: MapView;
    private aMap?: AMap;
    private aId: number = 0;
    private mapViews: HashMap<string, MapView> = new HashMap();
    private maps: HashMap<string, AMap> = new HashMap();
    private mapViewNames = [multiMapName1, multiMapName2, multiMapName3]
    @Consume('pageInfos') pageInfos: NavPathStack;
    @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

    onPageShow(): void {
        // 恢复所有 MapView
        try {
            this.mapViews.forEach((mapView: MapView, key: string) => {
                mapView?.onResume();
            })
        } catch (error) {
            hilog.info(0xff, Constants.MAP_MULTI_FUNC, "onPageShow");
        }
    }

    onPageHide(): void {
        // 暂停所有 MapView
        try {
            this.mapViews.forEach((mapView: MapView, key: string) => {
                mapView?.onPause();
            })
        } catch (error) {
            hilog.info(0xff, Constants.MAP_MULTI_FUNC, "onPageHide");
        }
    }

    pageChange(changedPropertyName: string) {
        if (this.isPageHide === true) {
            this.onPageHide()
        } else {
            this.onPageShow()
        }
    }

    // 多实例
    @Builder
    buildMultiMap() {
        Column() {
            Stack() {
                Row(){
                    MapViewComponent({ mapViewName: multiMapName1 }).zIndex(0)
                }.visibility(this.multiMap1Show?Visibility.Visible:Visibility.Hidden)

                Button("第一个地图")
                    .onClick(() => {
                        this.multiMap1Show = !this.multiMap1Show;
                    })
            }.height('30%')

            Divider().height('1%').backgroundColor(Color.Gray)

            Stack() {
                Row(){
                    MapViewComponent({ mapViewName: multiMapName2 }).zIndex(0)
                }.visibility(this.multiMap2Show?Visibility.Visible:Visibility.Hidden)

                Button("第二个地图")
                    .onClick(() => {
                        this.multiMap2Show = !this.multiMap2Show;
                    })
            }.height('30%')

            Divider().height('1%').backgroundColor(Color.Gray)

            Stack() {
                Row(){
                    MapViewComponent({ mapViewName: multiMapName3 }).zIndex(0)
                }.visibility(this.multiMap3Show?Visibility.Visible:Visibility.Hidden)

                Button("第三个地图")
                    .onClick(() => {
                        this.multiMap3Show = !this.multiMap3Show;
                    })
            }.height('30%')
        }
        .parallelGesture(PanGesture())
    }

    private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        hilog.info(0xff, Constants.MAP_MULTI_FUNC, 'mapview create ' + mapViewName);

        if (!mapview || this.mapViews.get(mapViewName)) {
            return;
        }

        if (!this.mapViewNames.includes(mapViewName!)) {
            return;
        }

        mapview.onCreate();

        this.mapViews.set(mapViewName, mapview)

        let mapView = this.mapViews.get(mapViewName);
        if (mapView) {
            mapView.getMapAsync(async (map) => {
                this.maps.set(mapViewName, map);

                hilog.info(0xff, Constants.MAP_MULTI_FUNC, 'get map ' + this.maps.get(mapViewName)?.getCameraPosition()?.zoom);


                // marker
                let options: MarkerOptions = new MarkerOptions();
                let bitmapDes = await BitmapDescriptorFactory.fromRawfilePath(globalContext, "icon_car.png");
                if (bitmapDes) {
                    options.setIcon(bitmapDes);
                }
                options.setPosition(new LatLng(39.992520, 116.336170));
                //目前这个功能取消marker
                // let marker = map?.addMarker(options);

            })
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        }
    };

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_MULTI_FUNC, "aboutToAppear");
    }

    aboutToDisappear(): void {
        if (this.mapViewCreateCallback) {
            MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
        }

        this.maps.forEach((map, mapViewName) => {
            hilog.info(0xff, Constants.MAP_MULTI_FUNC, 'map clear ' + mapViewName);
            if (map) {
                map.clear();
            }
        })

        this.mapViews.forEach((mapview, mapViewName) => {
            hilog.info(0xff, Constants.MAP_MULTI_FUNC, 'map destroy ' + mapViewName);

            if (mapview) {
                mapview.onDestroy();
            }
        })

        this.maps.clear();
        this.mapViews.clear();

        hilog.info(0xff, Constants.MAP_MULTI_FUNC, "aboutToDisappear");
    }

    build() {
        NavDestination() {
            this.buildMultiMap();
        }
        .title(Constants.MAP_MULTI_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })
    }
}

