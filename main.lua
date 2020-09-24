lovr.joystick = require("lovr-joystick")

local draw = false

function lovr.draw()
  lovr.graphics.clear()
  if draw then
    if lovr.joystick.isAvailable(0) then
      lovr.graphics.print(lovr.joystick.getName(0), 0, 0, -5, 1)
	end
  end
end

function lovr.update()
  if lovr.joystick.isDown(0, "x") then
    draw = true
  else
    draw = false
  end
end