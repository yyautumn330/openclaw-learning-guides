import { LatLonPoint, TMC, TruckPath, TruckStep } from "@amap/amap_lbs_search";
import { RouteOverlay } from "./RouteOverlay";
import { ArrayList } from "@kit.ArkTS";
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
import { AMapUtil } from "../utils/AMapUtil";
import { ColorUtil } from "../utils/ColorUtil";

/**
 * 导航路线图层类。
 */
export class TruckRouteColorfulOverLay extends RouteOverlay {
  private truckPath?: TruckPath
  private throughPointList: ArrayList<LatLonPoint> = new ArrayList<LatLonPoint>()
  private throughPointMarkerList: ArrayList<Marker> = new ArrayList<Marker>()
  private throughPointMarkerVisible: boolean = true
  private tmcs: ArrayList<TMC> = new ArrayList<TMC>()
  private mPolylineOptions?: PolylineOptions
  private isColorfulline: boolean = true
  private mWidth: number = 17
  private mLatLngsOfPath?: ArrayList<LatLng>
  private mPolylineOptionscolor?: PolylineOptions;

  public setIsColorfulline(iscolorfulline: boolean) {
    this.isColorfulline = iscolorfulline
  }

  /**
   * 根据给定的参数，构造一个导航路线图层类对象。
   *
   * @param amap      地图对象。
   * @param path 导航路线规划方案。
   * @param context   当前的activity对象。
   */
  public constructor(context: Context, amap: AMap | undefined, path: TruckPath, start: LatLonPoint | undefined,
    end: LatLonPoint | undefined,
    throughPointList: ArrayList<LatLonPoint> | undefined) {
    super(context)
    this.mContext = context
    this.mAMap = amap
    this.truckPath = path
    if (start) {
      this.startPoint = AMapUtil.convertToLatLng(start)
    }
    if (end) {
      this.endPoint = AMapUtil.convertToLatLng(end)
    }
    if (throughPointList) {
      this.throughPointList = throughPointList
    }
  }

  public getRouteWidth() {
    return this.mWidth
  }

  /**
   * 设置路线宽度
   *
   * @param mWidth 路线宽度，取值范围：大于0
   */
  public setRouteWidth(mWidth: number) {
    this.mWidth = mWidth
  }

  /**
   * 分片传递
   * @param steps
   * @param batchSteps
   * @param batchPoints
   */
  processStepsInBatches(steps: ArrayList<TruckStep>, batchSteps = 10, batchPoints = 3000) {
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
        for (let k = 0; k < points.length; k++) {
          const latlng = convert(points[k]);
          this.mPolylineOptions?.add(latlng)
          this.mLatLngsOfPath?.add(latlng)
          if (--batchPoints <= 0) {
            break;
          }
        }
        stepCount++;
        if (batchPoints <= 0) {
          break;
        }
      }

