import { RouteOverlay } from "./RouteOverlay";
import { DrivePathV2 } from "@amap/amap_lbs_search"
import { LatLonPoint } from "@amap/amap_lbs_search";
import {
  AMap,
  BitmapDescriptor,
  BitmapDescriptorFactory,
  LatLng,
  LatLngBounds,
  Marker,
  MarkerOptions,
  PolylineOptions
} from "@amap/amap_lbs_map3d";
import { TMC } from "@amap/amap_lbs_search";
import { AMapUtil } from "../utils/AMapUtil";
import { DriveStepV2 } from "@amap/amap_lbs_search";
import { ColorUtil } from "../utils/ColorUtil";
import { BusinessError } from "@kit.BasicServicesKit";
import { ArrayList } from "@kit.ArkTS";

/**
 * 导航路线图层类。
 */
export class DrivingRouteOverlayV2 extends RouteOverlay {
  private drivePath: DrivePathV2;
  private throughPointList: ArrayList<LatLonPoint> = new ArrayList();
  private throughPointMarkerList: ArrayList<Marker> = new ArrayList()
  private throughPointMarkerVisible = true;
  private tmcs: ArrayList<TMC> = new ArrayList()
  private mPolylineOptions?: PolylineOptions;
  private mPolylineOptionscolor?: PolylineOptions;
  private isColorfulline = true;
  private mWidth = 25;
  private mLatLngsOfPath?: ArrayList<LatLng>;

  public setIsColorfulline(iscolorfulline: boolean) {
    this.isColorfulline = iscolorfulline;
  }

  /**
   * 根据给定的参数，构造一个导航路线图层类对象。
   *
   * @param amap      地图对象。
   * @param path 导航路线规划方案。
   * @param context   当前的activity对象。
   */
  public constructor(context: Context, amap: AMap | undefined, path: DrivePathV2,
    start: LatLonPoint | undefined, end: LatLonPoint | undefined, throughPointList: ArrayList<LatLonPoint>) {
    super(context);
    this.mContext = context;
    this.mAMap = amap;
    this.drivePath = path;
    if (start) {
      this.startPoint = AMapUtil.convertToLatLng(start);
    }
    if (end) {
      this.endPoint = AMapUtil.convertToLatLng(end);
    }
    this.throughPointList = throughPointList;
  }

  public getRouteWidth() {
    return this.mWidth;
  }

  /**
   * 设置路线宽度
   *
   * @param mWidth 路线宽度，取值范围：大于0
   */
  public setRouteWidth(mWidth: number) {
    this.mWidth = mWidth;
  }

  /**
   * 分片传递
   * @param steps
   * @param batchSteps
   * @param batchPoints
   */
  processStepsInBatches(steps: ArrayList<DriveStepV2>, batchSteps = 10, batchPoints = 300) {
    const convert = AMapUtil.convertToLatLng;
    let sIndex = 0;
    const stepLen = steps.length;
    const processChunk = () => {
      let stepCount = 0;
      while (sIndex < stepLen && stepCount < batchSteps) {
        const step = steps[sIndex++];
        // tmc
        const tmcList = step.getTMCs();
        for (let j = 0; j < tmcList.length; j++) {
          this.tmcs.add(tmcList[j]);
        }
        // points 分内循环以控制单批点数
        const points = step.getPolyline();
        if (points && points.length> 0) {
          this.addDrivingStationMarkers(step, this.convertToLatLng(points[0]))
          for (let k = 0; k < points.length; k++) {
            const latlng = convert(points[k]);
            this.mPolylineOptions?.add(latlng)
            this.mLatLngsOfPath?.add(latlng)
            if (--batchPoints <= 0) {
              break;
            }
          }

        }
        stepCount++;
        if (batchPoints <= 0) {
          break;
        }
      }

      if (sIndex < stepLen) {
        // 让出主线程再继续 未处理完，下一帧继续
        setTimeout(processChunk, 0);
      } else {
        // // 完成后的回调（可选）
        if (this.startMarker) {
          this.startMarker.remove();
          this.startMarker = undefined;
        }
        if (this.endMarker) {
          this.endMarker.remove();
          this.endMarker = undefined;
        }
        this.addStartAndEndMarker();
        this.addThroughPointMarker();
        if (this.isColorfulline && this.tmcs.length > 0) {
          this.colorWayUpdateChunked(this.tmcs,50)
        } else {
          this.showPolyline();
        }
      }
    };
    processChunk();
  }

