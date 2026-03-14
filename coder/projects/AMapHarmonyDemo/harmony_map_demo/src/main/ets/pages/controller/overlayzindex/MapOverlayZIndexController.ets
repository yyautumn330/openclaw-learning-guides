import {
    AMap,
    BitmapDescriptorFactory,
    GL3DModelOptions,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    Marker,
    MarkerOptions,
    Polyline,
    Polygon,
    PolylineOptions,
    PolygonOptions,
    GL3DModel,
    OnCameraChangeListener,
    CameraPosition,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import util from '@ohos.util';

let globalContext: Context;

@Component
export struct MapOverlayZIndexController {
    private mapView?: MapView;
    private aMap?: AMap;
    private aId: number = 0;
    @Consume('pageInfos') pageInfos: NavPathStack;
    @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
    private marker?: Marker;
    private polyline?: Polyline;
    private polygon?: Polygon;
    private gl3dModel?: GL3DModel;
    private mapTextZIndex: number = 0;
    private markerZIndex: number = 40;
    private polylineZIndex: number = 30;
    private polygonZIndex: number = 20;
    private gl3DModelZIndex: number = 10;
    private cameraMarker?: Marker;

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

    public changeMapTextZIndex(zindex: number): void {
        if (zindex > 0) {
            this.mapTextZIndex = zindex;
        }
    }

    public changeMarkerZIndex(zindex: number): void {
        if (zindex > 0) {
            this.markerZIndex = zindex;
        }
    }

    public changePolylineZIndex(zindex: number): void {
        if (zindex > 0) {
            this.polylineZIndex = zindex;
        }
    }

    public changePolygonZIndex(zindex: number): void {
        if (zindex > 0) {
            this.polygonZIndex = zindex;
        }
    }

    public change3DModelZIndex(zindex: number): void {
        if (zindex > 0) {
            this.gl3DModelZIndex = zindex;
        }
    }

    public changeZIndex(): void {
        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC,
            `changeZIndex ${this.mapTextZIndex} ${this.markerZIndex} ${this.polylineZIndex} ${this.polygonZIndex} ${this.gl3DModelZIndex}`);
        if (this.aMap) {
            this.aMap.setMapTextZIndex(this.mapTextZIndex);
        }
        if (this.marker) {
            this.marker.setZIndex(this.markerZIndex);
        }
        if (this.polyline) {
            this.polyline.setZIndex(this.polylineZIndex);
        }
        if (this.polygon) {
            this.polygon.setZIndex(this.polygonZIndex);
        }
        if (this.gl3dModel) {
            this.gl3dModel.setZIndex(this.gl3DModelZIndex);
        }
    }

    @Builder
    buildOverlayZIndex() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_OVERLAY_ZINDEX_FUNC }).zIndex(0)
            Column() {
                TextInput({ placeholder: "输入MapZIndex" })
                    .padding({ bottom: 10 })
                    .type(InputType.Number)
                    .zIndex(2)
                    .onChange((value: string) => {
                        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, `MapZIndex value ${value}`);
                        this.changeMapTextZIndex(parseInt(value));
                    })
                Divider().strokeWidth(1).color('#ff030303')
                TextInput({ placeholder: "输入Marker的zIndex" })
                    .padding({ bottom: 10 })
                    .type(InputType.Number)
                    .zIndex(2)
                    .onChange((value: string) => {
                        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, `MarkerZIndex value ${value}`);
                        this.changeMarkerZIndex(parseInt(value));
                    })
                Divider().strokeWidth(1).color('#ff030303')
                TextInput({ placeholder: "输入polyline的zIndex" })
                    .padding({ bottom: 10 })
                    .type(InputType.Number)
                    .zIndex(2)
                    .onChange((value: string) => {
                        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, `PolylineZIndex value ${value}`);
                        this.changePolylineZIndex(parseInt(value));
                    })
                Divider().strokeWidth(1).color('#ff030303')
                TextInput({ placeholder: "输入polygon的zIndex" })
                    .padding({ bottom: 10 })
                    .type(InputType.Number)
                    .zIndex(2)
                    .onChange((value: string) => {
                        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, `PolygonZIndex value ${value}`);
                        this.changePolygonZIndex(parseInt(value));
                    })
                Divider().strokeWidth(1).color('#ff030303')
                TextInput({ placeholder: "输入3DModel的zIndex" })
                    .padding({ bottom: 10 })
                    .type(InputType.Number)
                    .zIndex(2)
                    .onChange((value: string) => {
                        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, `gledModelZIndex value ${value}`);
                        this.change3DModelZIndex(parseInt(value));
                    })
                Divider().strokeWidth(1).color('#ff030303')

                Button("修改ZIndex")
                    .zIndex(2)
                    .onClick(() => {
                        this.changeZIndex();
                    })
            }
            .position({ x: 10, y: 10 })
            .zIndex(1)
            .backgroundColor("#ccbebebe")
            .width('40%')
        }
        .width('100%')
        .height('100%')
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_OVERLAY_ZINDEX_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync(async (map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            // marker
            let options: MarkerOptions = new MarkerOptions();
            let bitmapDes = await BitmapDescriptorFactory.fromRawfilePath(globalContext, "icon_car.png");
            if (bitmapDes) {
                options.setIcon(bitmapDes);
            }
            options.setPosition(new LatLng(39.992520, 116.336170));
            this.marker = this.aMap?.addMarker(options);

            // gl3dmodel
            let modelOptions = new GL3DModelOptions();
            let data = globalContext.resourceManager.getRawFileContentSync('obj/logistic_detail_3d_truck.obj');
            let decoder = util.TextDecoder.create('utf-8');
            let content = decoder.decodeWithStream(new Uint8Array(data));

            modelOptions.vertexData(content)
            modelOptions.position(new LatLng(39.992520, 116.336170))
                .setModelFixedLength(100)
                .setFixedDisplaySizeEnabled(true)
                .setFixDisplaySize(50, 50)
            let texture = await BitmapDescriptorFactory.fromRawfilePath(globalContext,
                'obj/babel_order_logistic_detail_3d_truck_transport.png');
            if (texture) {
                modelOptions.textureDrawable(texture);
            }

            this.gl3dModel = this.aMap?.addGL3DModel(modelOptions);

            // polyline
            let polylineOptions = new PolylineOptions();
            polylineOptions.add(Constants.BEIJING, Constants.SHANGHAI);
            this.polyline = this.aMap.addPolyline(polylineOptions);

            // polygon
            let pOptions: PolygonOptions = new PolygonOptions();
            let lat = Constants.BEIJING.latitude;
            let log = Constants.BEIJING.longitude;
            let latLng0 = new LatLng(lat - 0.1, log - 0.1);
            let latLng1 = new LatLng(lat + 0.1, log + 0.1);
            let latLng2 = new LatLng(lat - 0.1, log + 0.1);
            let latLng3 = new LatLng(lat + 0.1, log - 0.1);
            pOptions.add(latLng0);
            pOptions.add(latLng2);
            pOptions.add(latLng1);
            pOptions.add(latLng3);
            this.polygon =
                this.aMap?.addPolygon(pOptions.setFillColor(0xFFCCCCCC).setStrokeColor(0xffff0000).setStrokeWidth(10));
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)

            if (this.aMap) {
                this.aMap.setOnCameraChangeListener(new OnCameraChangeListener(
                    (position: CameraPosition) => {
                    },
                    (position: CameraPosition) => {
                        this.updateCameraCenterMarker(position.target)
                    }
                ))
                const currentPos = this.aMap.getCameraPosition()
                if (currentPos) {
                    this.updateCameraCenterMarker(currentPos.target)
                }
            }
        })
    }

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, "aboutToAppear");
    }

    aboutToDisappear(): void {
        if (this.mapViewCreateCallback) {
            MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
        }

        if (this.marker) {
            this.marker.remove();
        }

        if (this.polyline) {
            this.polyline.remove();
        }

        if (this.polygon) {
            this.polygon.remove();
        }

        if (this.gl3dModel) {
            this.gl3dModel.remove();
        }

        if (this.mapView) {
            this.mapView.onDestroy();
            this.mapView = undefined;
            this.aMap = undefined;
        }

        hilog.info(0xff, Constants.MAP_OVERLAY_ZINDEX_FUNC, "aboutToDisappear");
    }

    build() {
        NavDestination() {
            this.buildOverlayZIndex();
        }
        .title(Constants.MAP_OVERLAY_ZINDEX_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }

    private updateCameraCenterMarker(center: LatLng): void {
        if (!this.aMap) {return}

        if (!this.cameraMarker) {
            const options = new MarkerOptions()
                .setPosition(center)
                .setZIndex(100)
                .setInfoWindowEnable(true)

            this.cameraMarker = this.aMap.addMarker(options);
            if (this.cameraMarker) {
                this.cameraMarker.setTitle(`marker \nzIndex:${this.cameraMarker.getZIndex()}`)
            }
        } else {
            this.cameraMarker.setPosition(center);
            this.cameraMarker.setTitle(`marker \nzIndex:${this.cameraMarker.getZIndex()}`)
        }
    }


}

