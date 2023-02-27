import "vec2"

Transform = {
    "positionX": 0,
    "positionY": 0,
    "sin": 0,
    "cos": 0,
}

create = function(position, angle)
    t = new Transform
    t.positionX = position.x
    t.positionY = position.y
    t.sin = sin(angle)
    t.cos = cos(angle)
    return t
end function