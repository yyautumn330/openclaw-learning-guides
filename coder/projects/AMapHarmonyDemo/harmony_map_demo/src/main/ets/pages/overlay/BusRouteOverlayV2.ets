import { AMap, BitmapDescriptor, LatLng, MarkerOptions, PolylineOptions } from "@amap/amap_lbs_map3d";
import {
  BusPathV2,
  BusStepV2,
  LatLonPoint,
  RailwayStationItem,
  RouteBusLineItem,
  RouteRailwayItem,
  TaxiItemV2,
  WalkStep
} from "@amap/amap_lbs_search";
import { RouteOverlay } from "./RouteOverlay";
import { AMapUtil } from "../utils/AMapUtil";
import { ArrayList } from "@kit.ArkTS";

/**
 * 公交路线图层类。在高德地图API里，如果需要显示公交路线，可以用此类来创建公交路线图层。如不满足需求，也可以自己创建自定义的公交路线图层。
 * @since V2.1.0
 */
export class BusRouteOverlayV2 extends RouteOverlay {
  private busPath: BusPathV2;
  private latLng?: LatLng;

  /**
   * 通过此构造函数创建公交路线图层。
   * @param context 当前activity。
   * @param amap 地图对象。
   * @param path 公交路径规划的一个路段。详见搜索服务模块的路径查询包（com.amap.api.services.route）中的类<strong> <a href="../../../../../../Search/com/amap/api/services/route/BusPath.html" title="com.amap.api.services.route中的类">BusPath</a></strong>。
   * @param start 起点坐标。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
   * @param end 终点坐标。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
   * @since V2.1.0
   */
  constructor(context: Context, amap: AMap, path: BusPathV2,
    start: LatLonPoint, end: LatLonPoint) {
    super(context);
    this.busPath = path;
    this.startPoint = AMapUtil.convertToLatLng(start);
    this.endPoint = AMapUtil.convertToLatLng(end);
    this.mAMap = amap;
  }

  /**
   * 添加公交路线到地图上。
   * @since V2.1.0
   */

  public addToMap() {
    /**
     * 绘制节点和线<br>
     * 细节情况较多<br>
     * 两个step之间，用step和step1区分<br>
     * 1.一个step内可能有步行和公交，然后有可能他们之间连接有断开<br>
     * 2.step的公交和step1的步行，有可能连接有断开<br>
     * 3.step和step1之间是公交换乘，且没有步行，需要把step的终点和step1的起点连起来<br>
     * 4.公交最后一站和终点间有步行，加入步行线路，还会有一些步行marker<br>
     * 5.公交最后一站和终点间无步行，之间连起来<br>
     */
    try {
      let busSteps = this.busPath.getSteps();
      for (let i = 0; i < busSteps.length; i++) {
        let busStep = busSteps[i];
        if (i < busSteps.length - 1) {
          let busStep1 = busSteps[i + 1]; // 取得当前下一个BusStep对象
          // 假如步行和公交之间连接有断开，就把步行最后一个经纬度点和公交第一个经纬度点连接起来，避免断线问题
          if (busStep.getWalk() != null
            && busStep.getBusLine() != null) {
            this.checkWalkToBusline(busStep);
          }

          // 假如公交和步行之间连接有断开，就把上一公交经纬度点和下一步行第一个经纬度点连接起来，避免断线问题
          if (busStep.getBusLine() != null && busStep1.getWalk() != null
            && (busStep1.getWalk()?.getSteps().length ?? 0 > 0)) {
            this.checkBusLineToNextWalk(busStep, busStep1);
          }
          // 假如两个公交换乘中间没有步行，就把上一公交经纬度点和下一步公交第一个经纬度点连接起来，避免断线问题
          if (busStep.getBusLine() != null
            && busStep1.getWalk() == null
            && busStep1.getBusLine() != null) {
            this.checkBusEndToNextBusStart(busStep, busStep1);
          }
          // 和上面的很类似
          if (busStep.getBusLine() != null
            && busStep1.getWalk() == null
            && busStep1.getBusLine() != null) {
            this.checkBusToNextBusNoWalk(busStep, busStep1);
          }
          if (busStep.getBusLine() != null
            && busStep1.getRailway() != null) {
            this.checkBusLineToNextRailway(busStep, busStep1);
          }
          if (busStep1.getWalk() != null &&
            (busStep1.getWalk()?.getSteps().length ?? 0) > 0 &&
            busStep.getRailway() != null) {
            this.checkRailwayToNextWalk(busStep, busStep1);
          }

          if (busStep1.getRailway() != null &&
            busStep.getRailway() != null) {
            this.checkRailwayToNextRailway(busStep, busStep1);
          }

          if (busStep.getRailway() != null &&
            busStep1.getTaxi() != null) {
            this.checkRailwayToNextTaxi(busStep, busStep1);
          }


        }

        if (busStep.getWalk() != null
          && (busStep.getWalk()?.getSteps().length ?? 0) > 0) {
          this.addWalkSteps(busStep);
        } else {
          if (busStep.getBusLine() == null && busStep.getRailway() == null && busStep.getTaxi() == null) {
            this.addWalkPolyline(this.latLng as LatLng, this.endPoint as LatLng);
          }
        }
        if (busStep.getBusLine() != null) {
          let routeBusLineItem = busStep.getBusLine();
          this.addBusLineSteps(routeBusLineItem ?? new RouteBusLineItem());
          this.addBusStationMarkers(routeBusLineItem as RouteBusLineItem);
          if (i == busSteps.length - 1) {
            this.addWalkPolyline(AMapUtil.convertToLatLng(this.getLastBuslinePoint(busStep) as LatLonPoint),
              this.endPoint as LatLng);
          }
        }
        if (busStep.getRailway() != null) {
          this.addRailwayStep(busStep.getRailway() as RouteRailwayItem);
          this.addRailwayMarkers(busStep.getRailway() as RouteRailwayItem);
          if (i == busSteps.length - 1) {
            this.addWalkPolyline(AMapUtil.convertToLatLng(busStep.getRailway()?.getArrivalstop()?.getLocation() as LatLonPoint),
              this.endPoint as LatLng);
          }
        }
        if (busStep.getTaxi() != null) {
          this.addTaxiStep(busStep.getTaxi() as TaxiItemV2);
          this.addTaxiMarkers(busStep.getTaxi() as TaxiItemV2);
        }
      }
      this.addStartAndEndMarker();

    } catch (e) {
      e.printStackTrace();
    }
  }


