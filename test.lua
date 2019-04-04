ctr=0
inc = set_timer(function() ctr=ctr+1 end,1)
update_draw(function()
   love.graphics.print(time, 50, 100)
   love.graphics.print(ctr, 50, 150)
   love.graphics.print("Scaled text", 50, 50)
end)

update_update(function()
   inc()

   if love.keyboard.isDown("a") then
      function love.draw()
         love.graphics.push()
         love.graphics.scale(scale.x,scale.y)

         love.graphics.print("Scaled text", 50, 50)
         love.graphics.pop()
      end
   end
end)
