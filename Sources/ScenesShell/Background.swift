
import Scenes
import Igis
import Foundation

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {


    func renderRect(canvas:Canvas, rect: Rect) {
        let rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)
        canvas.render(rectangle)
    }

    func renderRow(canvas:Canvas, rect:Rect, columns: Int) {
        var currentrect = rect
        for _ in 1 ... columns {
            renderRect(canvas:canvas, rect:currentrect)
            currentrect.topLeft.x += currentrect.width
        }
    }

    func renderPumpkin(canvas:Canvas, x: Int, y: Int) {
        var  ellipse = Ellipse(center:Point(x: x, y: y), radiusX: 55, radiusY:70, fillMode: .fill)
        var stemRect = Rect(bottomRight: Point(x: x + 37, y: y - ellipse.radiusY), size: Size(width: 10, height: 30))
        var stem = Rectangle(rect: stemRect, fillMode:.fill)
                  

        for x in 1 ... 3 {
            canvas.render(FillStyle(color:Color(.orange)), ellipse)
            ellipse.center.x += Int(Double(ellipse.radiusX)/(1.5))

            if x == 2 {
                canvas.render(FillStyle(color:Color(.green)), stem)
            }
            
        }
        
    }

    func renderBrickWall(canvas:Canvas, rect:Rect, columns: Int, rows: Int) {
        var currentrect = rect
        canvas.render(FillStyle(color:Color(.indianred)), StrokeStyle(color:Color(.darkslategray)))
        let back = Rect(topLeft:Point(x:rect.topLeft.x, y:rect.topLeft.y), size:Size(width:rect.width*columns, height:rect.height*columns))
       renderRect(canvas:canvas, rect:back)
        for index in 1 ... rows {
            if index%2 == 0 {
            renderRow(canvas:canvas, rect:currentrect, columns:columns)
            currentrect.topLeft.y += currentrect.height
            }
            if index%2 == 1 {
                currentrect.topLeft.x += currentrect.width/2
                renderRow(canvas:canvas, rect:currentrect, columns:columns-1)
                currentrect.topLeft.x -= currentrect.width/2
                currentrect.topLeft.y += currentrect.height

        }
        }
    }


      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
      }

      override func setup(canvasSize: Size, canvas:Canvas) {
      }
      override func render(canvas:Canvas) {
          if let canvasSize = canvas.canvasSize {
          canvas.render(FillStyle(color:Color(.green)),Ellipse(center:Point(x:40, y:40), radiusX:25, radiusY:25, fillMode:.fill))
          canvas.render(FillStyle(color:Color(.cornflowerblue)), StrokeStyle(color:Color(.cornflowerblue)))

          renderRect(canvas:canvas, rect:Rect(topLeft:Point(x:0, y:0), size:canvasSize))

          canvas.render(FillStyle(color:Color(.white)), StrokeStyle(color:Color(.white)))
          renderRect(canvas:canvas, rect:Rect(topLeft:Point(x:0, y:800), size:Size(width:canvasSize.width, height:canvasSize.height-800)))
//          renderBrickWall(canvas:canvas, rect:Rect(topLeft:Point(x:50, y:620), size:Size(width:45, height:30)), columns:5, rows:6)


          let lake = Path(fillMode:.fillAndStroke)
          lake.moveTo(Point(x:700, y:800))
          lake.lineTo(Point(x:400, y:800))
          lake.bezierCurveTo(controlPoint1:Point(x:450, y:900), controlPoint2:Point(x:650, y:900), endPoint:Point(x:700, y:800))

          canvas.render(FillStyle(color:Color(.teal)), StrokeStyle(color:Color(.teal)), lake)

          let boat = Path(fillMode:.fillAndStroke)
          boat.moveTo(Point(x:625,y:750))
          boat.lineTo(Point(x:475, y:750))
          boat.bezierCurveTo(controlPoint1:Point(x:500, y:800), controlPoint2:Point(x:600, y:835), endPoint:Point(x:625, y :750))
          boat.moveTo(Point(x:550, y:750))
          boat.lineTo(Point(x:550, y:700))
          canvas.render(FillStyle(color:Color(.brown)), StrokeStyle(color:Color(.black)), boat)

          canvas.render(FillStyle(color:Color(.white)), StrokeStyle(color:Color(.black)))
          renderRect(canvas:canvas, rect:Rect(topLeft:Point(x:515, y:650), size:Size(width:70, height:70)))




          renderPumpkin(canvas: canvas, x: 200, y: 800)
          }
      }

      

}
