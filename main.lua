function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setMode(800, 600, {resizable=true, vsync=false})
    love.window.originalScale={}
    love.window.originalScale.x=love.graphics.getWidth()
    love.window.originalScale.y=love.graphics.getHeight()


end
--dofile('./title.lua')
love.filesystem.load("title.lua")()
