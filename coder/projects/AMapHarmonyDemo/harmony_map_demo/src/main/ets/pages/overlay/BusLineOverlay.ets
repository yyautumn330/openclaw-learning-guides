import {
  AMap,
  BitmapDescriptor,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  LatLngBounds,
  Marker,
  MarkerOptions,
  PolylineOptions
} from "@amap/amap_lbs_map3d";
import { BusLineItem, BusStationItem, LatLonPoint } from "@amap/amap_lbs_search";
import { Polyline } from "@amap/amap_lbs_map3d";
import { ArrayList } from "@kit.ArkTS";
import { AMapServicesUtil } from "../utils/AMapServicesUtil";
import { ColorUtil } from "../utils/ColorUtil";

/**
 * 公交线路图层类。在高德地图API里，如果要显示公交线路，可以用此类来创建公交线路图层。如不满足需求，也可以自己创建自定义的公交线路图层。
 *
 * @since V2.1.0
 */
export class BusLineOverlay {
  private mBusLineItem: BusLineItem;
  private mAMap: AMap;
  private mBusStationMarks = new ArrayList<Marker>();
  private mBusLinePolyline?: Polyline;
  private mBusStations = new ArrayList<BusStationItem>();
  private startBit?: BitmapDescriptor | undefined
  private endBit?: BitmapDescriptor | undefined
  private busBit?: BitmapDescriptor | undefined;
  private mContext: Context;

  /**
   * 通过此构造函数创建公交线路图层。
   *
   * @param context     当前activity。
   * @param amap        地图对象。
   * @param busLineItem 公交线路。详见搜索服务模块的公交线路和公交站点包（com.amap.api.services.busline）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/busline/BusStationItem.html" title="com.amap.api.services.busline中的类">BusStationItem</a></strong>。
   * @since V2.1.0
   */
  constructor(context: Context, amap: AMap, busLineItem: BusLineItem) {
    this.mContext = context;
    this.mBusLineItem = busLineItem;
    this.mAMap = amap;
    this.mBusStations = this.mBusLineItem.getBusStations();
  }

  /**
   * 添加公交线路到地图中。
   *
   * @since V2.1.0
   */
  public addToMap() {
    try {
      let pointList = this.mBusLineItem.getDirectionsCoordinates();
      let listPolyline = AMapServicesUtil.convertArrList(pointList);
      // this.mBusLinePolyline = this.mAMap.addPolyline(new PolylineOptions()
      //   .addAll(listPolyline)
      //   .setColor(this.getBusColor())
      //   .setWidth(this.getBuslineWidth())) as Polyline;
      let tmpLine = new PolylineOptions()
      tmpLine.addAll(listPolyline)
      tmpLine.setColor(this.getBusColor())
      tmpLine.setWidth(this.getBuslineWidth())
      this.mAMap.addPolyline(tmpLine)

      // this.mBusLinePolyline = this.mAMap.addPolyline(new PolylineOptions()
      //   .addAll(listPolyline)
      //   .setColor(this.getBusColor())
      //   .setWidth(this.getBuslineWidth())) as Polyline;
      if (this.mBusStations.length < 1) {
        return;
      }
      for (let i = 1; i < this.mBusStations.length - 1; i++) {
        let marker = this.mAMap.addMarker(this.getMarkerOptions(i));
        this.mBusStationMarks.add(marker);
      }
      let markerStart = this.mAMap.addMarker(this.getMarkerOptions(0));
      this.mBusStationMarks.add(markerStart);
      let markerEnd = this.mAMap.addMarker(this.getMarkerOptions(this.mBusStations.length - 1));
      this.mBusStationMarks.add(markerEnd);
    } catch (e) {
      console.log('BusLineOverlay', JSON.stringify(e))
    }
  }

  /**
   * 返回第index的Marker的标题。
   *
   * @param index 第几个Marker。
   * @return marker的标题。
   * @since V2.1.0
   */
  protected getTitle(index: number): string {
    return this.mBusStations[index].getBusStationName();

  }

