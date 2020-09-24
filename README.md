# lovr-joystick

Joystick and Gamepad input module for LÖVR!

### Usage

```lua
-- Require module (Copy lovr-joystick.lua)
lovr.joystick = require("lovr-joystick")
local draw = false

-- Draw!
function lovr.draw()
  if draw then
    lovr.graphics.print(lovr.joystick.getName(0), 0, 0, -5, 1)
  end
end

-- Update!
function lovr.update()
  -- If joystick with index 0 (First joystick) is available and x button pressed then
  -- draw text contains first joystick name!
  if lovr.joystick.isAvailable(0) then
    if lovr.joystick.isDown(0, "x") then
      draw = true
    else
      draw = false
    end
  end
end
```

### API

- `joystick.isAvailable(id)` returns true if joystick/gamepad with id is available.
- `joystick.isDown(id, button)` returns true if button is hold down from joystick/gamepad with id.
- `joystick.getName(id)` returns string contains joystick/gamepad name.
- `joystick.getAxes(id)` returns array contains joystick/gamepad axes.

### NOTES

1. Buttons and Joystick/Gamepad ID (index) is value from 0 (First joystick/gamepad) to 14 (Buttons), or to 15 (index).
2. Hats array and Axes array index starts from 0 (NOT 1).
3. Unsupported stuff (functions) by GLFW version that LÖVR uses is commented, That's in case you updated the GLFW library by replace.

### License

Check [`LICENSE.txt`](https://github.com/Rabios/lovr-joystick/blob/master/LICENSE.txt) for license.
