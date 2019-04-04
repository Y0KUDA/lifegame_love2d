function new_clicker(f,g)
  local ret={}
  local avairable=true
  function ret.isAvairable()
    return avairable
  end
  function ret.disable()
    avairable=false
  end
  ret.isHit=g
  ret.click=f
  return ret
end

function new_clicker_sq(f,x1,x2,y1,y2)  --x in x1 to x2 and y in y1 to y2
  return new_clicker(f,function(x,y)return x<x2 and x>x1 and y<y2 and y>y1 end)
end

function new_clicker_cir(f,x1,y2,r)
  return new_clicker(f,function(x,y)return (x-x1)^2+(y-y1)^2 <= r^2 end)
end

function new_click_event_layer()
  ret={}
  list={}
  function ret.click(x,y)
    for i,j in pairs(list) do
      if j.isHit(x,y) then
        j.click(x,y)
        return i
      end
    end
  end

  function ret.remove(i)
    table.remove(list,i)
  end
  function ret.insert(i,node)
    table.insert(list,i,node)
  end
  function ret.insert(node)
    table.insert(list,node)
  end
  return ret
end
