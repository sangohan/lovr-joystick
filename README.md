# lovr-joystick

Joystick and Gamepad input module for LÖVR

### Usage

```lua
-- Require module
lovr.joystick = require("lovr-joystick")
local draw = false

-- Draw!
function lovr.draw()
  if draw then
    lovr.graphics.print(lovr.joystick.getName(0), 0, 0, -5, 0.5)
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

- `joystick.isAvailable(id)` returns true if joystick/gamepad with id is available/present.
- `joystick.isConnected(id)` returns true if joystick/gamepad is connected, Otherwise returns false.
- `joystick.isDown(id, button)` returns true if button is hold down from joystick/gamepad with id.
- `joystick.getName(id)` returns string contains joystick/gamepad name.
- `joystick.getAxes(id)` returns array contains joystick/gamepad axes.
- `joystick.getHats(id)` returns array contains joystick/gamepad hats.
- `joystick.getGUID(id)` returns string contains GUID of the joystick/gamepad.
- `joystick.isGamepad(id)` returns true if joystick is actually gamepad.
- `joystick.updateGamepadMappings(str)` updates gamepad controls from string.
- `joystick.getGamepadName(id)` if your joystick is gamepad, This can be used to get name of gamepad.

### NOTES

1. Buttons and Joystick/Gamepad ID (index) is value from 0 (First joystick/gamepad) to 14 (Buttons), or to 15 (index).
2. Hats array and Axes array index starts from 0 (NOT 1).
3. If LÖVR throws error that says missing procedure(s), Get latest 64-bit [pre-compiled binaries of GLFW3 library](https://www.glfw.org/download.html) and replace that one in LÖVR directory with it.
4. Calling `joystick.isConnected(id)` in `lovr.update` without a way to stop or limit loop of calling `joystick.isConnected(id)` might cause callback overflow error.

### License

Check [`LICENSE.txt`](https://github.com/Rabios/lovr-joystick/blob/master/LICENSE.txt) for license.
