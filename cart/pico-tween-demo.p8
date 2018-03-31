pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

------------
-- PICO-Tween -
-- A small library of tweening/easing
-- functions for use in the PICO-8
-- fantasy console, inspired by Robert
-- Penner's easing functions.
-- Code ported from EmmanuelOga's
-- Lua port of the easing functions.
-- Adapted to work with the PICO-8's
-- math functionality.
--
-- For all easing functions:
-- 
-- t = elapsed time
-- 
-- b = begin
-- 
-- c = change == ending - beginning
-- 
-- d = duration (total time)
--
-- For visual represenations of
-- easing functions, visit this
-- website: http://easings.net/
-- @script PICO-Tween
-- @author Joeb Rogers
-- @license MIT
-- @copyright Joeb Rogers 2018

--- Definition of Pi.
pi = 3.14

--- Cos now uses radians
cos1 = cos function cos(angle) return cos1(angle/(3.1415*2)) end
--- Sin now uses radians
sin1 = sin function sin(angle) return sin1(-angle/(3.1415*2)) end

--- Function for calculating 
-- exponents to a higher degree
-- of accuracy than using the
-- ^ operator.
-- Function created by samhocevar.
-- Source: https://www.lexaloffle.com/bbs/?tid=27864
-- @param x Number to apply exponent to.
-- @param a Exponent to apply.
-- @return The result of the 
-- calculation.
function pow(x,a)
  if (a==0) return 1
  if (a<0) x,a=1/x,-a
  local ret,a0,xn=1,flr(a),x
  a-=a0
  while a0>=1 do
      if (a0%2>=1) ret*=xn
      xn,a0=xn*xn,shr(a0,1)
  end
  while a>0 do
      while a<1 do x,a=sqrt(x),a+a end
      ret,a=ret*x,a-1
  end
  return ret
end

function linear(t, b, c, d)
  return c * t / d + b
end

function inQuad(t, b, c, d)
  return c * pow(t / d, 2) + b
end

function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end

function inOutQuad(t, b, c, d)
  t = t / d * 2
  if (t < 1) return c / 2 * pow(t, 2) + b
  return -c / 2 * ((t - 1) * (t - 3) - 1) + b  
end

function outInQuad(t, b, c, d)
  if (t < d / 2) return outQuad(t * 2, b, c / 2, d)
  return inQuad((t * 2) - d, b + c / 2, c / 2, d)
end

function inCubic(t, b, c, d)
  return c * pow(t / d, 3) + b
end

function outCubic(t, b, c, d)
  return c * (pow(t / d - 1, 3) + 1) + b
end

function inOutCubic(t, b, c, d)
  t = t / d * 2
  if (t < 1) return c / 2 * t * t * t + b
  t = t - 2
  return c / 2 * (t * t * t + 2) + b
end

function outInCubic(t, b, c, d)
  if (t < d / 2) return outCubic(t * 2, b, c / 2, d)
  return inCubic((t * 2) - d, b + c / 2, c / 2, d)
end

function inQuart(t, b, c, d)
  return c * pow(t/d, 4) + b
end

function outQuart(t, b, c, d)
  return -c * (pow(t / d - 1, 4) - 1) + b
end

function inOutQuart(t, b, c, d)
  t = t / d * 2
  if (t < 1) return c / 2 * pow(t, 4) + b
  t = t - 2
  return -c / 2 * (pow(t, 4) - 2) + b
end

function outInQuart(t, b, c, d)
  if (t < d / 2) return outQuart(t * 2, b, c / 2, d)
  return inQuart((t * 2) - d, b + c / 2, c / 2, d)
end

function inQuint(t, b, c, d)
  return c * pow(t / d, 5) + b
end

function outQuint(t, b, c, d)
  return c * (pow(t / d - 1, 5) + 1) + b
end

function inOutQuint(t, b, c, d)
  t = t / d * 2
  if (t < 1) return c / 2 * pow(t, 5) + b
  return c / 2 * (pow(t - 2, 5) + 2) + b
end

function outInQuint(t, b, c, d)
  if (t < d / 2) return outQuint(t * 2, b, c / 2, d)
  return inQuint((t * 2) - d, b + c / 2, c / 2, d)
end

function inSine(t, b, c, d)
  return -c * cos(t / d * (pi / 2)) + c + b
end

function outSine(t, b, c, d)
  return c * sin(t / d * (pi / 2)) + b
end

function inOutSine(t, b, c, d)
  return -c / 2 * (cos(pi * t / d) - 1) + b
end

function outInSine(t, b, c, d)
  if (t < d / 2) return outSine(t * 2, b, c / 2, d)
  return inSine((t * 2) - d, b + c / 2, c / 2, d)
end

function inExpo(t, b, c, d)
  if (t == 0) return b
  return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
end

function outExpo(t, b, c, d)
  if (t == d) return b + c
  return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
end

function inOutExpo(t, b, c, d)
  if (t == 0) return b
  if (t == d) return b + c
  t = t / d * 2
  if (t < 1) return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
  return c / 2 * 1.0005 * (-pow(2, -10 * (t - 1)) + 2) + b
end