  private checkRailwayToNextTaxi(busStep: BusStepV2, busStep1: BusStepV2) {
    let railwayLastPoint = busStep.getRailway()?.getArrivalstop()?.getLocation();
    let taxiFirstPoint = busStep1.getTaxi()?.getOrigin();
    if (!railwayLastPoint?.equals(taxiFirstPoint as LatLonPoint)) {
      this.addWalkPolyLineByLatLonPoints(railwayLastPoint as LatLonPoint,
        taxiFirstPoint as LatLonPoint);
    }
  }

  private checkRailwayToNextRailway(busStep: BusStepV2, busStep1: BusStepV2) {
    let railwayLastPoint = busStep.getRailway()?.getArrivalstop()?.getLocation();
    let railwayFirstPoint = busStep1.getRailway()?.getDeparturestop()?.getLocation();
    if (!railwayLastPoint?.equals(railwayFirstPoint as LatLonPoint)) {
      this.addWalkPolyLineByLatLonPoints(railwayLastPoint as LatLonPoint,
        railwayFirstPoint as LatLonPoint);
    }

  }

  private checkBusLineToNextRailway(busStep: BusStepV2, busStep1: BusStepV2) {
    let busLastPoint = this.getLastBuslinePoint(busStep);
    let railwayFirstPoint = busStep1.getRailway()?.getDeparturestop()?.getLocation();
    if (!busLastPoint?.equals(railwayFirstPoint as LatLonPoint)) {
      this.addWalkPolyLineByLatLonPoints(busLastPoint as LatLonPoint,
        railwayFirstPoint as LatLonPoint);
    }

  }

  private checkRailwayToNextWalk(busStep: BusStepV2, busStep1: BusStepV2) {
    let railwayLastPoint = busStep.getRailway()?.getArrivalstop()?.getLocation();
    let walkFirstPoint = this.getFirstWalkPoint(busStep1);
    if (!railwayLastPoint?.equals(walkFirstPoint as LatLonPoint)) {
      this.addWalkPolyLineByLatLonPoints(railwayLastPoint as LatLonPoint,
        walkFirstPoint as LatLonPoint);
    }

  }

