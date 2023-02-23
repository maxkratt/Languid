// Adds various methods for working with 2-Dimensional Vectors
// They are just maps with an x and a y.


// Creation ///////////////////////////////////////////////////////////////////
create = function(x = 0, y = 0)
    return {"x": x, "y": y}
end function

map.vec2Copy = function()
    return {"x": self.x, "y": self.y}
end function
///////////////////////////////////////////////////////////////////////////////

// Addition ///////////////////////////////////////////////////////////////////
map.vec2Add = function(vectorAddend)
    self.x += vectorAddend.x
    self.y += vectorAddend.y
    return self
end function

map.vec2AddNew = function(vectorAddend)
    return {"x": self.x + vectorAddend.x, "y": self.y + vectorAddend.y}
end function

map.vec2AddScaler = function(addend)
    self.x += addend
    self.y += addend
    return self
end function

map.vec2AddScalerNew = function(addend)
    return {"x": self.x + addend, "y": self.y + addend}
end function
///////////////////////////////////////////////////////////////////////////////

// Subtraction ////////////////////////////////////////////////////////////////
map.vec2Sub = function(vectorSubtrahend)
    self.x -= vectorSubtrahend.x
    self.y -= vectorSubtrahend.y
    return self
end function

map.vec2SubNew = function(vectorSubtrahend)
    return {"x": self.x - vectorSubtrahend.x, "y": self.y - vectorSubtrahend.y}
end function

map.vec2SubScaler = function(subtrahend)
    self.x -= subtrahend
    self.y -= subtrahend
    return self
end function

map.vec2SubScalerNew = function(subtrahend)
    return {"x": self.x - subtrahend, "y": self.y - subtrahend}
end function

map.vec2Invert = function()
    self.x = -self.x
    self.y = -self.y
    return self
end function

map.vec2InvertNew = function()
return {"x": -self.x, "y": -self.y}
end function
///////////////////////////////////////////////////////////////////////////////

// Multiplication /////////////////////////////////////////////////////////////
map.vec2Mul = function(multiplier)
    self.x *= multiplier.x
    self.y *= multiplier.y
    return self
end function

map.vec2MulNew = function(multiplier)
    return {"x": self.x * multiplier.x, "y": self.y * multiplier.y}
end function

map.vec2MulScaler = function(multiplier)
    self.x *= multiplier
    self.y *= multiplier
    return self
end function

map.vec2MulScalerNew = function(multiplier)
    return {"x": self.x * multiplier, "y": self.y * multiplier}
end function

map.vec2Dot = function(other)
    return self.x * other.x + self.y + other.y
end function

map.vec2Cross = function(other)
    return self.x * other.y - self.y * other.x
end function
///////////////////////////////////////////////////////////////////////////////

// Division ///////////////////////////////////////////////////////////////////
map.vec2Div = function(divisor)
    self.x /= divisor.x
    self.y /= divisor.y
    return self
end function

map.vec2DivNew = function(divisor)
    return {"x": self.x / divisor.x, "y": self.y / divisor.y}
end function

map.vec2DivScaler = function(divisor)
    self.x /= divisor
    self.y /= divisor
    return self
end function

map.vec2DivScalerNew = function(divisor)
    return {"x": self.x / divisor, "y": self.y / divisor}
end function
///////////////////////////////////////////////////////////////////////////////

// Magnitude //////////////////////////////////////////////////////////////////
map.vec2Length = function
    return sqrt(self.x ^ 2 + self.y ^ 2)
end function

map.vec2LengthSquared = function
    return self.x ^ 2 + self.y ^ 2
end function

map.vec2Normalize = function
    if self.x == 0 and self.y == 0 then return

    length = self.vec2Length
    self.x /= length
    self.y /= length
    return self
end function

map.vec2Normalized = function
    if self.x == 0 and self.y == 0 then return {"x": 0, "y": 0}
    
    length = self.vec2Length
    return {"x": self.x / length, "y": self.y / length}
end function

map.vec2Distance = function(toVector)
    dx = self.x - toVector.x
    dy = self.y - toVector.y
    return sqrt(dx ^ 2 + dy ^ 2)
end function

distance = function(vector1, vector2)
    dx = vector1.x - vector2.x
    dy = vector1.y - vector2.y
    return sqrt(dx ^ 2 + dy ^ 2)
end function
///////////////////////////////////////////////////////////////////////////////