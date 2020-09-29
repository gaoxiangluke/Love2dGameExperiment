game = {}
function game:load()
    require "selectionBox"
    require "grid"
    game.state = "play"
    grid:load()
    selectionBox:load()
end
function game:draw()
  if game.state == "play" then
    grid:draw()
    selectionBox:draw()
  end
end
function game:update(dt)
  game.gameover = selectionBox:update(dt)
  
end
