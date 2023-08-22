-- This script was originally written in TypeScript.
pow = function(x, y) return x ^ y end
sqrt = math.sqrt
sin = math.sin
cos = math.cos
PI = math.pi
c1 = 1.70158
c2 = c1 * 1.525
c3 = c1 + 1
c4 = 2 * PI / 3
c5 = 2 * PI / 4.5
bounceOut = function(x)
    local n1 = 7.5625
    local d1 = 2.75
    if x < 1 / d1 then
        return n1 * x * x
    elseif x < 2 / d1 then
        x = x - 1.5 / d1
        return n1 * x * x + 0.75
    elseif x < 2.5 / d1 then
        x = x - 2.25 / d1
        return n1 * x * x + 0.9375
    else
        x = x - 2.625 / d1
        return n1 * x * x + 0.984375
    end
end
--- SOURCE: https://github.com/ai/easings.net/blob/master/src/easings/easingsFunctions.ts
easingsFunctions = {
    linear = function(x) return x end,
    easeInQuad = function(x)
        return x * x
    end,
    easeOutQuad = function(x)
        return 1 - (1 - x) * (1 - x)
    end,
    easeInOutQuad = function(x)
        return x < 0.5 and 2 * x * x or 1 - pow(-2 * x + 2, 2) / 2
    end,
    easeInCubic = function(x)
        return x * x * x
    end,
    easeOutCubic = function(x)
        return 1 - pow(1 - x, 3)
    end,
    easeInOutCubic = function(x)
        return x < 0.5 and 4 * x * x * x or 1 - pow(-2 * x + 2, 3) / 2
    end,
    easeInQuart = function(x)
        return x * x * x * x
    end,
    easeOutQuart = function(x)
        return 1 - pow(1 - x, 4)
    end,
    easeInOutQuart = function(x)
        return x < 0.5 and 8 * x * x * x * x or 1 - pow(-2 * x + 2, 4) / 2
    end,
    easeInQuint = function(x)
        return x * x * x * x * x
    end,
    easeOutQuint = function(x)
        return 1 - pow(1 - x, 5)
    end,
    easeInOutQuint = function(x)
        return x < 0.5 and 16 * x * x * x * x * x or 1 - pow(-2 * x + 2, 5) / 2
    end,
    easeInSine = function(x)
        return 1 - cos(x * PI / 2)
    end,
    easeOutSine = function(x)
        return sin(x * PI / 2)
    end,
    easeInOutSine = function(x)
        return -(cos(PI * x) - 1) / 2
    end,
    easeInExpo = function(x)
        return x == 0 and 0 or pow(2, 10 * x - 10)
    end,
    easeOutExpo = function(x)
        return x == 1 and 1 or 1 - pow(2, -10 * x)
    end,
    easeInOutExpo = function(x)
        return x == 0 and 0 or (x == 1 and 1 or (x < 0.5 and pow(2, 20 * x - 10) / 2 or (2 - pow(2, -20 * x + 10)) / 2))
    end,
    easeInCirc = function(x)
        return 1 - sqrt(1 - pow(x, 2))
    end,
    easeOutCirc = function(x)
        return sqrt(1 - pow(x - 1, 2))
    end,
    easeInOutCirc = function(x)
        return x < 0.5 and (1 - sqrt(1 - pow(2 * x, 2))) / 2 or (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2
    end,
    easeInBack = function(x)
        return c3 * x * x * x - c1 * x * x
    end,
    easeOutBack = function(x)
        return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2)
    end,
    easeInOutBack = function(x)
        return x < 0.5 and pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2) / 2 or (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2
    end,
    easeInElastic = function(x)
        return x == 0 and 0 or (x == 1 and 1 or -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4))
    end,
    easeOutElastic = function(x)
        return x == 0 and 0 or (x == 1 and 1 or pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1)
    end,
    easeInOutElastic = function(x)
        return x == 0 and 0 or (x == 1 and 1 or (x < 0.5 and -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2 or pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5) / 2 + 1))
    end,
    easeInBounce = function(x)
        return 1 - bounceOut(1 - x)
    end,
    easeOutBounce = bounceOut,
    easeInOutBounce = function(x)
        return x < 0.5 and (1 - bounceOut(1 - 2 * x)) / 2 or (1 + bounceOut(2 * x - 1)) / 2
    end
}
function interpolate(a, b, time, func)
    if type(func) == "string" then
        func = easingsFunctions[func]
    end
    return a + (b - a) * func(time)
end
