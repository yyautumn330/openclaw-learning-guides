import {
  AMap,
  BasePointOverlay,
  BitmapDescriptorFactory,
  CameraPosition,
  InfoWindowListener,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  MarkerOptions,
  OnCameraChangeListener,
  Poi,
  VirtualEarthProjection
} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { promptAction } from "@kit.ArkUI";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import { fileIo, fileUri } from "@kit.CoreFileKit";
import { common } from "@kit.AbilityKit";
import { image } from '@kit.ImageKit';
import { fileIo as fs } from '@kit.CoreFileKit';

@Component
export struct ScreenshotController {
  private mapView?: MapView;
  private aMap?: AMap;
  private aId: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  @State customInfoWindowTitle: string = ""
  @State customInfoWindowSnippet: string = ""
  @State image: PixelMap | undefined = undefined

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
  customInfoWindowBuilder() {
    // 自定义组件marker
    Column() {
      Text(this.customInfoWindowTitle)
        .fontColor(Color.Black)
      Text(this.customInfoWindowSnippet)
        .fontColor(Color.Black)
    }
    .backgroundColor(Color.Red)
  }

  //显示地图
  @Builder
  buildMapShow() {
    Stack() {
      MapViewComponent({
        mapViewName: Constants.MAP_SCREENSHOT_FUNC, customInfoWindowBuilderParam: () => {
          this.customInfoWindowBuilder()
        }
      }).zIndex(0)
      Column() {
        Flex({ wrap: FlexWrap.Wrap }) {
          Button("开始截屏")
            .onClick(() => {
              //申请存储 图片权限
              this.aMap?.getMapScreenShot({
                onMapScreenShot: (mapScreenShot: PixelMap | undefined, status: number) => {

                  this.image = mapScreenShot;
                  let buffer: string = "";
                  if (mapScreenShot) {
                    buffer += "截屏成功";
                  } else {
                    buffer += "截屏失败, 请等待地图加载完成";
                  }
                  // if (status != 0) {
                  //   buffer += "地图渲染完成，截屏无网格";
                  // } else {
                  //   buffer += "地图未渲染完成，截屏有网格";
                  // }

                  promptAction.showToast({ message: `${buffer}` });

                }
              });
            })
          Button("关闭").onClick(() => {
            this.image = undefined
          })
          Button("存储图片").onClick(() => {
            if (this.image) {
              this.savePhoto(this.image)
            }
          })
          Button("infoWindow显示").onClick(async () => {

            this.aMap?.addInfoWindowListener(new InfoWindowListener(
              //show
              (marker: BasePointOverlay) => {
                this.customInfoWindowTitle = marker.getTitle();
                this.customInfoWindowSnippet = marker.getSnippet();
              },
              //hide
              (marker: BasePointOverlay) => {
              }
            ));

            // add Marker
            let options1: MarkerOptions = new MarkerOptions();
            let bitmapDes =
              await BitmapDescriptorFactory.fromRawfilePath(getContext(), "common/marker_default.png");
            if (bitmapDes) {
              options1.setIcon(bitmapDes);
            }
            options1.setPosition(new LatLng(39.992520, 116.336170));

            let marker1 = this.aMap?.addMarker(options1);

            if (marker1) {
              marker1.setTitle("标题");
              marker1.setSnippet("11111111111");

              marker1.showInfoWindow();
            }

          })
        }.width('80%')


        Image(this.image)
          .width(400)
          .height(600)
          .padding(20)
          .backgroundColor(Color.Black)
          .objectFit(ImageFit.Contain)
          .visibility(this.image ? Visibility.Visible : Visibility.None)
      }.position({ top: 10, left: 10 })
      .backgroundColor("#ccbebebe")

    }.width('100%')
    .height('100%')
    .backgroundColor(Color.Transparent)
  }

