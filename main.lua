lovr.joystick = require("lovr-joystick")
local draw = false

function lovr.draw()
  if draw then
    lovr.graphics.print(lovr.joystick.getName(0), 0, 0, -5, 0.5)
  end
end

function lovr.update()
  if lovr.joystick.isAvailable(0) then
    draw = lovr.joystick.isDown(0, "x")
  end
end