      if (sIndex < stepLen) {
        // 让出主线程再继续
        setTimeout(processChunk, 0);
      } else {
        // 完成后的回调（可选）
        if (this.startMarker) {
          this.startMarker.remove()
          this.startMarker = undefined
        }

        if (this.endMarker) {
          this.endMarker.remove()
          this.endMarker = undefined
        }

        this.addStartAndEndMarker()
        this.addThroughPointMarker()


        if (this.isColorfulline && this.tmcs.length > 0) {
          if (!this.truckPath) {
            return
          }
           this.colorWayUpdateChunked(this.tmcs,50)
        } else {
          this.showPolyline()
        }
      }
    };
    processChunk();
  }

  /**
   * 添加驾车路线添加到地图上显示。
   */
  public addToMap() {
    this.initPolylineOptions()
    try {
      if (!this.mAMap) {
        return
      }

      if (this.mWidth == 0 || !this.truckPath) {
        return
      }

      this.mLatLngsOfPath = new ArrayList<LatLng>()
      this.tmcs = new ArrayList<TMC>()
      const steps = this.truckPath.getSteps()
      this.processStepsInBatches(steps, 5)
    } catch (e) {
    }

  }


  private showPolyline() {
    this.addPolyLine(this.mPolylineOptions)
  }


  /**
   * 初始化线段属性
   */
  private initPolylineOptions() {
    this.mPolylineOptions = undefined

    this.mPolylineOptions = new PolylineOptions()

    this.mPolylineOptions
      .setColor(this.getDriveColor())
      .setWidth(this.getRouteWidth())

  }

  private addThroughPointMarker() {
    if (this.throughPointList && this.throughPointList.length > 0) {
      for (const latLonPoint of this.throughPointList) {
        if (latLonPoint) {
          this.throughPointMarkerList.add(this.mAMap?.addMarker(new MarkerOptions()
            .setPosition(new LatLng(latLonPoint.getLatitude(), latLonPoint.getLongitude()))
            .setVisible(this.throughPointMarkerVisible)
            .setIcon(this.getThroughPointBitDes() as BitmapDescriptor)
            .setTitle("\u9014\u7ECF\u70B9")))
        }
      }
    }
  }


  protected getThroughPointBitDes() {
    return BitmapDescriptorFactory.fromRawfilePathSync(this.mContext, "amap_through.png");
  }

  private _colorSeq = 0;
  public colorWayUpdateChunked(tmcSection: ArrayList<TMC>, batchPoints: number = 3000) {
    if (!this.mAMap || !tmcSection || tmcSection.length === 0) return;
    const mySeq = ++this._colorSeq;
    const points: ArrayList<LatLng> = new ArrayList()
    const colors: number[] = [];
    if (!this.mLatLngsOfPath || this.mLatLngsOfPath.length <= 0) {
      return
    }
    let startLatLng = this.mLatLngsOfPath[0]
    //画出起点到规划路径之间的连线
    if (this.startPoint) {
      this.addPolyLine(new PolylineOptions().add(this.startPoint, startLatLng).setDottedLine(true))
    }


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
        const segColor = this.getColor(segStatus) ?? this.getDriveColor();

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
      this.addPolyLine(this.mPolylineOptionscolor);
      //终点和规划路径之间连线
      if (this.endPoint && points.length>0) {
        this.addPolyLine(new PolylineOptions().add(points[points.length -1], this.endPoint)
          .setDottedLine(true))
      }
    };
    processChunk();
  }


  private getColor(status: string | undefined): number {

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


  //获取指定两点之间固定距离点
  public getPointForDis(sPt: LatLng, ePt: LatLng, dis: number) {
    const lSegLength = this.calculateDistance(sPt, ePt)
    const preResult = dis / lSegLength
    return new LatLng((ePt.latitude - sPt.latitude) * preResult + sPt.latitude,
      (ePt.longitude - sPt.longitude) * preResult + sPt.longitude)
  }

  /**
   * 获取两点间距离
   *
   * @param start
   * @param end
   * @return
   */
  public calculateDistance(start: LatLng, end: LatLng): number {
    const x1 = start.longitude
    const y1 = start.latitude
    const x2 = end.longitude
    const y2 = end.latitude

    return this.calculateDistanceNum(x1, y1, x2, y2)
  }

  public calculateDistanceNum(x1: number, y1: number, x2: number, y2: number) {
    const NF_pi = 0.01745329251994329; // 弧度 PI/180
    x1 *= NF_pi
    y1 *= NF_pi
    x2 *= NF_pi
    y2 *= NF_pi
    const sinx1 = Math.sin(x1)
    const siny1 = Math.sin(y1)
    const cosx1 = Math.cos(x1)
    const cosy1 = Math.cos(y1)
    const sinx2 = Math.sin(x2)
    const siny2 = Math.sin(y2)
    const cosx2 = Math.cos(x2)
    const cosy2 = Math.cos(y2)
    let v1: number[] = []
    v1[0] = cosy1 * cosx1 - cosy2 * cosx2
    v1[1] = cosy1 * sinx1 - cosy2 * sinx2
    v1[2] = siny1 - siny2
    const dist = Math.sqrt(v1[0] * v1[0] + v1[1] * v1[1] + v1[2] * v1[2])

    return Math.asin(dist / 2) * 12742001.5798544
  }

  protected getLatLngBounds(): LatLngBounds | undefined {
    let b = LatLngBounds.builder()
    b.include(new LatLng(this.startPoint?.latitude ?? 0, this.startPoint?.longitude ?? 0))
    b.include(new LatLng(this.endPoint?.latitude ?? 0, this.endPoint?.longitude ?? 0))

    if (this.throughPointList && this.throughPointList.length > 0) {
      for (const point of this.throughPointList) {
        b.include(new LatLng(point.getLatitude(), point.getLongitude()))
      }

    }
    return b.build()
  }

  public setThroughPointIconVisibility(visible: boolean) {
    try {
      this.throughPointMarkerVisible = visible
      if (this.throughPointMarkerList && this.throughPointMarkerList.length > 0) {
        for (const pointMark of this.throughPointMarkerList) {
          pointMark.setVisible(visible)
        }

      }

    } catch (e) {
      e.printStackTrace()
    }
  }

  /**
   * 去掉DriveLineOverlay上的线段和标记。
   */
  public removeFromMap() {
    try {
      super.removeFromMap()
      if (this.throughPointMarkerList && this.throughPointMarkerList.length > 0) {
        for (const pointMark of this.throughPointMarkerList) {
          pointMark.remove()
        }
        this.throughPointMarkerList.clear()
      }

    } catch (e) {
      e.printStackTrace();
    }

  }
}

interface ColorAndLatLonModel {
  color: number
  points: ArrayList<LatLng>
}