  async savePhoto(pixelMap: PixelMap) {
    try {

      let context: Context = this.getUIContext().getHostContext() as common.UIAbilityContext;
      let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);
      // 指定待保存到媒体库的位于应用沙箱的图片uri。
      let filePath = await this.saveIntoSandBox(pixelMap)
      let srcFileUri = fileUri.getUriFromPath(filePath)
      console.info("--------srcFileUri:" + srcFileUri)

      let srcFileUris: Array<string> = [
        srcFileUri
      ];
      // 指定待保存照片的创建选项，包括文件后缀和照片类型，标题和照片子类型可选。
      let photoCreationConfigs: Array<photoAccessHelper.PhotoCreationConfig> = [
        {
          title: 'imag_test', // 可选。
          fileNameExtension: 'jpg',
          photoType: photoAccessHelper.PhotoType.IMAGE,
          subtype: photoAccessHelper.PhotoSubtype.DEFAULT, // 可选。
        }
      ];
      // 基于弹窗授权的方式获取媒体库的目标uri。
      let desFileUris: Array<string> = await phAccessHelper.showAssetsCreationDialog(srcFileUris, photoCreationConfigs);
      // 将来源于应用沙箱的照片内容写入媒体库的目标uri
      let desFile: fileIo.File = await fileIo.open(desFileUris[0], fileIo.OpenMode.WRITE_ONLY);
      let srcFile: fileIo.File = await fileIo.open(srcFileUri, fileIo.OpenMode.READ_ONLY);
      await fileIo.copyFile(srcFile.fd, desFile.fd);
      fileIo.closeSync(srcFile);
      fileIo.closeSync(desFile);
    } catch (err) {
      console.info("savePhoto err:" + err)
    }
  }

  //保存到沙箱中
  async saveIntoSandBox(pixelMap: PixelMap): Promise<string> {
    //保存 图片 到沙箱中  路径为：/data/storage/el2/base/haps/harmony_map_demo/cache/imag_test.png
    const filePath = `${getContext().cacheDir}/${"imag_test.jpg"}`;
    const packer = image.createImagePacker();

    const opts: image.PackingOption = { format: 'image/jpeg', quality: 100 };
    let file = fs.openSync(filePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);

    // 直接编码进文件
    await packer.packToFile(pixelMap, file.fd, opts);

    packer.release?.();
    fs.closeSync(file.fd)
    return filePath;
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_SCREENSHOT_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC, `map click ${point.longitude} ${point.latitude}`);
      });

      this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
        (position: CameraPosition) => {
          hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC,
            `map change ${position.target.longitude} ${position.target.latitude}`);

          let viewMatrix = map.getViewMatrix()
          let projectionMatrix = map.getProjectionMatrix()
          hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC, `map viewMatrix ${viewMatrix}`);
          hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC, `map projectionMatrix ${projectionMatrix}`);

          let pos = VirtualEarthProjection.latLongToPixels(position.target.latitude, position.target.longitude, 20)
          hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC,
            `map latLongToPixels ${pos}`);
        },
        (position: CameraPosition) => {
          hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC,
            `map finish ${position.target.longitude} ${position.target.latitude}`);
        }));

      this.aMap?.setOnMapTouchListener((event: TouchEvent) => {
        hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC, `map touch ${event.touches[0].x} ${event.touches[0].y}`);
      });

      this.aMap?.setOnMapLongClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC, `map long click ${point.longitude} ${point.latitude}`);
      });

      this.aMap?.addOnPOIClickListener((poi: Poi) => {
        hilog.info(0xff, Constants.MAP_SCREENSHOT_FUNC,
          `map poi click ${poi.getName()}  ${poi.getPoiId()}  ${poi.getCoordinate()!
            .longitude} ${poi.getCoordinate()!.latitude}`);
      });
      //设置 marker
      this.setMapMarker();
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }

  aboutToAppear(): void {

    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
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
  }

  /**
   * 对地图添加一个marker
   */
  setMapMarker() {
    this.aMap?.addMarker(new MarkerOptions()
      .setPosition(new LatLng(39.989614, 116.481763))
      .setTitle("方恒")
      .setSnippet("方恒国际中心大楼A座")
    )
    this.aMap?.addInfoWindowListener(new InfoWindowListener(
      //show
      (marker: BasePointOverlay) => {
        this.customInfoWindowTitle = marker.getTitle();
        this.customInfoWindowSnippet = marker.getSnippet();
      },
      //hide
      (marker: BasePointOverlay) => {
      }
    ));
  }

  build() {
    NavDestination() {
      this.buildMapShow();
    }
    .title(Constants.MAP_SCREENSHOT_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}