  /**
   * 添加驾车路线添加到地图上显示。
   */
  public addToMap() {
    this.initPolylineOptions();
    try {
      if (!this.mAMap) {
        return;
      }

      if (this.mWidth == 0 || !this.drivePath) {
        return;
      }
      this.mLatLngsOfPath = new ArrayList();
      this.tmcs = new ArrayList();
      let drivePaths = this.drivePath.getSteps();
      this.processStepsInBatches(drivePaths,5)

    } catch (e) {
      console.info((e as BusinessError).message);
    }
  }

  /**
   * 初始化线段属性
   */
  private initPolylineOptions() {

    this.mPolylineOptions = undefined;

    this.mPolylineOptions = new PolylineOptions();
    this.mPolylineOptions
      .setColor(this.getDriveColor())
      .setCustomTexture(BitmapDescriptorFactory.fromRawfilePathSync(this.mContext,
        "custtexture.png") as BitmapDescriptor)
      .setWidth(this.getRouteWidth());
  }

  private showPolyline() {
    this.addPolyLine(this.mPolylineOptions);
  }

  private showcolorPolyline() {
    this.addPolyLine(this.mPolylineOptionscolor);
  }


  /**
   * 根据不同的路段拥堵情况展示不同的颜色
   *
   * @param tmcSection
   */
  private _colorSeq = 0;
  public colorWayUpdateChunked(tmcSection: ArrayList<TMC>, batchPoints: number = 3000, onDone?: () => void) {
    if (!this.mAMap || !tmcSection || tmcSection.length === 0) return;
    const mySeq = ++this._colorSeq;
    const points: ArrayList<LatLng> = new ArrayList()
    const colors: number[] = [];
    // 头尾默认行驶色，保持与原逻辑一致
    const firstLatlon = tmcSection[0]?.getPolyline()?.[0];
    if (firstLatlon) {
      points.add(AMapUtil.convertToLatLng(firstLatlon));
      colors.push(this.getDriveColor());
    }
    let segIdx = 0;
    let processedInBatch = 0;
    const processChunk = () => {
      if (this._colorSeq !== mySeq) return; // 防抖：有新任务则取消旧任务
      processedInBatch = 0;

      while (segIdx < tmcSection.length && processedInBatch < batchPoints) {
        const seg = tmcSection[segIdx++];
        // 针对 null/未知状态做兜底，避免异常
        const segStatus = seg?.getStatus?.();
        const segColor = this.getcolor(segStatus) ?? this.getDriveColor();

        const poly = seg?.getPolyline() || [];
        for (const raw of poly) {
          points.add(AMapUtil.convertToLatLng(raw));
          colors.push(segColor);
        }
        processedInBatch += poly.length;
      }

      if (segIdx < tmcSection.length) {
        // 让出主线程，下一帧继续
        setTimeout(processChunk, 0);
        return;
      }

      // 全部完成，最终一次性应用
      if (this._colorSeq !== mySeq) return;

      colors.push(this.getDriveColor()); // 尾色
      const colorArr = new Int32Array(colors);

      this.mPolylineOptionscolor = new PolylineOptions();
      this.mPolylineOptionscolor.setWidth(this.getRouteWidth());

      // 一次性设置点，避免多次 add
      if (this.mPolylineOptionscolor.setPoints) {
        this.mPolylineOptionscolor.setPoints(points);
      } else if (this.mPolylineOptionscolor.addAll) {
        this.mPolylineOptionscolor.addAll(points);
      } else {
        for (const p of points) this.mPolylineOptionscolor.add(p);
      }

      this.mPolylineOptionscolor.setColorValues(colorArr);
      this.showcolorPolyline()

      onDone && onDone(); // 通知调用方可以 showcolorPolyline 了
    };
    processChunk();
  }

  private getcolor(status: string | undefined): number {

    if (status === "畅通") {
      return ColorUtil.colorStringToNumber("#00ff00")
    } else if (status === "缓行") {
      return ColorUtil.colorStringToNumber("#ffff00")
    } else if (status === "拥堵") {
      return ColorUtil.colorStringToNumber("#ff0000")
    } else if (status === "严重拥堵") {
      return ColorUtil.colorStringToNumber("#990033");
    } else {
      return ColorUtil.colorStringToNumber("#537edc");
    }
  }

  public convertToLatLng(point: LatLonPoint) {
    return new LatLng(point.getLatitude(), point.getLongitude());
  }

  /**
   * @param driveStep
   * @param latLng
   */
  private addDrivingStationMarkers(driveStep: DriveStepV2, latLng: LatLng) {
    this.addStationMarker(new MarkerOptions()
      .setPosition(latLng)
      .setTitle("\u65B9\u5411:" + driveStep.getNavi()?.getAction()
        + "\n\u9053\u8DEF:" + driveStep.getRoad())
      .setSnippet(driveStep.getInstruction() ?? "")
      .setVisible(this.nodeIconVisible)
      .setAnchor(0.5, 0.5)
      .setIcon(this.getDriveBitmapDescriptor() as BitmapDescriptor));
  }