  private addRailwayStep(railway: RouteRailwayItem) {
    let railwaylistpoint = new ArrayList<LatLng>();
    let railwayStationItems = new ArrayList<RailwayStationItem>();
    railwayStationItems.add(railway.getDeparturestop());
    railway.getViastops().forEach(item => railwayStationItems.add(item))
    railwayStationItems.add(railway.getArrivalstop());
    for (let i = 0; i < railwayStationItems.length; i++) {
      railwaylistpoint.add(AMapUtil.convertToLatLng(railwayStationItems[i].getLocation() as LatLonPoint));
    }
    this.addRailwayPolyline(railwaylistpoint);
  }

  private addTaxiStep(taxi: TaxiItemV2) {
    this.addPolyLine(new PolylineOptions()
      .setWidth(this.getRouteWidth())
      .setColor(this.getBusColor())
      .add(AMapUtil.convertToLatLng(taxi.getOrigin() as LatLonPoint))
      .add(AMapUtil.convertToLatLng(taxi.getDestination() as LatLonPoint)));
  }

  /**
   * @param busStep
   */
  private addWalkSteps(busStep: BusStepV2) {
    let routeBusWalkItem = busStep.getWalk();
    let walkSteps = routeBusWalkItem?.getSteps();
    for (let j = 0; j < (walkSteps?.length ?? 0); j++) {
      let walkStep = walkSteps?.[j];
      if (j == 0) {
        let pointer: LatLonPoint | undefined =
          (walkStep?.getPolyline()?.length ?? 0) > 0 ? walkStep?.getPolyline()[0] : undefined
        if (pointer) {
          let latLng = AMapUtil.convertToLatLng(pointer);
          let road = walkStep?.getRoad(); // 道路名字
          let instruction = this.getWalkSnippet(walkSteps as ArrayList<WalkStep>); // 步行导航信息
          this.addWalkStationMarkers(latLng, road ?? '', instruction);
        }
      }

      let listWalkPolyline = AMapUtil.convertArrList(walkStep?.getPolyline() as ArrayList<LatLonPoint>);
      this.latLng = listWalkPolyline.length > 0 ? listWalkPolyline[listWalkPolyline.length - 1] : undefined;

      this.addWalkPolylineList(listWalkPolyline);

      // 假如步行前一段的终点和下的起点有断开，断画直线连接起来，避免断线问题
      if (j < (walkSteps?.length ?? 0) - 1) {
        let lastLatLng = listWalkPolyline.length > 0 ? listWalkPolyline[listWalkPolyline.length - 1] : undefined;
        let firstlatLatLng = AMapUtil.convertToLatLng(
          ((walkSteps?.[j + 1].getPolyline().length ?? 0) > 0 ? walkSteps?.[j + 1].getPolyline()[0] :
            undefined) as LatLonPoint);
        if (!(lastLatLng?.equals(firstlatLatLng))) {
          this.addWalkPolyline(lastLatLng as LatLng, firstlatLatLng);
        }
      }

    }
  }

  /**
   * 添加一系列的bus PolyLine
   *
   * @param routeBusLineItem
   */
  private addBusLineSteps(routeBusLineItem: RouteBusLineItem) {
    this.addBusLineStepList(routeBusLineItem.getPolyline());
  }

  private addBusLineStepList(listPoints: ArrayList<LatLonPoint>) {
    if (listPoints.length < 1) {
      return;
    }
    this.addPolyLine(new PolylineOptions()
      .setWidth(this.getRouteWidth())
      .setColor(this.getBusColor())
      .addAll(AMapUtil.convertArrList(listPoints)));
  }

  /**
   * @param latLng
   *            marker
   * @param title
   * @param snippet
   */
  private addWalkStationMarkers(latLng: LatLng, title: string, snippet: string) {
    this.addStationMarker(new MarkerOptions()
      .setPosition(latLng)
      .setTitle(title)
      .setSnippet(snippet)
      .setAnchor(0.5, 0.5)
      .setVisible(this.nodeIconVisible)
      .setIcon(this.getWalkBitmapDescriptor() as BitmapDescriptor)
      .setZIndex(99)
    );
  }

  /**
   * @param routeBusLineItem
   */
  private addBusStationMarkers(routeBusLineItem: RouteBusLineItem) {
    let startBusStation = routeBusLineItem.getDepartureBusStation();
    let position = AMapUtil.convertToLatLng(startBusStation?.getLatLonPoint() as LatLonPoint);
    let title = routeBusLineItem.getBusLineName();
    let snippet = this.getBusSnippet(routeBusLineItem);

    this.addStationMarker(new MarkerOptions()
      .setPosition(position)
      .setTitle(title ?? '')
      .setSnippet(snippet)
      .setAnchor(0.5, 0.5)
      .setVisible(this.nodeIconVisible)
      .setIcon(this.getBusBitmapDescriptor() as BitmapDescriptor)
      .setZIndex(99)
    );
  }

