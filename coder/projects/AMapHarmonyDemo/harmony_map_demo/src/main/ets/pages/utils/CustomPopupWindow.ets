@Component
export struct CustomPopupWindow{
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  strokeWidth = 2;
  private reactWidth = 180
  private reactHeight = 50
  private canvasWidth = this.reactWidth +this.strokeWidth
  private triangleWidth = 10;
  private triangleHeight = 15
  private  canvasHeight = this.reactHeight +this.strokeWidth+this.triangleHeight;
  halfStoke = this.strokeWidth/2
  drawStartX = this.strokeWidth/2
  drawStartY = this.strokeWidth/2

  cornerRadius = 5;
  centerX = this.drawStartX+ this.reactWidth/2
  leftX = this.centerX - this.triangleWidth/2
  rightX = this.centerX + this.triangleWidth/2
  topTrianY = this.halfStoke +this.reactHeight
  bottomTrianY = this.reactHeight + this.triangleHeight

  constructor(reactWidth :number=180,reactHeight:number =50,triangWidth:number=10,triangHeight = 15,strokeWidth:number=3) {
    super();
    this.reactWidth = reactWidth
    this.reactHeight = reactHeight;
    this.triangleWidth = triangWidth
    this.triangleHeight = triangHeight
    this.strokeWidth = strokeWidth

  }
  build() {
    Canvas(this.context)
      .width(this.canvasWidth)
      .height(this.canvasHeight)
      .backgroundColor(Color.Transparent)
      .onReady(() => {
        this.context.lineWidth = this.strokeWidth
        this.context.strokeStyle = Color.Gray
        this.context.fillStyle= Color.White
        let path = new Path2D();
        path.moveTo(this.halfStoke+this.cornerRadius,this.drawStartY)
        path.lineTo(this.canvasWidth - this.drawStartX - this.cornerRadius,this.drawStartY)
        path.arc(this.canvasWidth - this.halfStoke - this.cornerRadius, this.cornerRadius+this.halfStoke,this.cornerRadius,-Math.PI/2,0)
        path.lineTo(this.canvasWidth - this.halfStoke,this.topTrianY-this.cornerRadius)
        path.arc(this.canvasWidth - this.halfStoke - this.cornerRadius,this.topTrianY-this.cornerRadius,this.cornerRadius,0,Math.PI/2)
        path.lineTo(this.rightX,this.topTrianY)
        path.lineTo(this.centerX,this.bottomTrianY)
        path.lineTo(this.leftX,this.topTrianY)
        path.lineTo(this.halfStoke+this.cornerRadius,this.topTrianY)
        path.arc(this.halfStoke+this.cornerRadius,this.topTrianY-this.cornerRadius,this.cornerRadius,Math.PI/2,Math.PI)
        path.lineTo(this.halfStoke,this.halfStoke+this.cornerRadius)
        path.arc(this.halfStoke+this.cornerRadius,this.cornerRadius+this.halfStoke,this.cornerRadius,-Math.PI,-Math.PI/2)
        this.context.fill(path)
        this.context.stroke(path)
      })
  }
}