  protected getLatLngBounds() {
    const builder = LatLngBounds.builder();

    // 1. 添加起点
    if (this.startPoint) {
      builder.include(this.startPoint);
    }

    // 2. 添加终点
    if (this.endPoint) {
      builder.include(this.endPoint);
    }

    // 3. 添加所有途经点
    if (this.throughPointList && this.throughPointList.length > 0) {
      for (const point of this.throughPointList) {
        console.info("途径点为2："+point)
        if (point) {
          console.info("途径点为："+point)
          builder.include(new LatLng(point.getLatitude(), point.getLongitude()));
        }
      }
    }

    // 4. 加 drivePath 中的所有路径点
    const steps = this.drivePath?.getSteps?.();
    if (steps) {
      for (const step of steps) {
        const points = step.getPolyline(); // LatLonPoint[]
        if (points) {
          for (const point of points) {
            builder.include(new LatLng(point.getLatitude(), point.getLongitude()));
          }
        }
      }
    }

    return builder.build();
  }

  public setThroughPointIconVisibility(visible: boolean) {
    try {
      this.throughPointMarkerVisible = visible;
      if (this.throughPointMarkerList
        && this.throughPointMarkerList.length > 0) {
        for (let throughPointMarker of this.throughPointMarkerList) {
          throughPointMarker.setVisible(visible)
        }
      }
    } catch (e) {
      console.info((e as BusinessError).message);
    }
  }

  private addThroughPointMarker() {
    if (this.throughPointList && this.throughPointList.length > 0) {
      for (let latLonPoint of this.throughPointList) {
        if (latLonPoint) {
          this.throughPointMarkerList.add(this.mAMap?.addMarker((new MarkerOptions())
            .setPosition(
              new LatLng(latLonPoint
                .getLatitude(), latLonPoint
                .getLongitude()))
            .setVisible(this.throughPointMarkerVisible)
            .setIcon(this.getThroughPointBitDes() as BitmapDescriptor)
            .setTitle("\u9014\u7ECF\u70B9")) as Marker)
        }
      }
    }
  }

  private getThroughPointBitDes(): BitmapDescriptor | undefined {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext, "amap_through.png");

  }

  /**
   * 获取两点间距离
   *
   * @param start
   * @param end
   * @return
   */
  public static calculateDistance(start: LatLng, end: LatLng): number {
    let x1 = start.longitude;
    let y1 = start.latitude;
    let x2 = end.longitude;
    let y2 = end.latitude;
    return DrivingRouteOverlayV2.calculateDistanceWithNumber(x1, y1, x2, y2);
  }

  public static calculateDistanceWithNumber(x1: number, y1: number, x2: number, y2: number) {
    const NF_pi = 0.01745329251994329; // 弧度 PI/180
    x1 *= NF_pi;
    y1 *= NF_pi;
    x2 *= NF_pi;
    y2 *= NF_pi;
    let sinx1 = Math.sin(x1);
    let siny1 = Math.sin(y1);
    let cosx1 = Math.cos(x1);
    let cosy1 = Math.cos(y1);
    let sinx2 = Math.sin(x2);
    let siny2 = Math.sin(y2);
    let cosx2 = Math.cos(x2);
    let cosy2 = Math.cos(y2);
    let v1: number[] = [];
    v1[0] = cosy1 * cosx1 - cosy2 * cosx2;
    v1[1] = cosy1 * sinx1 - cosy2 * sinx2;
    v1[2] = siny1 - siny2;
    let dist = Math.sqrt(v1[0] * v1[0] + v1[1] * v1[1] + v1[2] * v1[2]);

    return Math.floor(Math.asin(dist / 2) * 12742001.5798544);
  }


  //获取指定两点之间固定距离点
  public static getPointForDis(sPt: LatLng, ePt: LatLng, dis: number) {
    let lSegLength = DrivingRouteOverlayV2.calculateDistance(sPt, ePt);
    let preResult = dis / lSegLength;
    return new LatLng((ePt.latitude - sPt.latitude) * preResult + sPt.latitude,
      (ePt.longitude - sPt.longitude) * preResult + sPt.longitude);
  }

  /**
   * 去掉DriveLineOverlay上的线段和标记。
   */
  public removeFromMap() {
    try {
      super.removeFromMap();
      if (this.throughPointMarkerList
        && this.throughPointMarkerList.length > 0) {
        for (let throughPointMarker of this.throughPointMarkerList) {
          throughPointMarker.remove()
        }
        this.throughPointMarkerList = new ArrayList();
      }
    } catch (e) {
      console.info((e as BusinessError).message);
    }
  }
}