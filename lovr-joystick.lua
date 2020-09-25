-- Written by Rabia Alhaffar in 25/September/2020
-- Joystick and Gamepad input module for LÖVR :)

-- Load FFI and check support for lovr-joystick
local ffi = assert(type(jit) == "table" and               -- Only run if we have LuaJIT
  lovr.getOS() ~= "Android" and lovr.getOS() ~= "Web" and -- and also GLFW
  require("ffi"), "lovr-joystick cannot run on this platform!")
local C = (lovr.getOS() ~= "Android" and lovr.getOS() ~= "Web") and ffi.load("glfw3") or ffi.C
local ffi_string = ffi.string  -- Cache ffi.string so it would be better for performance ;)
local bor = require("bit").bor

-- FFI C Definitions
-- NOTES: Index of arrays you get from Joystick/Gamepad functions start at 0, NOT 1!
-- The same goes for Joystick/Gamepad buttons or names.
ffi.cdef([[
    typedef struct GLFWwindow GLFWwindow;
    typedef void (* GLFWjoystickfun)(int, int);
	
    GLFWwindow* glfwGetCurrentContext(void);
    int glfwJoystickPresent(int jid);
    const float* glfwGetJoystickAxes(int jid, int* count);
    const unsigned char* glfwGetJoystickButtons(int jid, int* count);
    const char* glfwGetJoystickName(int jid);
	
    const unsigned char* glfwGetJoystickHats(int jid, int* count);
    const char* glfwGetJoystickGUID(int jid);
	
    int glfwJoystickIsGamepad(int jid);
    int glfwUpdateGamepadMappings(const char* string);
    const char* glfwGetGamepadName(int jid);
]])

local window = C.glfwGetCurrentContext()
local joystick_buttons = {
  a        = 0,
  b        = 1,
  x        = 2,
  y        = 3,
  lb       = 4,
  rb       = 5,
  back     = 6,
  start    = 7,
  guide    = 8,
  lt       = 9,
  rt       = 10,
  up       = 11,
  right    = 12,
  down     = 13,
  left     = 14
}

joystick_buttons.cross    = joystick_buttons.a
joystick_buttons.circle   = joystick_buttons.b
joystick_buttons.square   = joystick_buttons.x
joystick_buttons.triangle = joystick_buttons.y

local joystick = {}

function joystick.isAvailable(id)
  return C.glfwJoystickPresent(id) == 1
end

function joystick.isDown(id, button)
  if not id and not button then return false end
  local b = joystick_buttons[button] or button
  local c = ffi.new("int[19]")
  assert(b and type(b) == "number", "Unknown gamepad button: " .. button)
  return C.glfwGetJoystickButtons(id, c)[b] == 1
end

function joystick.getName(id)
  return ffi_string(C.glfwGetJoystickName(id))
end

function joystick.getAxes(id)
  local axes = ffi.new("int[7]")
  return C.glfwGetJoystickAxes(id, axes)
end

function joystick.getHats(id)
  local hats = ffi.new("int[10]")
  return C.glfwGetJoystickHats(id, hats)
end

function joystick.getGUID(id)
  return ffi_string(C.glfwGetJoystickGUID(id))
end

function joystick.isGamepad(id)
  return C.glfwJoystickIsGamepad(id)
end

function joystick.updateGamepadMappings(str)
  C.glfwUpdateGamepadMappings(str)
end

function joystick.getGamepadName(id)
  return ffi_string(C.glfwGetGamepadName(id))
end

return joystick