  private addTaxiMarkers(taxiItem: TaxiItemV2) {

    let position = AMapUtil.convertToLatLng(taxiItem.getOrigin() as LatLonPoint);
    let title = taxiItem.getmSname() + "打车";
    let snippet = "到终点";

    this.addStationMarker(new MarkerOptions()
      .setPosition(position)
      .setTitle(title)
      .setSnippet(snippet)
      .setAnchor(0.5, 0.5)
      .setVisible(this.nodeIconVisible)
      .setIcon(this.getDriveBitmapDescriptor() as BitmapDescriptor)
      .setZIndex(99)
    );
  }

  private addRailwayMarkers(railway: RouteRailwayItem) {
    let Departureposition = AMapUtil.convertToLatLng(railway?.getDeparturestop()?.getLocation() as LatLonPoint);
    let Departuretitle = railway.getDeparturestop()?.getName() + "上车";
    let Departuresnippet = railway.getName();

    this.addStationMarker(new MarkerOptions()
      .setPosition(Departureposition)
      .setTitle(Departuretitle)
      .setSnippet(Departuresnippet ?? '')
      .setAnchor(0.5, 0.5)
      .setVisible(this.nodeIconVisible)
      .setIcon(this.getBusBitmapDescriptor() as BitmapDescriptor)
      .setZIndex(99)
    );

    let Arrivalposition = AMapUtil.convertToLatLng(railway.getArrivalstop()?.getLocation() as LatLonPoint);
    let Arrivaltitle = railway.getArrivalstop()?.getName() + "下车";
    let Arrivalsnippet = railway.getName();

    this.addStationMarker(new MarkerOptions()
      .setPosition(Arrivalposition)
      .setTitle(Arrivaltitle)
      .setSnippet(Arrivalsnippet ?? '')
      .setAnchor(0.5, 0.5)
      .setVisible(this.nodeIconVisible)
      .setIcon(this.getBusBitmapDescriptor() as BitmapDescriptor)
    );
  }

  /**
   * 如果换乘没有步行 检查bus最后一点和下一个step的bus起点是否一致
   *
   * @param busStep
   * @param busStep1
   */
  private checkBusToNextBusNoWalk(busStep: BusStepV2, busStep1: BusStepV2) {
    let endbusLatLng = AMapUtil.convertToLatLng(this.getLastBuslinePoint(busStep) as LatLonPoint);
    let startbusLatLng = AMapUtil
      .convertToLatLng(this.getFirstBuslinePoint(busStep1) as LatLonPoint);
    if (startbusLatLng.latitude - endbusLatLng.latitude > 0.0001
      || startbusLatLng.longitude - endbusLatLng.longitude > 0.0001) {
      this.drawLineArrow(endbusLatLng, startbusLatLng); // 断线用带箭头的直线连?
    }
  }

  /**
   *
   * checkBusToNextBusNoWalk 和这个类似
   *
   * @param busStep
   * @param busStep1
   */
  private checkBusEndToNextBusStart(busStep: BusStepV2, busStep1: BusStepV2) {
    let busLastPoint = this.getLastBuslinePoint(busStep);
    let endbusLatLng = AMapUtil.convertToLatLng(busLastPoint as LatLonPoint);
    let busFirstPoint = this.getFirstBuslinePoint(busStep1);
    let startbusLatLng = AMapUtil.convertToLatLng(busFirstPoint as LatLonPoint);
    if (!endbusLatLng.equals(startbusLatLng)) {
      this.drawLineArrow(endbusLatLng, startbusLatLng); //
    }
  }

  /**
   * 检查bus最后一步和下一各step的步行起点是否一致
   *
   * @param busStep
   * @param busStep1
   */
  private checkBusLineToNextWalk(busStep: BusStepV2, busStep1: BusStepV2) {
    let busLastPoint = this.getLastBuslinePoint(busStep);
    let walkFirstPoint = this.getFirstWalkPoint(busStep1);
    if (!busLastPoint?.equals(walkFirstPoint as LatLonPoint)) {
      this.addWalkPolyLineByLatLonPoints(busLastPoint as LatLonPoint,
        walkFirstPoint as LatLonPoint);
    }
  }

