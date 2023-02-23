import "mathUtil"
import "vec2"
import "world"

// Rigidbody2D ////////////////////////////////////////////////////////////////
Rigidbody2D = {
    "_position": vec2.create,
    "_linearVelocity": vec2.create,
    "_rotation": 0,
    "_rotationalVelocity": 0,

    "density": 0,
    "mass": 0,
    "restitution": 0,
    "area": 0,

    "isStatic": false,

    "radius": 0,
    "width": 0,
    "height": 0,

    "shapeType": 0, // Circle = 0, Box = 1
}

Rigidbody2D.getPosition = function
    return self._position
end function

tryCreateCircleBody = function(radius, position, density, isStatic, restitution)
    outRigidbody = null

    area = radius * radius * pi

    if area < world.minBodySize then
        print "Area is too small. Minimum area is " + world.minBodySize + "."
        return false
    else if area > world.maxBodySize then
        print "Area is too large. Maximum area is " + world.maxBodySize + "."
        return false
    else if density < world.minDensity then
        print "Density is too low. Minimum density is " + world.minDensity + "."
        return false
    else if density > world.maxDensity then
        print "Density of " + density + " is too high. Maximum density is " + world.maxDensity + "."
        return false
    end if

    restitution = mathUtil.clamp(restitution)

    mass = area * density

    outRigidbody = new Rigidbody2D
    outRigidbody._position = position
    outRigidbody.density = density
    outRigidbody.mass = mass
    outRigidbody.restitution = restitution
    outRigidbody.area = area
    outRigidbody.isStatic = isStatic
    outRigidbody.radius = radius
    outRigidbody.shapeType = 0

    return outRigidbody
end function

tryCreateBoxBody = function(width, height, position, density, isStatic, restitution)
    outRigidbody = null

    area = width * height

    if area < world.minBodySize then
        print "Area is too small. Minimum area is " + world.minBodySize + "."
        return false
    else if area > world.maxBodySize then
        print "Area is too large. Maximum area is " + world.maxBodySize + "."
        return false
    else if density < world.minDensity then
        print "Density is too low. Minimum density is " + world.minDensity + "."
        return false
    else if density > world.maxDensity then
        print "Density is " + density + " too high. Maximum density is " + world.maxDensity + "."
        return false
    end if

    restitution = mathUtil.clamp(restitution)

    mass = area * density

    outRigidbody = new Rigidbody2D
    outRigidbody._position = position
    outRigidbody.density = density
    outRigidbody.mass = mass
    outRigidbody.restitution = restitution
    outRigidbody.area = area
    outRigidbody.isStatic = isStatic
    outRigidbody.width = width
    outRigidbody.height = height
    outRigidbody.shapeType = 1
    
    return outRigidbody
end function

Rigidbody2D.move = function(amount)
    self._position += amount
end function

Rigidbody2D.moveTo = function(position)
    self._position = position
end function
///////////////////////////////////////////////////////////////////////////////
