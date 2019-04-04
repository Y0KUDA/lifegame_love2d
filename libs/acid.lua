--use table, more visibility
function new_acid()
  local ctr=0
  local ret={}

  function ret.raibow(...)
    i=...
    if(i == nil)then i=0 else i=... end
    return (math.sin((ctr+i)/31)+1)*127,(math.sin((ctr+i)/51)+1)*127,(math.sin((ctr+i)/41)+1)*127
  end
  function ret.update()
    ctr=ctr+1
  end
  function ret.print(str,x,y,...)
    love.graphics.setColor(ret.raibow())
    love.graphics.print(str, x+3,y+3,...)
    love.graphics.setColor(255,255,255)
    love.graphics.print(str, x+(math.sin(ctr/17)-0.8)*2,y+(math.sin(ctr/17)-0.8)*2,...)
  end

  function ret.printf(str,x,y,...)
    love.graphics.setColor(ret.raibow())
    love.graphics.printf(str, x+3,y+3,...)
    love.graphics.setColor(255,255,255)
    love.graphics.printf(str,x+math.sin(ctr/17)+1,y+math.sin(ctr/17)+1,...)
  end

  function ret.banner(str,x,y,r,sx,sy,ox,oy,kx,ky)
    centerX=love.graphics.getFont():getWidth(str)/2
    centerY=love.graphics.getFont():getHeight(str)/2
    amp=0.1
    sway=ctr/40
    df=ctr/30
    distance=(1+math.sin(df)+2)*0.2
    dir=ctr/45
    vectorX=math.cos(dir)
    vectorY=math.sin(dir)
    layer=20
    for i=0,layer-1 do
      love.graphics.setColor(ret.raibow(10*i))
      --R,G,B=ret.raibow(10*i)
      --love.graphics.setColor(R,G,B,10)
      love.graphics.print(str,x+vectorX*i*distance,y+vectorY*i*distance,math.sin(sway)*amp+(r or 0),1,1,centerX,centerY)
    end
    --love.graphics.setColor(255,255,255)
    --love.graphics.print(str,x+vectorX*layer*distance,y+vectorY*layer*distance,math.sin(sway)*amp,1,1,centerX,centerY)
  end

  function ret.pop(x1,x2,y1,y2,t)
    t=t or 5
    love.graphics.setColor(0,0,0,100)
    --love.graphics.polygon('fill',x2,y1,x2,y2,x1,y2,x1+t,y2+t,x2+t,y2+t,x2+t,y1+t)
    love.graphics.polygon('fill',x2,y2,x1,y2,x1+t,y2+t,x2+t,y2+t)
    love.graphics.polygon('fill',x2,y1,x2,y2,x2+t,y2+t,x2+t,y1+t)
    love.graphics.line(x1,y2,x1,y1,x2,y1)
  end


  return ret
end
