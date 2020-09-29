
function love.load()
  require "game"
  game:load()
end

function love.keypressed(key)
  
end




function love.keyreleased(key) 
  
end
    
function love.update(dt)
 game:update(dt)
end
function love.draw() 
  game.draw()
end

      