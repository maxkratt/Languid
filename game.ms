import "vec2"
import "mathUtil"
import "rigidbody"
import "collisions"

bodyList = []
bodyColors = []
spawnPadding = 20

init = function
    clear
    
    for i in range(9)
        x = rnd * (spawnPadding + (960 - spawnPadding * 2))
        y = rnd * (spawnPadding + (640 - spawnPadding * 2))
        type = 0// floor(mathUtil.randRange(0, 2))
        body = null
        if type == 0 then
            body = rigidbody.tryCreateCircleBody(30, vec2.create(x, y), 2, false, 0.5)
        else
            body = rigidbody.tryCreateBoxBody(30, 30, vec2.create(x, y), 2, false, 0.5)
        end if

        if body != null then
            bodyList.push body
            bodyColors.push randomColor
        end if
    end for

end function

update = function(deltaTime)
    
    handleCanvasZooming

    dx = key.axis("Horizontal", 0)
    dy = key.axis("Vertical", 0)
    speed = 240

    input = vec2.create(dx, dy)
    
    if dx != 0 or dy != 0 then
        input.vec2Normalize()
        velocity = input.vec2MulScalerNew(speed * deltaTime)
        bodyList[0].move(velocity)
    end if

    i = 0; while i < bodyList.len - 1
        bodyA = bodyList[i]

        j = i + 1; while j < bodyList.len
            bodyB = bodyList[j]

            normal = []
            depth = []
            if collisions.intersectCircles(bodyA._position, bodyA.radius, 
                                            bodyB._position, bodyB.radius, normal, depth) then
                halfDepth = depth[0] * 0.5
                bodyA.move normal[0].vec2MulScalerNew(-halfDepth)
                bodyB.move normal[0].vec2MulScalerNew(halfDepth)
            end if
        
        j += 1; end while
    i += 1; end while

    return not key.pressed("escape")
end function

gfx.fillCircle = function(position, radius, color = "#FFFFFF")
    diameter = radius * 2
    gfx.fillEllipse position.x - radius, position.y - radius, diameter, diameter, color
end function

gfx.drawCircle = function(position, radius, color = "#FFFFFF")
    diameter = radius * 2
    gfx.drawEllipse position.x - radius, position.y - radius, diameter, diameter, color
end function

display(7).color = "#303b44"
draw = function
    
    gfx.fillRect 0, 0, gfx.width, gfx.height, "#303b44"
    i = 0
    for body in bodyList
        position = body._position
        radius = body.radius
        if body.shapeType == 0 then
            gfx.fillCircle position, radius, bodyColors[i]
            gfx.drawCircle position, radius, color.white
        else
            gfx.fillRect position.x, position.y, body.width, body.height, bodyColors[i]
            gfx.drawRect position.x, position.y, body.width, body.height, color.white
        end if
        i += 1
    end for

end function


handleCanvasZooming = function
    input = key.axis("Mouse ScrollWheel")
    if input != 0 then
        gfx.scale += input * 0.04

        // mx = 1 / gfx.scrollX * mouse.x
        mx = mouse.x
        horizontalOffset = mx * gfx.scale - mx
        horizontalOffset = mathUtil.lerp(gfx.scrollX, horizontalOffset, 0.5)
        gfx.scrollX = horizontalOffset

        my = mouse.y
        verticalOffset = my * gfx.scale - my
        verticalOffset = mathUtil.lerp(gfx.scrollY, verticalOffset, 0.5)
        gfx.scrollY = verticalOffset
    end if
end function

randomColor = function
    return color.rgb(floor(rnd * 256), floor(rnd * 256), floor(rnd * 256))
end function

clear
prevCounter = ""
lastTime = 0
fps = 0
updateCounter = function(dt)
	counter = round(time)
	if counter == prevCounter then 
        globals.fps += 1
        return
    end if
    rowLastAt = text.row
	text.row = 25
	print "FPS: " + fps
    text.row = rowLastAt
	globals.prevCounter = counter
    globals.fps = 1
end function

init
shouldUpdate = true
while shouldUpdate
    now = time
	dt = now - lastTime
	lastTime = now
	updateCounter dt
    shouldUpdate = update(dt)
    draw
    yield
end while




// import "vec2"
// import "benchmark"

// rangeToLoop = range(200000)

// vec2AddScaler = function
//     v1 = vec2.create(41.04, 25.002)
//     for i in rangeToLoop
//         v1.vec2AddScaler 1.3
//     end for
// end function

// vec2AddScaler2 = function
//     v1 = vec2.create(41.04, 25.002)
//     for i in rangeToLoop
//         v1.vec2AddScaler2 1.3
//     end for
// end function

// clear


// print "vec2AddScaler"
// benchmark.benchmarkFunction(@vec2AddScaler)
// print
// print "vec2AddScaler2"
// benchmark.benchmarkFunction(@vec2AddScaler2)
// print