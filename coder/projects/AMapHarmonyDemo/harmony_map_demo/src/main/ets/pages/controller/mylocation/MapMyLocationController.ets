import {
    AMap,
    BitmapDescriptorFactory,
    CameraUpdateFactory,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    MarkerOptions,
    MyLocationStyle,
    OnLocationChangedListener,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { BusinessError } from '@ohos.base';
import geoLocationManager from '@ohos.geoLocationManager';

let globalContext: Context;
@Component
export struct MapMyLocationController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    private locationStyle: MyLocationStyle = new MyLocationStyle();
    private intervalId = 0;
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

    public updateLocationStyle(style:number) {
        this.locationStyle.myLocationType(style);
        this.aMap?.setMyLocationStyle(this.locationStyle);
    }

    //location功能
    @Builder
    buildMapMyLocation() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_MYLOCATION_FUNC }).zIndex(0)
            Column() {
                Row() {
                    Radio({ value: "展示", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_SHOW);
                            }
                        })
                    Text("展示")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "定位", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_LOCATE);
                            }
                        })
                    Text("定位")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "跟随", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_FOLLOW);
                            }
                        })
                    Text("跟随")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "地图旋转", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_MAP_ROTATE);
                            }
                        })
                    Text("地图旋转")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "定位点旋转", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE);
                            }
                        })
                    Text("定位点旋转")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "定位点旋转不移中心", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER);
                            }
                        })
                    Text("定位点旋转不移中心")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "跟随不移中心", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_FOLLOW_NO_CENTER);
                            }
                        })
                    Text("跟随不移中心")
                }

                Divider().strokeWidth(2).color('#ff030303')

                Row(){
                    Radio({ value: "地图旋转不移中心", group: "locationType" })
                        .checked(false)
                        .radioStyle({
                            checkedBackgroundColor: Color.Pink
                        })
                        .onChange((checked: boolean) => {
                            if (checked) {
                                this.updateLocationStyle(MyLocationStyle.LOCATION_TYPE_MAP_ROTATE_NO_CENTER);
                            }
                        })
                    Text("地图旋转不移中心")
                }
                Button("clear")
                    .onClick(()=> {
                        this.aMap?.clear(true);
                    })

            }.position({ x: 10, y: 10 })
            .width('50%')
            .alignItems(HorizontalAlign.Start)
            .backgroundColor('#ccbebebe')
            .zIndex(1)
        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_MYLOCATION_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync(async (map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_MYLOCATION_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);
            this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(40.024279, 116.434153), 13));
            // // add mylocation
            this.locationStyle.myLocationType(MyLocationStyle.LOCATION_TYPE_SHOW);
            let icon = await BitmapDescriptorFactory.fromRawfilePath(globalContext, "common/location_map_gps_locked.png");
            if (icon) {
                this.locationStyle.myLocationIcon(icon);
            }
            this.aMap?.setMyLocationStyle(this.locationStyle);
            this.aMap?.setLocationSource(this);
            this.aMap?.setMyLocationEnabled(true);

            // add Marker
            let options1: MarkerOptions = new MarkerOptions();
            let bitmapDes = await BitmapDescriptorFactory.fromRawfilePath(globalContext, "common/marker_default.png");
            if (bitmapDes) {
                options1.setIcon(bitmapDes);
            }

            options1.setDraggable(true);
            //116.434153,40.024279
            options1.setPosition(new LatLng(40.024279, 116.434153));
            options1.setAnchor(0.5, 1.0);
            // options.setPosition(new LatLng(40.02380181476392, 116.43124537956452));
            options1.setTitle('Anno');
            options1.setSnippet('111111111')
            // options.setVisible(false);
            // options.setIcon(new BitmapDescriptor($rawfile('location_map_gps_locked.png'), 'location_map_gps_locked', 100, 100));
            let marker1 = this.aMap?.addMarker(options1);

            hilog.info(0xff, Constants.MAP_MYLOCATION_FUNC, `get location ${this.aMap?.getMyLocation()?.latitude} ${this.aMap?.getMyLocation()?.longitude}`);
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })
    }

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_MYLOCATION_FUNC, "aboutToAppear");
    }

    aboutToDisappear(): void {
        if (this.aMap) {
            this.aMap.setMyLocationEnabled(false);
        }
        
        if (this.mapViewCreateCallback) {
            MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
        }

        if (this.mapView) {
            this.mapView.onDestroy();
            this.mapView = undefined;
            this.aMap = undefined;
        }

        hilog.info(0xff, Constants.MAP_MYLOCATION_FUNC, "aboutToDisappear");
    }

    activate(listener: OnLocationChangedListener): void {
        let location: geoLocationManager.Location = {
            accuracy: 1000,
            altitude: 0,
            direction: 0,
            //116.438055,40.025108
            latitude: 40.025108,
            longitude: 116.438055,
            speed: 0,
            timeSinceBoot: 123587419434256,
            timeStamp: 0,
            altitudeAccuracy: 0,
            speedAccuracy: 0,
            directionAccuracy: 0,
            uncertaintyOfTimeSinceBoot: 10,
            sourceType: 1 // 暂时使用number类型，预计720解决
        };

        listener.onLocationChanged(location);

        if (this.intervalId == 0) {
            this.intervalId = setInterval(() => {
                try {
                    listener.onLocationChanged(location);
                } catch (e) {
                    console.info((e as BusinessError).message);
                }
            }, 1000);
        }
    }

    deactivate() {
        if (this.intervalId > 0) {
            clearInterval(this.intervalId);
            this.intervalId = 0;
        }
    }

    build() {
        NavDestination() {
            this.buildMapMyLocation();
        }
        .title(Constants.MAP_MYLOCATION_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

