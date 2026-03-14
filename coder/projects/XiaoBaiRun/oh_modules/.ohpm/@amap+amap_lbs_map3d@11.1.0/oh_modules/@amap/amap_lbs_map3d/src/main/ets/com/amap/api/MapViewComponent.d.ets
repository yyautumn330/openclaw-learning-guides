// @keepTs
// @ts-nocheck
import { d12 } from '../mapcore/interface/bridge/IMapViewBridge';
import matrix4 from '@ohos.matrix4';
/**
 * 地图自定义组件
 */
@Component
export declare struct MapViewComponent {
    moduleName: string;
    mapViewName: string;
    type: string;
    soName: string;
    engineId: number;
    mapViewBridge?: d12;
    waitingEnable: boolean;
    @State
    isDestroying: boolean;
    @State
    infoWindowContainerX: number;
    @State
    infoWindowContainerY: number;
    @State
    showInfoWindowContainer: boolean;
    @State
    infoWindowTile: string;
    @State
    infoWindowSnippet: string;
    private currentMarker?;
    @State
    mapViewWidth: number;
    @State
    mapViewHeight: number;
    @State
    blankViewEnable: boolean;
    @State
    blankViewColor: string;
    @State
    locationViewEnable: boolean;
    @State
    locationViewImage: Resource;
    @State
    compassViewEnable: boolean;
    @State
    compassViewImage: Resource | PixelMap | undefined;
    @State
    compassViewMatrix: matrix4.Matrix4Transit;
    @State
    scaleViewEnable: boolean;
    private scaleCanvasSettings;
    private scaleCanvasContext;
    @State
    zoomControlsEnable: boolean;
    @State
    zoomIncreaseResource: Resource;
    @State
    zoomDecreaseResource: Resource;
    @State
    zoomLevel: number;
    @State
    maxZoomLevel: number;
    @State
    minZoomLevel: number;
    @State
    zoomControllerPosition: number;
    @State
    zoomControllerPositionX: number;
    @State
    keyboardHeight: number;
    @State
    zoomControllerPositionY: number;
    @State
    waterMarkerViewEnable: boolean;
    private waterMarkerCanvasSettings;
    private waterMarkerCanvasContext;
    @Builder
    renderInfoWindowDefault(): void;
    @BuilderParam
    customInfoWindowBuilderParam: () => void;
    private onInfoWindowShow;
    private onInfoWindowUpdate;
    private onInWindowHide;
    private onInfoWindowAdapterChange;
    private isInfoWindowShow;
    initMap(): void;
    aboutToAppear(): void;
    aboutToDisappear(): void;
    onKeyboardHeightChange(): void;
    private updateZoomControllerPosition;
    @Builder
    buildCustomComponent(): void;
    build(): void;
}
