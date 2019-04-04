function new_object_utils()
  local ret={}
  function ret.new_obj()
    local ret={}
    ret.isTouchable=false
    function ret.isHit(mouseX,mouseY)return false end
    function ret.pressed(button,mouseX,mouseY)end
    function ret.released(button,mouseX,mouseY)end

    ret.isVisible=false
    --ret.isCatchable=false --object sees collision
    --function hasMouse(mouseX,mouseY)end --who object has mouse?
    --these function are lilbit heavy ...
    function ret.show(mouseX,mouseY)end
    return ret
  end

  function ret.new_layer() --this can be replaced with stage by lua code if event is called only click
    local ret={}
    local list={}
    function ret.pressed(button,x,y)
      for i,j in pairs(list) do
        if j.isTouchable and j.isHit(x,y) then
          j.pressed(button,x,y)
          return i
        end
      end
    end

    function ret.released(button,x,y)
      for i,j in pairs(list) do
        if j.isTouchable and j.isHit(x,y) then
          j.released(button,x,y)
          return i
        end
      end
    end

    function ret.show(x,y)
      for i,j in pairs(list) do
        if j.isVisible then
          j.show(x,y)
        end
      end
    end

    function ret.remove(i)
      table.remove(list,i)
    end

    function ret.insert(node,...)
      i=...
      table.insert(list,i or 1,node)
    end
    return ret
  end


  function ret.collision_sq(x1,x2,y1,y2)
    return function(x,y)
      --love.graphics.setColor(1,0,0,1)  ---visualize collisions
      --love.graphics.rectangle('fill',x1,y1,x2-x1,y2-y1) ---
      return x>=x1 and x<=x2 and y>=y1 and y<=y2
    end
  end


  function ret.collision_cir(r,x1,y1)
    return function(x,y)
      return (x-x1)^2+(y-y1)^2 <= r^2
    end
  end

  return ret
end
