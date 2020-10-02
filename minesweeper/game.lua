game = {}
function game:reset()
  flagCount = BombNum
  require "selectionBox"
  require "grid"
  require 'titleBar'
  game.state = "play"
  game.status = "normal"
  grid:load()
  selectionBox:load()
  titleBar:load()
  flagCount = 99
end
function game:load()
  game:reset()
end
function game:draw()
  
  if game.state == "play" then
    grid:draw()
    selectionBox:draw()
  end
  titleBar:draw(game.status)
end
function game:update(dt)
  if game.status == "normal" then
    if selectionBox:update(dt) then
      game.status = "gameover"
    elseif grid:checkifGameWin() then
      game.status = "gamewin"
    else 
      game.status = "normal"
    end
  end
  if (game.status == "gameover" or game.status == "gamewin") then
    grid:revealgrid()
  end
end

function game:pressed(key) 
  if (game.status == "gameover" or game.status == "gamewin") then
    if (key == 'j') then
      game:reset()
    end
  end
end