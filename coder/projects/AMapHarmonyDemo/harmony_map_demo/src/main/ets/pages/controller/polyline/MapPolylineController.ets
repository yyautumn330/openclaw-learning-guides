import {
    AMap,
    BitmapDescriptor,
    BitmapDescriptorFactory,
    CameraPosition,
    CameraUpdateFactory,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    OnCameraChangeListener,
    PolylineOptions,
    Polyline,
    LatLngBoundsBuilder,
    MarkerOptions,
    Marker
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import ArrayList from '@ohos.util.ArrayList';

let globalContext: Context;
@Component
export struct MapPolylineController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    private Lat_A = 35.909736;
    private Lon_A = 80.947266;
    private Lat_B = 35.909736;
    private Lon_B = 89.947266;
    private Lat_C = 31.909736;
    private Lon_C = 89.947266;
    private Lat_D = 31.909736;
    private Lon_D = 99.947266;
    private polylineSolid?: Polyline;
    private solidMarkerList = new ArrayList<Marker>()
    private polylineDotted?: Polyline;
    private polylineWithTexture?: Polyline;
    private polylineCross180?: Polyline;
    private polylineCrossMinus180?: Polyline;
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
     *  从左到右绘制一条跨越180°的线，右边部分需要处理成超过180度
     *  正常经纬度范围是(-180°,180°)，这里为了可以超过180°第三个参数填写false，表示去除内部检查
     */
    private latLngs_cross_180: LatLng[] = [
        new LatLng(59.304104, 133.44508),
        new LatLng(62.220912, 145.573986),
        new LatLng(64.353281, 158.75758),
        new LatLng(64.880724, 170.886486),
        new LatLng(66.261601, 360 - 179.269764),
        new LatLng(66.048417, 360 - 155.539295),
        new LatLng(65.251242, 360 - 143.234608)
    ];
    /**
     * 从右到左绘制一条跨越-180°的线，左边部分会超过-180°，效果和跨域180°一样
     * 也可以将点全部+360°转换成跨域180°的线
     */
    private latLngs_cross_minus_180: LatLng[] = [
        new LatLng(65.251242 - 10, -143.234608),
        new LatLng(66.048417 - 10, -155.539295),
        new LatLng(66.261601 - 10, -179.269764),
        new LatLng(64.880724 - 10, 170.886486 - 360),
        new LatLng(64.353281 - 10, 158.75758 - 360),
        new LatLng(62.220912 - 10, 145.573986 - 360),
        new LatLng(59.304104 - 10, 133.44508 - 360),
    ];

    // 实线
    public addPolineSolid() {
        // let A = new LatLng(this.Lat_A, this.Lon_A);
        // let B = new LatLng(this.Lat_B, this.Lon_B);
        // let C = new LatLng(this.Lat_C, this.Lon_C);
        // let D = new LatLng(this.Lat_D, this.Lon_D);
        // let options = new PolylineOptions();
        // options.add(A);
        // options.add(B);
        // options.add(C);
        // options.add(D);
        // options.setWidth(10);
        // // let colorValues = new Int32Array(3);
        // // colorValues[0] = 0xffff0000;
        // // colorValues[1] = 0xff00ff00;
        // // colorValues[2] = 0xff0000ff;
        // // options.setColorValues(colorValues);
        // options.setColor(0xabec7c29);
        // this.polylineSolid = this.aMap?.addPolyline(options);

        if(!this.solidMarkerList.isEmpty()){
            return
        }
        let list = new ArrayList<LatLng>();
        list.add(new LatLng(26.91403,119.415525));
        list.add(new LatLng(26.91703,119.416525));
        list.add(new LatLng(26.91683,119.417425));
        list.add(new LatLng(26.91503,119.417625));
        list.add(new LatLng(26.91593,119.417525));
        list.add(new LatLng(26.92593,119.418525));
        let b = new LatLngBoundsBuilder();
        list.forEach((latlng)=>{
            this.solidMarkerList.add(this.aMap?.addMarker(new MarkerOptions().setPosition(latlng)));
            b.include(latlng);
        })
        if(this.polylineSolid){
            return
        }
        let options = new PolylineOptions()
        options.setPoints(list);
        options.setColor(0xff999999);
        options.setWidth(30);
        options.setEraseColor(true,0xff860000);
        options.setShownRange(3.5,4.5);
        this.polylineSolid = this.aMap?.addPolyline(options);
        this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(26.91403,119.415525), 15));
        // this.aMap?.moveCamera(CameraUpdateFactory.newLatLngBounds(b?.build(),40))
    }

    public removePolineSolid() {
        if (this.polylineSolid) {
            this.polylineSolid.remove();
            this.polylineSolid = undefined;
        }
        if(!this.solidMarkerList.isEmpty()){
            for (let item of this.solidMarkerList){
                item.remove()
            }
            this.solidMarkerList.clear()
        }
    }

    // 虚线
    public addPolineDotted() {
        if(this.polylineDotted){
            return
        }
        this.polylineDotted = this.aMap?.addPolyline((new PolylineOptions())
            .add(Constants.SHANGHAI, Constants.BEIJING, Constants.CHENGDU)
            .setWidth(10)
            .setDottedLine(true)//设置虚线
            .setColor(0xff010101));
        this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(Constants.BEIJING, 5));
    }

    public removePolineDotted() {
        if (this.polylineDotted) {
            this.polylineDotted.remove();
            this.polylineDotted = undefined;
        }
    }

    // 纹理线
    public async addPolineWithTexture() {
        if(this.polylineWithTexture){
            return
        }
        //四个点
        let A = new LatLng(this.Lat_A + 1, this.Lon_A + 1);
        let B = new LatLng(this.Lat_B + 1, this.Lon_B + 1);
        let C = new LatLng(this.Lat_C + 1, this.Lon_C + 1);
        let D = new LatLng(this.Lat_D + 1, this.Lon_D + 1);

        //用一个数组来存放纹理
        let texTuresList = new ArrayList<BitmapDescriptor>();
        // texTuresList.add(await BitmapDescriptorFactory.fromRawfilePath(globalContext, "map_alr.png"));
        texTuresList.add(await BitmapDescriptorFactory.defaultMarkerASync(globalContext, BitmapDescriptorFactory.HUE_YELLOW));
        texTuresList.add(await BitmapDescriptorFactory.fromRawfilePath(globalContext, "custtexture.png"));
        texTuresList.add(await BitmapDescriptorFactory.fromRawfilePath(globalContext, "map_alr_night.png"));

        //指定某一段用某个纹理，对应texTuresList的index即可, 四个点对应三段颜色
        let texIndexList = new Int32Array(3);
        texIndexList[0] = 0; //对应上面的第0个纹理
        texIndexList[1] = 2;
        texIndexList[2] = 1;
        let options = new PolylineOptions();
        options.setWidth(20); //设置宽度
        //加入四个点
        options.add(A, B, C, D);
        //加入对应的颜色,使用setCustomTextureList 即表示使用多纹理；
        options.setCustomTextureList(texTuresList);

        //设置纹理对应的Index
        options.setCustomTextureIndex(texIndexList);

        this.polylineWithTexture = this.aMap?.addPolyline(options);
        this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(C, 5));
    }

    public removePolineWithTexture() {
        if (this.polylineWithTexture) {
            this.polylineWithTexture.remove();
            this.polylineWithTexture = undefined;
        }
    }

    public async addBeyond180Polylines() {
        if(this.polylineCross180){
            return
        }
        let latLngList: ArrayList<LatLng> = new ArrayList();
        for (let latLng of this.latLngs_cross_180) {
            latLngList.add(latLng);
        }
        this.polylineCross180 = this.aMap?.addPolyline((new PolylineOptions())
            .addAll(latLngList)
            .setWidth(40)
            .setCustomTexture(await BitmapDescriptorFactory.fromRawfilePath(globalContext,
                "custtexture.png") as BitmapDescriptor));

        ///////////////////////////////////////////

        if(this.polylineCrossMinus180){
            return
        }
        latLngList.clear();
        for (let latLng of this.latLngs_cross_minus_180) {
            latLngList.add(latLng);
        }
        this.polylineCrossMinus180 = this.aMap?.addPolyline((new PolylineOptions())
            .addAll(latLngList)
            .setWidth(40)
            .setCustomTexture(await BitmapDescriptorFactory.fromRawfilePath(globalContext,
                "custtexture.png") as BitmapDescriptor));
        this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(64.880724 - 10, 170.886486 - 360), 1));
    }

    public removeBeyond180Polylines() {
        if (this.polylineCross180) {
            this.polylineCross180.remove();
            this.polylineCross180 = undefined;
        }

        if (this.polylineCrossMinus180) {
            this.polylineCrossMinus180.remove();
            this.polylineCrossMinus180 = undefined;
        }
    }


    //polyline功能
    @Builder
    buildMapPolyline() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_POLYLINE_FUNC })
            Column() {
                Row() {
                    Button("实线")
                        .onClick(() => {
                            this.addPolineSolid();
                        })

                    Button("移除")
                        .onClick(() => {
                            this.removePolineSolid();
                        })
                }


                Row() {
                    Button("虚线")
                        .onClick(() => {
                            this.addPolineDotted();
                        })

                    Button("移除")
                        .onClick(() => {
                            this.removePolineDotted();
                        })
                }


                Row() {
                    Button("纹理线")
                        .onClick(() => {
                            this.addPolineWithTexture();
                        })
                    Button("移除")
                        .onClick(() => {
                            this.removePolineWithTexture();
                        })
                }


                Row() {
                    Button("大地线")
                        .onClick(() => {
                            this.addBeyond180Polylines();
                        })
                    Button("移除")
                        .onClick(() => {
                            this.removeBeyond180Polylines();
                        })
                }
            }.position({ x: 10, y: 10 })

        }.width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_POLYLINE_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync(async (map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            let uisettings = this.aMap?.getUiSettings();
            let projection = this.aMap?.getProjection();


            this.aMap?.setOnMapClickListener((point: LatLng) => {
                hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, `map click ${point.longitude} ${point.latitude}`);
            });

            this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_POLYLINE_FUNC,
                        `map change ${position.target.longitude} ${position.target.latitude}`);
                },
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_POLYLINE_FUNC,
                        `map finish ${position.target.longitude} ${position.target.latitude}`);
                }));

            this.aMap?.setOnMapTouchListener((event: TouchEvent) => {
                hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, `map touch ${event.touches[0].x} ${event.touches[0].y}`);
            });

            this.aMap?.setAMapGestureListener((event: GestureEvent) => {
                hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, `map gesture ${event.offsetX} ${event.offsetY}`);
            });

            this.aMap?.setOnMapLongClickListener((point: LatLng) => {
                hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, `map long click ${point.longitude} ${point.latitude}`);
            });

            this.aMap?.setOnPolylineClickListener((polyline: Polyline) => {
                hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, `map polyline click ${polyline.getId()}`);
            });

            this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(39.300299, 106.347656), 4));
            this.aMap?.setMapTextZIndex(2);


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
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_POLYLINE_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapPolyline();
        }
        .title(Constants.MAP_POLYLINE_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