  /**
   * 检查 步行最后一点 和 bus的起点 是否一致
   *
   * @param busStep
   */
  private checkWalkToBusline(busStep: BusStepV2) {
    let walkLastPoint = this.getLastWalkPoint(busStep);
    let buslineFirstPoint = this.getFirstBuslinePoint(busStep);

    if (!walkLastPoint?.equals(buslineFirstPoint as LatLonPoint)) {
      this.addWalkPolyLineByLatLonPoints(walkLastPoint as LatLonPoint,
        buslineFirstPoint as LatLonPoint);
    }
  }

  /**
   * @param busStep1
   * @return
   */
  private getFirstWalkPoint(busStep1: BusStepV2) {
    if ((busStep1.getWalk()?.getSteps()?.length ?? 0) > 0 &&
      (busStep1.getWalk()?.getSteps()[0].getPolyline().length ?? 0) > 0) {
      return busStep1.getWalk()?.getSteps()[0].getPolyline()[0];
    } else {
      return undefined
    }
  }

  /**
   *
   */
  private addWalkPolyLineByLatLonPoints(pointFrom: LatLonPoint, pointTo: LatLonPoint) {
    let latLngFrom = AMapUtil.convertToLatLng(pointFrom);
    let latLngTo = AMapUtil.convertToLatLng(pointTo);

    this.addWalkPolyline(latLngFrom, latLngTo);
  }

  /**
   * @param latLngFrom
   * @param latLngTo
   * @return
   */
  private addWalkPolyline(latLngFrom: LatLng, latLngTo: LatLng) {
    this.addPolyLine(new PolylineOptions().add(latLngFrom, latLngTo)
      .setWidth(this.getRouteWidth())
      .setColor(this.getWalkColor())
      .setDottedLine(true)
    );
  }

  /**
   * @param listWalkPolyline
   */
  private addWalkPolylineList(listWalkPolyline: ArrayList<LatLng>) {

    this.addPolyLine(new PolylineOptions()
      .addAll(listWalkPolyline)
      .setColor(this.getWalkColor())
      .setWidth(this.getRouteWidth())
      .setDottedLine(true));
  }

  private addRailwayPolyline(listPolyline: ArrayList<LatLng>) {

    this.addPolyLine(new PolylineOptions()
      .addAll(listPolyline)
      .setColor(this.getDriveColor())
      .setWidth(this.getRouteWidth()));
  }

  private getWalkSnippet(walkSteps: ArrayList<WalkStep>) {
    let disNum = 0;
    for (let step of walkSteps) {
      disNum += step.getDistance();
    }
    return "\u6B65\u884C" + disNum + "\u7C73";
  }

  public drawLineArrow(latLngFrom: LatLng, latLngTo: LatLng) {

    this.addPolyLine(new PolylineOptions().add(latLngFrom, latLngTo)
      .setWidth(3)
      .setColor(this.getBusColor())
      .setWidth(this.getRouteWidth())); // 绘制直线
  }

  private getBusSnippet(routeBusLineItem: RouteBusLineItem) {
    return "("
      + routeBusLineItem.getDepartureBusStation()?.getBusStationName()
      + "-->"
      + routeBusLineItem.getArrivalBusStation()?.getBusStationName()
      + ") \u7ECF\u8FC7" + (routeBusLineItem.getPassStationNum() ?? 0 + 1)
      + "\u7AD9";
  }

  /**
   * @param busStep
   * @return
   */
  private getLastWalkPoint(busStep: BusStepV2) {

    let walkSteps = busStep.getWalk()?.getSteps();
    let walkStep = walkSteps?.[walkSteps?.length - 1];
    let lonPoints = walkStep?.getPolyline();
    if (lonPoints?.length === 0) {
      return undefined
    } else {
      return lonPoints?.[lonPoints.length - 1];
    }
  }

  private getLastBuslinePoint(busStep: BusStepV2) {
    let lonPoints = busStep.getBusLine()?.getPolyline();
    if (lonPoints?.length === 0) {
      return undefined
    } else {
      return lonPoints?.[lonPoints.length - 1];
    }
  }

  private getFirstBuslinePoint(busStep: BusStepV2) {
    if (busStep.getBusLine()?.getPolyline()?.length === 0) {
      return undefined
    } else {
      return busStep.getBusLine()?.getPolyline()[0];
    }
  }
}