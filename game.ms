import "vec2"
import "mathUtil"
import "rigidbody"

bodyList = []
spawnPadding = 20

init = function
    clear
    
    for i in range(9)
        x = rnd * (spawnPadding + (960 - spawnPadding * 2))
        y = rnd * (spawnPadding + (640 - spawnPadding * 2))
        type = floor(mathUtil.randRange(0, 2))
        body = null
        if type == 0 then
            body = rigidbody.tryCreateCircleBody(30, vec2.create(x, y), 2, false, 0.5)
        else
            body = rigidbody.tryCreateBoxBody(30, 30, vec2.create(x, y), 2, false, 0.5)
        end if

        if not body == null then
            bodyList.push body
        end if
    end for

end function

update = function
    return not key.pressed("escape")
end function

draw = function
    
    for body in bodyList
        position = body.getPosition
        if body.shapeType == 0 then
            gfx.drawEllipse position.x, position.y, body.radius, body.radius, color.white
        else
            gfx.drawRect position.x, position.y, body.width, body.height, color.red
        end if
    end for

end function


init
draw
// shouldUpdate = true
// while shouldUpdate
//     shouldUpdate = update
// end while

// import "vec2"
// import "benchmark"

// rangeToLoop = range(200000)

// addingTwoFloats = function
//     x1 = 0.05
//     y1 = 0.002
//     x2 = 0.001
//     y2 = 0.003
//     for i in rangeToLoop
//         x1 += x2
//         y1 += y2
//     end for
// end function

// invertVec2 = function
//     v1 = vec2.create(0.05, 0.002)
//     for i in rangeToLoop
//         v1.vec2Invert
//     end for
// end function

// invertVec2New = function
//     v1 = vec2.create(0.05, 0.002)
//     for i in rangeToLoop
//         v1.vec2InvertNew
//     end for
// end function


// clear

// print "addingTwoFloats"
// benchmark.benchmarkFunction(@addingTwoFloats)
// print

// print "invertVec2"
// benchmark.benchmarkFunction(@invertVec2)
// print

// print "invertVec2New"
// benchmark.benchmarkFunction(@invertVec2New)
// print
