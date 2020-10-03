
function love.load()
  require "game"
  game:load()
end

function love.keypressed(key)
  selectionBox:pressed(key)
  game:pressed(key)
  if key == 'escape' then 
    love.event.quit()
  end
end




function love.keyreleased(key) 
   selectionBox:released(key)
end
    
function love.update(dt)
 game:update(dt)
end
function love.draw() 
  game.draw()
end

      