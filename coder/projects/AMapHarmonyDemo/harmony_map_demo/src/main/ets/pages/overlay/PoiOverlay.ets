import { AMap, CameraUpdateFactory, LatLng, LatLngBounds, LatLngBoundsBuilder, Marker,
  MarkerOptions } from "@amap/amap_lbs_map3d";
import { PoiItem } from "@amap/amap_lbs_search";
import { ArrayList } from "@kit.ArkTS";

/**
 * Poi图层类。在高德地图API里，如果要显示Poi，可以用此类来创建Poi图层。如不满足需求，也可以自己创建自定义的Poi图层。
 * @since V2.1.0
 */
export class PoiOverlay {
  private mPois: ArrayList<PoiItem> = new ArrayList<PoiItem>();
  private mAMap: AMap | null = null;
  private mPoiMarks = new ArrayList<Marker>();
  /**
   * 通过此构造函数创建Poi图层。
   * @param amap 地图对象。
   * @param pois 要在地图上添加的poi。列表中的poi对象详见搜索服务模块的基础核心包（com.amap.api.services.core）中的类<strong> <a href="../../../../../../Search/com/amap/api/services/core/PoiItem.html" title="com.amap.api.services.core中的类">PoiItem</a></strong>。
   * @since V2.1.0
   */
  constructor(amap: AMap, pois: ArrayList<PoiItem>) {
    this.mAMap = amap;
    this.mPois = pois;
  }

  /**
   * 添加Marker到地图中。
   * @since V2.1.0
   */
  public addToMap() {
    try{
      for (let i = 0; i < this.mPois.length; i++) {
        const marker = this.mAMap!.addMarker(this.getMarkerOptions(i));
        marker?.setObject(this.mPois[i]);
        this.mPoiMarks.add(marker);
      }
    }catch(e){
      e.printStackTrace();
    }
  }
  /**
   * 去掉PoiOverlay上所有的Marker。
   * @since V2.1.0
   */
  public removeFromMap(): void {
    this.mPoiMarks.forEach((mark: Marker) => {
      mark.remove();
    })
  }
  /**
   * 移动镜头到当前的视角。
   * @since V2.1.0
   */
  public zoomToSpan(): void {
    try{
      if (this.mPois !== null && this.mPois.length > 0) {
        if (this.mAMap === null)
          return;

        if(this.mPois.length === 1){
          this.mAMap!.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(this.mPois[0].getLatLonPoint()?.getLatitude() ?? 0,
            this.mPois[0].getLatLonPoint()?.getLongitude() ?? 0), 18));
        }else{
          const bounds = this.getLatLngBounds();
          if(bounds !== undefined){
            this.mAMap.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds, 5));
          }
        }
      }
    }catch(e){
      e.printStackTrace();
    }
  }

  private getLatLngBounds(): LatLngBounds | undefined{

    const b = new LatLngBoundsBuilder();
    for (let i = 0; i < this.mPois.length; i++) {
      b.include(new LatLng(this.mPois[i].getLatLonPoint()?.getLatitude() ?? 0,
        this.mPois[i].getLatLonPoint()?.getLongitude() ?? 0));
    }
    return b.build();
  }

  private getMarkerOptions(index: number): MarkerOptions {
    return new MarkerOptions()
      .setPosition(
        new LatLng(this.mPois[index].getLatLonPoint()?.getLatitude() ?? 0, this.mPois[index].getLatLonPoint()?.getLongitude() ?? 0))
      .setTitle(this.getTitle(index))
      .setSnippet(this.getSnippet(index))
      // .setIcon(this.getBitmapDescriptor(index))
    ;
  }
  /**
   * 返回第index的Marker的标题。
   * @param index 第几个Marker。
   * @return marker的标题。
   * @since V2.1.0
   */
  protected getTitle(index: number): string {
    return this.mPois[index].getTitle() ?? "";
  }
  /**
   * 返回第index的Marker的详情。
   * @param index 第几个Marker。
   * @return marker的详情。
   * @since V2.1.0
   */
  protected getSnippet(index: number): string {
    return this.mPois[index].getSnippet() ?? "";
  }
  /**
   * 从marker中得到poi在list的位置。
   * @param marker 一个标记的对象。
   * @return 返回该marker对应的poi在list的位置。
   * @since V2.1.0
   */
  public getPoiIndex(marker: Marker): number {
    for (let i = 0; i < this.mPoiMarks.length; i++) {
      if (this.mPoiMarks[i].getId() === marker.getId()) {
        return i;
      }
    }
    return -1;
  }
  /**
   * 返回第index的poi的信息。
   * @param index 第几个poi。
   * @return poi的信息。poi对象详见搜索服务模块的基础核心包（com.amap.api.services.core）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/core/PoiItem.html" title="com.amap.api.services.core中的类">PoiItem</a></strong>。
   * @since V2.1.0
   */
  public getPoiItem(index: number): PoiItem | null {
    if (index < 0 || index >= this.mPois.length) {
      return null;
    }
    return this.mPois[index];
  }
}
