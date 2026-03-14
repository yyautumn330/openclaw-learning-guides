import {
    AMap,
    BitmapDescriptorFactory,
    CameraPosition,
    GL3DModel,
    GL3DModelOptions,
    LatLng,
    MapView,
    MapViewComponent,
    MapViewManager,
    OnCameraChangeListener
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import util from '@ohos.util';

let globalContext: Context;

@Component
export struct MapGL3DModelController {
    private mapView? : MapView;
    private aMap? : AMap;
    private aId : number = 0;
    private gl3DModel?: GL3DModel;
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

    //GL3DModel功能
    @Builder
    buildMapGL3DModel() {
        Stack() {
            MapViewComponent({ mapViewName: Constants.MAP_GL3DMODEL_FUNC }).zIndex(0)
            Column() {
                Button("添加")
                    .onClick(() => {
                        this.addGL3DModel();
                    })
                Button("移除")
                    .onClick(() => {
                        this.removeGL3DModel();
                    })
            }
            .position({ x: 10, y: 10 })
        }.width('100%')
        .height('100%')
    }

    public async addGL3DModel(): Promise<void> {
        if (this.gl3DModel) {
            return;
        }
        // vertexData string
        let options = new GL3DModelOptions();
        let data = globalContext.resourceManager.getRawFileContentSync('obj/logistic_detail_3d_truck.obj');
        let decoder = util.TextDecoder.create('utf-8');
        let content = decoder.decodeWithStream(new Uint8Array(data));

        options.angle(50)
            .position(new LatLng(39.955436, 116.335769))
            .setAltitude(1000)
            .setFixDisplaySize(100, 100)
            .setFixedDisplaySizeEnabled(true)
            .setModelFixedLength(1000)
            .setVisible(true)
            .setZIndex(5)
                // .setSnippet("gl3dmodel")
                // .setTitle("amap3d")
            .vertexData(content)

        let texture = await BitmapDescriptorFactory.fromRawfilePath(globalContext,
            'obj/babel_order_logistic_detail_3d_truck_transport.png');
        if (texture) {
            options.textureDrawable(texture);
        }

        this.gl3DModel = this.aMap?.addGL3DModel(options);
        this.gl3DModel?.showInfoWindow();
    }

    public removeGL3DModel(): void {
        if (this.gl3DModel) {
            this.gl3DModel.remove();
            this.gl3DModel = undefined;
        }
    }

    private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
        if (!mapview || this.mapView) {
            return;
        }

        if (mapViewName != Constants.MAP_GL3DMODEL_FUNC) {
            return;
        }

        this.mapView = mapview;

        this.mapView.onCreate();
        this.mapView.getMapAsync((map) => {
            this.aMap = map;

            hilog.info(0xff, Constants.MAP_GL3DMODEL_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

            this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_GL3DMODEL_FUNC,
                        `map change ${position.target.longitude} ${position.target.latitude}`);
                },
                (position: CameraPosition) => {
                    hilog.info(0xff, Constants.MAP_GL3DMODEL_FUNC,
                        `map finish ${position.target.longitude} ${position.target.latitude}`);
                }));
            this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
        })

    }

    aboutToAppear(): void {
        globalContext = getContext().getApplicationContext();
        MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
        hilog.info(0xff, Constants.MAP_GL3DMODEL_FUNC, "aboutToAppear");
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

        hilog.info(0xff, Constants.MAP_GL3DMODEL_FUNC, "aboutToDisappear");
    }



    build() {
        NavDestination() {
            this.buildMapGL3DModel();
        }
        .title(Constants.MAP_GL3DMODEL_FUNC)
        .onBackPressed(() => {
            const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
            console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
            return true;
        })

    }
}

