import { AMap, BitmapDescriptor, BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  LatLngBounds,
  Marker, MarkerOptions, Polyline, PolylineOptions } from '@amap/amap_lbs_map3d';
import { ColorUtil } from '../utils/ColorUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import { ArrayList } from '@kit.ArkTS';

export class RouteOverlay {
  protected stationMarkers: ArrayList<Marker> = new ArrayList()
  protected allPolyLines: ArrayList<Polyline> = new ArrayList()
  protected startMarker?: Marker;
  protected endMarker?: Marker;
  protected startPoint?: LatLng;
  protected endPoint?: LatLng;
  protected mAMap?: AMap;
  protected mContext: Context;
  private startBit?: BitmapDescriptor
  private endBit?: BitmapDescriptor
  private busBit?: BitmapDescriptor
  private walkBit?: BitmapDescriptor
  private driveBit?: BitmapDescriptor;
  protected nodeIconVisible: boolean = true;

  public constructor(context: Context) {
    this.mContext = context;
  }

  /**
   * 去掉BusRouteOverlay上所有的Marker。
   * @since V2.1.0
   */
  public removeFromMap() {
    if (this.startMarker) {
      this.startMarker.remove();
    }
    if (this.endMarker) {
      this.endMarker.remove();
    }
    for (let marker of this.stationMarkers) {
      marker.remove();
    }
    for (let line of this.allPolyLines) {
      line.remove();
    }
    this.destroyBit();
  }

  private destroyBit() {
    if (this.startBit) {
      this.startBit.recycle();
      this.startBit = undefined;
    }
    if (this.endBit) {
      this.endBit.recycle();
      this.endBit = undefined;
    }
    if (this.busBit) {
      this.busBit.recycle();
      this.busBit = undefined;
    }
    if (this.walkBit) {
      this.walkBit.recycle();
      this.walkBit = undefined;
    }
    if (this.driveBit) {
      this.driveBit.recycle();
      this.driveBit = undefined;
    }
  }
  /**
   * 给起点Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
   * @return 更换的Marker图片。
   * @since V2.1.0
   */
  protected getStartBitmapDescriptor() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_start.png");
  }
  /**
   * 给终点Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
   * @return 更换的Marker图片。
   * @since V2.1.0
   */
  protected getEndBitmapDescriptor() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_end.png");
  }
  /**
   * 给公交Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
   * @return 更换的Marker图片。
   * @since V2.1.0
   */
  protected getBusBitmapDescriptor() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_bus.png");
  }
  /**
   * 给步行Marker设置图标，并返回更换图标的图片。如不用默认图片，需要重写此方法。
   * @return 更换的Marker图片。
   * @since V2.1.0
   */
  protected getWalkBitmapDescriptor() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_man.png");
  }

  protected getRideBitmapDescriptor() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_ride.png");
  }

  protected getDriveBitmapDescriptor() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,"amap_car.png");
  }

  protected addStartAndEndMarker() {
    this.startMarker = this.mAMap?.addMarker(new MarkerOptions()
      .setPosition(this.startPoint as LatLng).setIcon(this.getStartBitmapDescriptor() as BitmapDescriptor)
      .setTitle("\u8D77\u70B9"));
    // startMarker.showInfoWindow();

    this.endMarker = this.mAMap?.addMarker((new MarkerOptions()).setPosition(this.endPoint as LatLng)
      .setIcon(this.getEndBitmapDescriptor() as BitmapDescriptor).setTitle("\u7EC8\u70B9"));
    // mAMap.moveCamera(CameraUpdateFactory.newLatLngZoom(startPoint,
    // getShowRouteZoom()));
  }
  /**
   * 移动镜头到当前的视角。
   * @since V2.1.0
   */
  public zoomToSpan() {
    if (this.startPoint) {
      if (!this.mAMap) {
        return;
      }
      try {
        let bounds: LatLngBounds = this.getLatLngBounds()  as LatLngBounds;
        this.mAMap.animateCamera(CameraUpdateFactory
          .newLatLngBounds(bounds, vp2px(100)));
      } catch (e) {
        console.info((e as BusinessError).message);
      }
    }
  }

  protected getLatLngBounds(): LatLngBounds | undefined{
    let b = LatLngBounds.builder();
    b.include(new LatLng(this.startPoint?.latitude ?? 0, this.startPoint?.longitude ?? 0));
    b.include(new LatLng(this.endPoint?.latitude ?? 0, this.endPoint?.longitude ?? 0));
    return b.build();
  }
  /**
   * 路段节点图标控制显示接口。
   * @param visible true为显示节点图标，false为不显示。
   * @since V2.3.1
   */
  public setNodeIconVisibility(visible: boolean) {
    try {
      this.nodeIconVisible = visible;
      if (this.stationMarkers && this.stationMarkers.length > 0) {
        for(let stationMarker of this.stationMarkers){
          stationMarker.setVisible(visible)
        }
      }
    } catch (e) {
      console.info((e as BusinessError).message);
    }
  }

  protected addStationMarker(options: MarkerOptions | undefined) {
    if(!options) {
      return;
    }
    let marker = this.mAMap?.addMarker(options);
    if(marker) {
      this.stationMarkers.add(marker);
    }

  }

  protected addPolyLine(options: PolylineOptions | undefined) {
    if(!options) {
      return;
    }
    let polyline = this.mAMap?.addPolyline(options);
    if(polyline) {
      this.allPolyLines.add(polyline);
    }
  }

  protected getRouteWidth() {
    return 18;
  }

  protected getWalkColor(): number {
    return ColorUtil.colorStringToNumber("#6db74d")
  }

  /**
   * 自定义路线颜色。
   * return 自定义路线颜色。
   * @since V2.2.1
   */
  protected getBusColor(): number {
    return ColorUtil.colorStringToNumber("#537edc")
  }

  protected getDriveColor(): number {
    return ColorUtil.colorStringToNumber("#537edc")
  }

  // protected int getShowRouteZoom() {
  // return 15;
  // }
}
