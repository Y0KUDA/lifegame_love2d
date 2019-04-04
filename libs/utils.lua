function new_utils()
  local scale={x=1,y=1}
  local ret={}
  function ret.set_timer(f,t)
     local timer=0
     return function(...)
        if timer < love.timer.getTime() then
           f(...)
           timer=love.timer.getTime()+t
        end
     end
  end

  function ret.update_draw(f)
    function love.draw()
     love.graphics.push()
     love.graphics.scale(scale.x,scale.y)
     f()
     love.graphics.pop()
    end
  end

  local update_scale=ret.set_timer(function()
      scale.x=love.graphics.getWidth()/love.window.originalScale.x
      scale.y=love.graphics.getHeight()/love.window.originalScale.y
    end,1/60)

  function ret.update_update(f)
    function love.update(dt)
      update_scale()
      f()
    end
  end

  function ret.getTime()
    return love.timer.getTime()
  end

  function ret.getMouseX()
    return love.mouse.getX()/scale.x
  end

  function ret.getMouseY()
    return love.mouse.getY()/scale.y
  end

  return ret
end
