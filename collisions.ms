intersectCircles = function(centerA, radiusA, centerB, radiusB, outNormal, outDepth)
    distance = vec2.distance(centerA, centerB)
    radii = radiusA + radiusB

    if distance >= radii then return false
    if outNormal isa list then outNormal.push(centerB.vec2SubNew(centerA).vec2Normalize)
    if outDepth isa list then outDepth.push(radii - distance)

    return true
end function