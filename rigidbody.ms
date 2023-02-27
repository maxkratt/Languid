import "mathUtil"
import "vec2"
import "world"
import "transform"

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

    "_vertices": null,

    "shapeType": 0, // Circle = 0, Box = 1
}

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
    outRigidbody._vertices = createBoxVertices(width, height)
    outRigidbody.triangles = triangulateBox
    outRigidbody._transformedVertices = [100, 100, 100, 100]
    outRigidbody._transformUpdateRequired = true
    outRigidbody.shapeType = 1
    
    return outRigidbody
end function

createBoxVertices = function(width, height)
    left = -width / 2
    right = left + width
    bottom = -height / 2
    top = bottom + height

    vertices = []
    vertices.push {"x": left, "y": top}
    vertices.push {"x": right, "y": top}
    vertices.push {"x": right, "y": bottom}
    vertices.push {"x": left, "y": bottom}

    return vertices
end function

triangulateBox = function
    return [0, 1, 2, 0, 2, 3]
end function

Rigidbody2D.getTransformVertices = function
    if self._transformUpdateRequired then
        transform = transform.create(self._position, self._rotation)
        i = 0; for v in self._vertices
            self._transformedVertices[i] = vec2.transform(v, transform)
        i += 1; end for
    end if

    return self._transformedVertices
end function

Rigidbody2D.move = function(amount)
    self._position.vec2Add amount
    self._transformUpdateRequired = true
end function

Rigidbody2D.moveTo = function(position)
    self._position = position
    self._transformUpdateRequired = true
end function

Rigidbody2D.rotate = function(amount)
    self._rotation += amount
    self._transformUpdateRequired = true
end function
///////////////////////////////////////////////////////////////////////////////
