love.filesystem.load('libs/utils.lua')()
utils=new_utils()
love.filesystem.load('libs/acid.lua')()
acid=new_acid()
acid.update=utils.set_timer(acid.update,1/60)
love.filesystem.load('libs/object_utils.lua')()
o_utils=new_object_utils()
love.filesystem.load('libs/cellAM.lua')()



cellam1=new_cellAM(80,60)
cellam1.new_cells()
cell_rule=function(x,y)
  local sum=0
  for i=-1,1 do
    for j=-1,1 do
      sum=sum+cellam1.access_cell(x+i,y+j).status
    end
  end
  sum=sum-cellam1.access_cell(x,y).status
  if sum==3 then
    return 1
  end
  if sum==2 then
    return cellam1.access_cell(x,y).status
  end
  return 0
end
cell_print=function(s,x,y)
  if s==1 then
    R,G,B=acid.raibow(x*y/10)
    love.graphics.setColor(R,G,B)
    love.graphics.rectangle('fill',(x-1)*10,(y-1)*10,10,10)
  end
end
cellam1.next_age=utils.set_timer(cellam1.next_age,0.1)


font4banner1=love.graphics.newFont('fonts/famib.ttf',80)
font4banner2=love.graphics.newFont('fonts/famib.ttf',30)
font4normal=love.graphics.newFont('fonts/famib.ttf',80)
banner=o_utils.new_obj()
banner.isVisible=true
banner.show=function(x,y)
   love.graphics.setFont(font4banner2)
   acid.banner("test project                ",400,130)
   love.graphics.setFont(font4banner1)
   acid.banner("LIFE GAME IN LOVE2D",400,190)
end


banner2=o_utils.new_obj()
banner2.isVisible=true
banner2.isTouchable=true
str2="START!"
str1="STOP!"
toggle=true
banner2.isHit=o_utils.collision_sq(
    400-font4normal:getWidth(str1)/2,
    400+font4normal:getWidth(str1)/2,
    400-font4normal:getHeight(str1)/2,
    400+font4normal:getHeight(str1)/2)
function redsky()
  R,G,B=acid.raibow()
  Ramp=16;Rbias=239;Gamp=40;Gbias=80;Bamp=16;Bbias=19
  return (R*Ramp+Rbias)/255,(G*Gamp+Gbias)/255,(B*Bamp+Bbias)/255
end
banner2.show=function(x,y)
   if banner2.isHit(x,y) then
    if love.mouse.isDown(1) then
      acid.pop(400-font4normal:getWidth(str1)/2,
      400+font4normal:getWidth(str1)/2,
      400-font4normal:getHeight(str1)/2,
      400+font4normal:getHeight(str1)/2,1)
    else
      acid.pop(400-font4normal:getWidth(str1)/2,
      400+font4normal:getWidth(str1)/2,
      400-font4normal:getHeight(str1)/2,
      400+font4normal:getHeight(str1)/2)
    end
   end
   love.graphics.setFont(font4normal)
   acid.print(str1,400,400,0,1,1,love.graphics.getFont():getWidth(str1)/2,love.graphics.getFont():getHeight(str1)/2)
end

function banner2.released(button,x,y)
  if button==1 then
    toggle=not toggle
    tmp=str1
    str1=str2
    str2=tmp
  end
end


lyr=o_utils.new_layer()
lyr.insert(banner2)
lyr.insert(banner)



cellam1.access_cell(3,3).status=1
cellam1.access_cell(2,3).status=1
cellam1.access_cell(1,3).status=1
cellam1.access_cell(3,2).status=1
cellam1.access_cell(2,1).status=1
--updates drawer and updater
utils.update_draw(function()
  cellam1.show(cell_print)
  lyr.show(utils.getMouseX(),utils.getMouseY())
  love.graphics.setBackgroundColor(redsky())
end)

utils.update_update(function()
  if love.mouse.isDown(1) then
    cellam1.access_cell(math.floor(1+utils.getMouseX()/10),math.floor(1+utils.getMouseY()/10)).status=1
  end
  if love.mouse.isDown(2) then
    cellam1.access_cell(math.floor(1+utils.getMouseX()/10),math.floor(1+utils.getMouseY()/10)).status=0
  end
  if toggle==true then
    cellam1.access_cell(-1,-1).status=0
    cellam1.next_age(cell_rule)
  end
  acid.update()
  function love.mousereleased(x,y,button,istouch)
    lyr.released(button,utils.getMouseX(),utils.getMouseY())
  end
end)
