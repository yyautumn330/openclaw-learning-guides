import { AMap, LatLng, PolylineOptions } from "@amap/amap_lbs_map3d";
import { DrivePlanStep, DriveRoutePlanResult
} from "@amap/amap_lbs_search";
import { AMapUtil } from "../utils/AMapUtil";
import { RouteOverlay } from "./RouteOverlay";
import { ArrayList } from "@kit.ArkTS";
import { LatLonPoint, TMC } from "@amap/amap_lbs_search";
import { TimeInfo } from "@amap/amap_lbs_search";
import { ColorUtil } from "../utils/ColorUtil";

export class DrivingRoutePlanOverlay extends RouteOverlay {
  driveRoutePlanResult: DriveRoutePlanResult;
  private isColorfulline = true;
  private mWidth = 25;
  private mLatLngsOfPath: ArrayList<LatLng> = new ArrayList();
  private selectIndex = 0;
  private mPolylineOptions?: PolylineOptions;
  private mPolylineOptionscolor?: PolylineOptions;

  public constructor(context: Context, amap: AMap, result: DriveRoutePlanResult, index: number) {
    super(context);

    this.mContext = context;
    this.mAMap = amap;
    this.driveRoutePlanResult = result;
    this.selectIndex = index;

    if (result) {
      const startLatLonPoint = result.getStartPos()
      const targetLatLonPoint = result.getTargetPos()
      if (startLatLonPoint) {
        this.startPoint = AMapUtil.convertToLatLng(startLatLonPoint);
      }
      if (targetLatLonPoint) {
        this.endPoint = AMapUtil.convertToLatLng(targetLatLonPoint);
      }
    }
  }

  public setIsColorfulline(iscolorfulline: boolean) {
    this.isColorfulline = iscolorfulline;
  }

  /**
   * 分片传递
   * @param steps
   * @param batchSteps
   * @param batchPoints
   */
  processStepsInBatches(steps: ArrayList<DrivePlanStep>, tmcs:ArrayList<TMC>, batchSteps = 10, batchPoints = 3000) {
    const convert = AMapUtil.convertToLatLng;
    let sIndex = 0;
    const stepLen = steps.length;
    const processChunk = () => {
      let stepCount = 0;
      while (sIndex < stepLen && stepCount < batchSteps) {
        const step = steps[sIndex++];
        // points 分内循环以控制单批点数
          const latlonPoints = step.getPolyline();
          for (const latlonpoint of latlonPoints) {
            this.mPolylineOptions?.add(convert(latlonpoint));
            this.mLatLngsOfPath.add(convert(latlonpoint));
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
        // 让出主线程再继续 未处理完，下一帧继续
        setTimeout(processChunk, 0);
      } else {
        if (this.startMarker) {
          this.startMarker.remove();
          this.startMarker = undefined;
        }
        if (this.endMarker) {
          this.endMarker.remove();
          this.endMarker = undefined;
        }
        this.addStartAndEndMarker();

        if (this.isColorfulline && tmcs.length > 0) {
          this.colorWayUpdateChunked(tmcs)
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

      if (!this.mWidth || !this.driveRoutePlanResult) {
        return;
      }

      if (!this.driveRoutePlanResult.getTimeInfos() || !this.driveRoutePlanResult.getPaths()) {
        return;
      }

      this.mLatLngsOfPath = new ArrayList<LatLng>();
      let tmcs = new ArrayList<TMC>();

      const timeInfos: ArrayList<TimeInfo> = this.driveRoutePlanResult.getTimeInfos();

      if (this.selectIndex >= 0 && this.selectIndex < timeInfos.length) {
        tmcs = timeInfos[this.selectIndex].getElements()[0].getTMCs();
      }

      const pathIndex = timeInfos[this.selectIndex].getElements()[0].getPathindex();
      if (pathIndex < 0 || pathIndex > this.driveRoutePlanResult.getPaths().length) {
        return;
      }

      const drivePlanPath = this.driveRoutePlanResult.getPaths()[pathIndex];
      const drivePaths = drivePlanPath.getSteps();
      this.processStepsInBatches(drivePaths,tmcs,5)
    } catch (e) {

    }
  }


  /**
   * 初始化线段属性
   */
  private initPolylineOptions() {

    this.mPolylineOptions = undefined;

    this.mPolylineOptions = new PolylineOptions();
    this.mPolylineOptions.setColor(this.getDriveColor()).setWidth(this.getRouteWidth());
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
}