  /**
   * 返回第index的Marker的详情。
   *
   * @param index 第几个Marker。
   * @return marker的详情。
   * @since V2.1.0
   */
  protected getSnippet(index: number) {
    return "";
  }


  protected getStartBitmapDescriptor() {
    this.startBit = BitmapDescriptorFactory.fromRawfilePathSync(this.mContext, 'amap_start.png');
    return this.startBit;
  }

  protected getEndBitmapDescriptor() {
    this.endBit = BitmapDescriptorFactory.fromRawfilePathSync(this.mContext, 'amap_end.png');
    return this.endBit;
  }

  protected getBusBitmapDescriptor() {
    this.busBit = BitmapDescriptorFactory.fromRawfilePathSync(this.mContext, 'amap_bus.png');
    return this.busBit;
  }

  private getMarkerOptions(index: number) {
    let options = new MarkerOptions()
      .setPosition(
        new LatLng(this.mBusStations[index].getLatLonPoint()?.getLatitude() ?? 0,
          this.mBusStations[index].getLatLonPoint()?.getLongitude() ?? 0))
      .setTitle(this.getTitle(index))
      .setSnippet(this.getSnippet(index));
    if (index == 0) {
      options.setIcon(this.getStartBitmapDescriptor() as BitmapDescriptor);
    } else if (index == this.mBusStations.length - 1) {
      options.setIcon(this.getEndBitmapDescriptor() as BitmapDescriptor);
    } else {
      options.setAnchor(0.5, 0.5);
      options.setIcon(this.getBusBitmapDescriptor() as BitmapDescriptor);
    }
    return options;
  }

  protected getBusColor(): number {
    return ColorUtil.colorStringToNumber("#537edc");
  }

  protected getBuslineWidth() {
    return 18;
  }

  /**
   * 去掉BusLineOverlay上所有的Marker。
   *
   * @since V2.1.0
   */
  public removeFromMap() {
    if (this.mBusLinePolyline) {
      this.mBusLinePolyline?.remove();
    }
    try {
      for (let mark of this.mBusStationMarks) {
        mark.remove();
      }
      this.destroyBit();
    } catch (e) {
      console.log('BusLineOverlay', JSON.stringify(e))
    }
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
  }

  /**
   * 移动镜头到当前的视角。
   *
   * @since V2.1.0
   */
  public zoomToSpan() {
    if (this.mAMap == null) {
      return;
    }
    try {
      let coordin = this.mBusLineItem.getDirectionsCoordinates();
      if (coordin != null && coordin.length > 0) {
        let bounds = this.getLatLngBounds(coordin);
        this.mAMap.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds as LatLngBounds, 5));
      }
    } catch (e) {
      console.log('BusLineOverlay', JSON.stringify(e))
    }
  }

  private getLatLngBounds(coordin: ArrayList<LatLonPoint>) {
    let b = LatLngBounds.builder();
    for (let i = 0; i < coordin.length; i++) {
      b.include(new LatLng(coordin[i].getLatitude(), coordin[i].getLongitude()));
    }
    return b.build();
  }

  /**
   * 从marker中得到公交站点在list的位置。
   *
   * @param marker 一个标记的对象。
   * @return 返回该marker对应的公交站点在list的位置。
   * @since V2.1.0
   */
  public getBusStationIndex(marker: Marker) {
    for (let i = 0; i < this.mBusStationMarks.length; i++) {
      if (this.mBusStationMarks[i] == marker) {
        return i;
      }
    }
    return -1;
  }

  /**
   * 返回第index的公交站点的信息。
   *
   * @param index 第几个公交站点。
   * @return 公交站点的信息。详见搜索服务模块的公交线路和公交站点包（com.amap.api.services.busline）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/busline/BusStationItem.html" title="com.amap.api.services.busline中的类">BusStationItem</a></strong>。
   * @since V2.1.0
   */
  public getBusStationItem(index: number) {
    if (index < 0 || index >= this.mBusStations.length) {
      return null;
    }
    return this.mBusStations[index];
  }
}
