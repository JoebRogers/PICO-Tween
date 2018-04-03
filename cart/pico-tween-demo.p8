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

--- Implementation of asin.
-- Source converted from 
-- http://developer.download.nvidia.com/cg/asin.html
function asin(x)
  local negate = (x < 0 and 1.0 or 0.0)
  x = abs(x)
  local ret = -0.0187293
  ret *= x
  ret += 0.0742610
  ret *= x
  ret -= 0.2121144
  ret *= x
  ret += 1.5707288
  ret = 3.14159265358979*0.5 - sqrt(1.0 - x)*ret
  return ret - 2 * negate * ret
end

--- Implementation of acos.
-- Source converted from 
-- http://developer.download.nvidia.com/cg/acos.html
function acos(x)
  local negate = (x < 0 and 1.0 or 0.0)
  x = abs(x);
  local ret = -0.0187293;
  ret *= x;
  ret += 0.0742610;
  ret *= x;
  ret -= 0.2121144;
  ret *= x;
  ret += 1.5707288;
  ret *= sqrt(1.0-x);
  ret -= 2 * negate * ret;
  return negate * 3.14159265358979 + ret;
end

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

function inElastic(t, b, c, d, a, p)
  if (t == 0) return b
  t /= d
  if (t == 1) return b + c
  p = p or d * 0.3
  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  t -= 1
  return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

function outElastic(t, b, c, d, a, p)
  if (t == 0) return b
  t /= d
  if (t == 1) return b + c
  p = p or d * 0.3
  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end

  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

function inOutElastic(t, b, c, d, a, p)
  if (t == 0) return b
  t = t / d * 2
  if (t == 2) return b + c
  p = p or d * (0.3 * 1.5)
  a = a or 0
  local s

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c / a)
  end

  if t < 1 then
    t -= 1
    return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
  end
  t -= 1
  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
end

function outInElastic(t, b, c, d, a, p)
  if (t < d / 2) return outElastic(t * 2, b, c / 2, d, a, p)
  return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
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
-- tween list and names
--------

tweenlist = {
  linear,
  inquad,
  outquad,
  inoutquad,
  outinquad,
  incubic,
  outcubic,
  inoutcubic,
  outincubic,
  inquart,
  outquart,
  inoutquart,
  outinquart,
  inquint,
  outquint,
  inoutquint,
  outinquint,
  insine,
  outsine,
  inoutsine,
  outinsine,
  inexpo,
  outexpo,
  inoutexpo,
  outinexpo,
  incirc,
  outcirc,
  inoutcirc,
  outincirc,
  inelastic,
  outelastic,
  inoutelastic,
  outinelastic,
  inback,
  outback,
  inoutback,
  outinback,
  inbounce,
  outbounce,
  inoutbounce,
  outinbounce,
}

tweennames = {
  "linear",
  "inquad",
  "outquad",
  "inoutquad",
  "outinquad",
  "incubic",
  "outcubic",
  "inoutcubic",
  "outincubic",
  "inquart",
  "outquart",
  "inoutquart",
  "outinquart",
  "inquint",
  "outquint",
  "inoutquint",
  "outinquint",
  "insine",
  "outsine",
  "inoutsine",
  "outinsine",
  "inexpo",
  "outexpo",
  "inoutexpo",
  "outinexpo",
  "incirc",
  "outcirc",
  "inoutcirc",
  "outincirc",
  "inelastic",
  "outelastic",
  "inoutelastic",
  "outinelastic",
  "inback",
  "outback",
  "inoutback",
  "outinback",
  "inbounce",
  "outbounce",
  "inoutbounce",
  "outinbounce",
}

--------
-- main
--------

distance = 50
duration = 1
index = 1
func = tweenlist[index]

function downfunc(v)
  return func(v, 0, distance, duration)
end

function upfunc(v)
  return func(v, distance, -distance, duration)
end

local easeprop = 0
local timeelapsed = 0
local currentfunc = downfunc
local lasttime = time()
local dt = 0

function _update()
  t = time()
  dt = t - lasttime
  lasttime = t
  timeelapsed += dt

  if btnp(0) then
    easeprop = 0
    timeelapsed = 0
    index -= 1
    if index <= 0 then
      index = #tweenlist
    end
    func = tweenlist[index]
  elseif btnp(1) then
    easeprop = 0
    timeelapsed = 0
    index += 1
    if index > #tweenlist then
      index = 1
    end
    func = tweenlist[index]
  end

  if timeelapsed > duration then
    timeelapsed = 0
    if currentfunc == downfunc then currentfunc = upfunc else currentfunc = downfunc end
  end

  easeprop = currentfunc(timeelapsed)
end

function _draw()
  rectfill(0, 0, 128, 128, 3)
  circfill(64, 40 + easeprop, 20, 15)
  print("function: "..tweennames[index], 5, 120)
  print("⬅️ ➡️", 100, 120)
end
