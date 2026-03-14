import {
  AMap,
  BitmapDescriptor,
  BitmapDescriptorFactory,
  CameraPosition,
  CameraUpdateFactory,
  CustomMapStyleOptions,
  LatLng,
  LatLngBounds,
  LatLngBoundsBuilder,
  MapType,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  Marker,
  MarkerOptions,
  MoveListener,
  MovingPointOverlay,
  OnCameraChangeListener,
  Poi,
  Polyline,
  PolylineOptions,
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { LinkedList, List,ArrayList, buffer} from "@kit.ArkTS";
import { SpatialRelationUtil } from '@amap/amap_lbs_map3d';
import { common } from '@kit.AbilityKit';
import { promptAction } from '@kit.ArkUI';
import { ToastUtil } from '../../utils/ToastUtil';
import { CustomPopupWindow } from '../../utils/CustomPopupWindow';

@Component
export struct SmoothMoveController {
  private mapView? : MapView;
  private aId : number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  private  mAMap?:AMap;
  private  mPolyline:Polyline|undefined;

  private  smoothMarker:MovingPointOverlay|undefined;
  private  marker:Marker|undefined;

  infoWindowLayout?:Object
  @State title:string = "剩余距离展示"
  private context:Context = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private onMove = (distance: number): void => {
    try {
      this.title = "距离终点还有： " + Math.ceil(distance) + "米";
      this.marker?.showInfoWindow();
    } catch (e) {
      console.error(e);
    }
  }
  private fitMapToBounds(bounds: LatLngBounds): void {
    if (!this.mAMap) return;

    // 假设屏幕有足够高度，设置合理 padding
    const PADDING_LEFT = 150;
    const PADDING_RIGHT = 150;
    const PADDING_TOP = 300;
    const PADDING_BOTTOM = 300;

    const result = this.mAMap.calculateZoomToSpanLevel(
      PADDING_LEFT,
      PADDING_RIGHT,
      PADDING_TOP,
      PADDING_BOTTOM,
      bounds.southwest,
      bounds.northeast
    );

    if (result) {
      const zoom = result[0];
      const center = result[1];
      const update = CameraUpdateFactory.newCameraPosition(
        new CameraPosition(center, zoom, 0, 0)
      );
      this.mAMap.animateCamera(update);
    }
  }

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

  //显示地图
  @Builder
  buildMapShow() {
    Stack() {
      MapViewComponent({mapViewName: Constants.MAP_SMOOTHMOVING_FUNC }).zIndex(0)
      Row(){
        Button('设置路线')
          .onClick(()=>{
            this.addPolylineInPlayGround()
          })
        Button('开始')
          .margin({left:'12vp'})
          .onClick(()=>{
            this.startMove()
          })
        // Button('暂停')
        //   .margin({left:'12vp'})
        //   .onClick(()=>{
        //     this.stopMove()
        //   })
      }
      .position({ x: 10, y: 10 })
      .align(Alignment.TopStart)
      .alignItems(VerticalAlign.Center)
      .width('40%')
    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }
  /**
   * 自定义View并且绑定数据方法
   * @param marker 点击的Marker对象
   * @return  返回自定义窗口的视图
   */
  @Builder
  getInfoWindowView(){
    Stack(){
      // Image($rawfile("infowindow_bg.png"))
      //   .height("50vp")
      //   .width("180vp")
      //   .objectFit(ImageFit.Fill)
      //   .resizable({slice:{top:"10px",right:"10px",left:"10px",bottom:"40px"}})
      //   .margin({top:"10vp"})
      CustomPopupWindow()
        .margin({top:"15vp"})

      Text(this.title)
        .fontColor(Color.Black)
        .fontSize(15)
        .textAlign(TextAlign.Center)
    }
  }
  public stopMove(){
    this.smoothMarker?.stopMove();
  }
  /**
   * 开始移动
   */
  public startMove() {
    if (this.mPolyline == null) {
      ToastUtil.show(this.getUIContext(),"请先设置路线")
      return;
    }

    // 读取轨迹点
    let points:ArrayList<LatLng> = this.readLatLngs();
    // 构建 轨迹的显示区域
    let builder =  new LatLngBoundsBuilder()
    builder.include(points[0])
    builder.include(points[points.length-2])
    let latLngbounds = builder.build()

    if(latLngbounds)
      this.fitMapToBounds(latLngbounds);

    // 实例 MovingPointOverlay 对象
    if(this.smoothMarker == null && this.mAMap) {
      // 设置 平滑移动的 图标
      let descriptor = BitmapDescriptorFactory.fromRawfilePathSync(this.context,"icon_car.png")
      if(descriptor){
        this.marker = this.mAMap.addMarker(new MarkerOptions().setIcon(descriptor).setAnchor(0.5,0.5));
        if(this.marker)
          this.smoothMarker = new MovingPointOverlay(this.mAMap, this.marker);
      }
    }

    // 取轨迹点的第一个点 作为 平滑移动的启动
    let drivePoint:LatLng = points[0];
    let pair = SpatialRelationUtil.calShortestDistanceLatLng(points, drivePoint);
    if(pair && pair[0])
      points[pair[0]]=drivePoint;
    let subList = points.subArrayList(pair?.[0], points.length);

    // 设置轨迹点
    this.smoothMarker?.setPoints(subList);
    // 设置平滑移动的总时间  单位  秒
    this.smoothMarker?.setTotalDuration(40);

    this.title = "剩余距离展示"
    // 设置  自定义的InfoWindow 适配器
    this.mAMap?.setInfoWindowAdapter(()=>{this.getInfoWindowView()});
    // 显示 infowindow
    this.marker?.showInfoWindow();

    if(this.smoothMarker){
      let moveListener: MoveListener = {
        move: this.onMove
      }
      this.smoothMarker.setMoveListener(moveListener)
    }
    if(this.smoothMarker)
    // 开始移动
      this.smoothMarker.startSmoothMove();

  }

  private argb(a: number, r: number, g: number, b: number):string {
    return `#${a.toString(16).padStart(2, '0')}${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}`;
  }

  private addPolylineInPlayGround() {
    let list:ArrayList<LatLng> = this.readLatLngs();
    let colorList:ArrayList<string>  = new ArrayList<string>();
    let bitmapDescriptors:ArrayList<BitmapDescriptor> = new ArrayList<BitmapDescriptor>();

    let colors:string[] = [this.argb(255, 0, 255, 0),this.argb(255, 255, 255, 0),this.argb(255, 255, 0, 0)];

    //用一个数组来存放纹理
    let textureList:ArrayList<BitmapDescriptor> = new ArrayList<BitmapDescriptor>();
    let content = BitmapDescriptorFactory.fromRawfilePathSync(this.context,"custtexture.png");
    if(content)
      textureList.add(content);

    let texIndexList = new ArrayList<number>();
    texIndexList.add(0);//对应上面的第0个纹理
    texIndexList.add(1);
    texIndexList.add(2);

    for (let i = 0; i < list.length; i++) {
      let random = Math.floor(Math.random() * (3));
      colorList.add(colors[random]);
      bitmapDescriptors.add(textureList[0]);
    }

    if(this.mAMap){
      let customTexture = BitmapDescriptorFactory.fromRawfilePathSync(this.context,"custtexture.png");
      if(customTexture)
        this.mPolyline = this.mAMap.addPolyline(new PolylineOptions().setCustomTexture(customTexture) //setCustomTextureList(bitmapDescriptors)
        // .setCustomTextureIndex(texIndexList)
          .addAll(list)
          .setGradient(true)
          .setWidth(18));
    }

    let builder =  new LatLngBoundsBuilder()
    for(let item of list){
      builder.include(item)
    }
    let latLngbounds = builder.build()
    if(latLngbounds)
      this.fitMapToBounds(latLngbounds);
  }
  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_SMOOTHMOVING_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.mAMap = map;
      this.mAMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }

  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToAppear");
  }

  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.mAMap = undefined;
      hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToDisappear");
    }
    if(this.smoothMarker){
      this.smoothMarker.setMoveListener(undefined);
      this.smoothMarker.destroy();
    }
  }

  build() {
    NavDestination() {
      this.buildMapShow();
    }
    .title(Constants.MAP_SMOOTHMOVING_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
  /**
   * 读取坐标点
   * @return
   */
  readLatLngs():ArrayList<LatLng>{
    let points = new ArrayList<LatLng>();
    for (let i = 0; i < this.coords.length; i += 2) {
      points.add(new LatLng(this.coords[i+1], this.coords[i]));
    }
    return points;
  }
  /**
   * 坐标点数组数据
   */
  coords:number [] = [116.3499049793749, 39.97617053371078,
    116.34978804908442, 39.97619854213431, 116.349674596623,
    39.97623045687959, 116.34955525200917, 39.97626931100656,
    116.34943728748914, 39.976285626595036, 116.34930864705592,
    39.97628129172198, 116.34918981582413, 39.976260803938594,
    116.34906721558868, 39.97623535890678, 116.34895185151584,
    39.976214717128855, 116.34886935936889, 39.976280148755315,
    116.34873954611332, 39.97628182112874, 116.34860763527448,
    39.97626038855863, 116.3484658907622, 39.976306080391836,
    116.34834585430347, 39.976358252119745, 116.34831166130878,
    39.97645709321835, 116.34827643560175, 39.97655231226543,
    116.34824186261169, 39.976658372925556, 116.34825080406188,
    39.9767570732376, 116.34825631960626, 39.976869087779995,
    116.34822111635201, 39.97698451764595, 116.34822901510276,
    39.977079745909876, 116.34822234337618, 39.97718701787645,
    116.34821627457707, 39.97730766147824, 116.34820593515043,
    39.977417746816776, 116.34821013897107, 39.97753930933358
    ,116.34821304891533, 39.977652209132174, 116.34820923399242,
    39.977764016531076, 116.3482045955917, 39.97786190186833,
    116.34822159449203, 39.977958856930286, 116.3482256370537,
    39.97807288885813, 116.3482098441266, 39.978170063673524,
    116.34819564465377, 39.978266951404066, 116.34820541974412,
    39.978380693859116, 116.34819672351216, 39.97848741209275,
    116.34816588867105, 39.978593409607825, 116.34818489339459,
    39.97870216883567, 116.34818473446943, 39.978797222300166,
    116.34817728972234, 39.978893492422685, 116.34816491505472,
    39.978997133775266, 116.34815408537773, 39.97911413849568,
    116.34812908154862, 39.97920553614499, 116.34809495907906,
    39.979308267469264, 116.34805113358091, 39.97939658036473,
    116.3480310509613, 39.979491697188685, 116.3480082124968,
    39.979588529006875, 116.34799530586834, 39.979685789111635,
    116.34798818413954, 39.979801430587926, 116.3479996420353,
    39.97990758587515, 116.34798697544538, 39.980000796262615,
    116.3479912988137, 39.980116318796085, 116.34799204219203,
    39.98021407403913, 116.34798535084123, 39.980325006125696,
    116.34797702460183, 39.98042511477518, 116.34796288754136,
    39.98054129336908, 116.34797509821901, 39.980656820423505,
    116.34793922017285, 39.98074576792626, 116.34792586413015,
    39.98085620772756, 116.3478962642899, 39.98098214824056,
    116.34782449883967, 39.98108306010269, 116.34774758827285,
    39.98115277119176, 116.34761476652932, 39.98115430642997,
    116.34749135408349, 39.98114590845294, 116.34734772765582,
    39.98114337322547, 116.34722082902628, 39.98115066909245,
    116.34708205250223, 39.98114532232906, 116.346963237696,
    39.98112245161927, 116.34681500222743, 39.981136637759604,
    116.34669622104072, 39.981146248090866, 116.34658043260109,
    39.98112495260716, 116.34643721418927, 39.9811107163792,
    116.34631638374302, 39.981085081075676, 116.34614782996252,
    39.98108046779486, 116.3460256053666, 39.981049089345206,
    116.34588814050122, 39.98104839362087, 116.34575119741586,
    39.9810544889668, 116.34562885420186, 39.981040940565734,
    116.34549232235582, 39.98105271658809, 116.34537348820508,
    39.981052294975264, 116.3453513775533, 39.980956549928244
  ]
}

/**
 *  个性化定制的信息窗口视图的类
 *  如果要定制化渲染这个信息窗口，需要重载getInfoWindow(Marker)方法。
 *  如果只是需要替换信息窗口的内容，则需要重载getInfoContents(Marker)方法。
 */
interface  ImageInfoWindowAdapter  {
  getInfoWindowUpdateTime:() => number

  // 个性化Marker的InfoWindow 视图
  // 如果这个方法返回null，则将会使用默认的信息窗口风格，内容将会调用getInfoContents(Marker)方法获取
  getInfoWindow:(marker:Marker)=> void

  // 这个方法只有在getInfoWindow(Marker)返回null 时才会被调用
  // 定制化的view 做这个信息窗口的内容，如果返回null 将以默认内容渲染
  getInfoContents:(marker:Marker)=>void
}