function outInExpo(t, b, c, d)
  if (t < d / 2) return outExpo(t * 2, b, c / 2, d)
  return inExpo((t * 2) - d, b + c / 2, c / 2, d)
end

function inCirc(t, b, c, d)
  return (-c * (sqrt(1 - pow(t / d, 2)) - 1) + b)
end

function outCirc(t, b, c, d)
  return (c * sqrt(1 - pow(t / d - 1, 2)) + b)
end

function inOutCirc(t, b, c, d)
  t = t / d * 2
  if (t < 1) return -c / 2 * (sqrt(1 - t * t) - 1) + b
  t = t - 2
  return c / 2 * (sqrt(1 - t * t) + 1) + b
end

function outInCirc(t, b, c, d)
  if (t < d / 2) return outCirc(t * 2, b, c / 2, d)
  return inCirc((t * 2) - d, b + c / 2, c / 2, d)
end

function inBack(t, b, c, d, s)
  s = s or 1.70158
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end

function outBack(t, b, c, d, s)
  s = s or 1.70158
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function inOutBack(t, b, c, d, s)
  s = s or 1.70158
  s = s * 1.525
  t = t / d * 2
  if (t < 1) return c / 2 * (t * t * ((s + 1) * t - s)) + b
  t = t - 2
  return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
end

function outInBack(t, b, c, d, s)
  if (t < d / 2) return outBack(t * 2, b, c / 2, d, s)
  return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
end

function outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then
    return c * (7.5625 * t * t) + b
  elseif t < 2 / 2.75 then
    t = t - (1.5 / 2.75)
    return c * (7.5625 * t * t + 0.75) + b
  elseif t < 2.5 / 2.75 then
    t = t - (2.25 / 2.75)
    return c * (7.5625 * t * t + 0.9375) + b
  end
  t = t - (2.625 / 2.75)
  return c * (7.5625 * t * t + 0.984375) + b
end

function inBounce(t, b, c, d)
  return c - outBounce(d - t, 0, c, d) + b
end

function inOutBounce(t, b, c, d)
  if (t < d / 2) return inBounce(t * 2, 0, c, d) * 0.5 + b
  return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
end

function outInBounce(t, b, c, d)
  if (t < d / 2) return outBounce(t * 2, b, c / 2, d)
  return inBounce((t * 2) - d, b + c / 2, c / 2, d)
end

--------
-- Tween List and Names
--------

tweenList = {
  linear,
  inQuad,
  outQuad,
  inOutQuad,
  outInQuad,
  inCubic,
  outCubic,
  inOutCubic,
  outInCubic,
  inQuart,
  outQuart,
  inOutQuart,
  outInQuart,
  inQuint,
  outQuint,
  inOutQuint,
  outInQuint,
  inSine,
  outSine,
  inOutSine,
  outInSine,
  inExpo,
  outExpo,
  inOutExpo,
  outInExpo,
  inCirc,
  outCirc,
  inOutCirc,
  outInCirc,
  inBack,
  outBack,
  inOutBack,
  outInBack,
  inBounce,
  outBounce,
  inOutBounce,
  outInBounce,
}

tweenNames = {
  "linear",
  "inQuad",
  "outQuad",
  "inOutQuad",
  "outInQuad",
  "inCubic",
  "outCubic",
  "inOutCubic",
  "outInCubic",
  "inQuart",
  "outQuart",
  "inOutQuart",
  "outInQuart",
  "inQuint",
  "outQuint",
  "inOutQuint",
  "outInQuint",
  "inSine",
  "outSine",
  "inOutSine",
  "outInSine",
  "inExpo",
  "outExpo",
  "inOutExpo",
  "outInExpo",
  "inCirc",
  "outCirc",
  "inOutCirc",
  "outInCirc",
  "inBack",
  "outBack",
  "inOutBack",
  "outInBack",
  "inBounce",
  "outBounce",
  "inOutBounce",
  "outInBounce",
}

--------
-- Main
--------

distance = 50
duration = 1
index = 1
func = tweenList[index]

function downFunc(v)
  return func(v, 0, distance, duration)
end

function upFunc(v)
  return func(v, distance, -distance, duration)
end

local easeProp = 0
local timeElapsed = 0
local currentFunc = downFunc
local lastTime = time()
local dt = 0

function _update()
  t = time()
  dt = t - lastTime
  lastTime = t
  timeElapsed += dt

  if btnp(0) then
    easeProp = 0
    timeElapsed = 0
    index -= 1
    if index <= 0 then
      index = #tweenList
    end
    func = tweenList[index]
  elseif btnp(1) then
    easeProp = 0
    timeElapsed = 0
    index += 1
    if index > #tweenList then
      index = 1
    end
    func = tweenList[index]
  end

  if timeElapsed > duration then
    timeElapsed = 0
    if currentFunc == downFunc then currentFunc = upFunc else currentFunc = downFunc end
  end

  easeProp = currentFunc(timeElapsed)
end

function _draw()
  rectfill(0, 0, 128, 128, 3)
  circfill(64, 40 + easeProp, 20, 15)
  print("Function: "..tweenNames[index], 5, 120)
  print("", 120, 120)
  print("⬅️ ➡️", 100, 120)
end