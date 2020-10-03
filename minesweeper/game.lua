game = {}
function game:reset()
  flagCount = BombNum
  require "selectionBox"
  require "grid"
  require 'titleBar'
  require 'timer'
  game.state = "play"
  game.status = "normal"
  game.timerstart = false
  grid:load()
  selectionBox:load()
  titleBar:load()
  timer:load()
  game.second = 0
  game.baseTimer = 0
  BombNum = love.math.random(28,38)
  flagCount = BombNum
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
  timer:draw(game.second)
end
function game:update(dt)
  if (selectionBox:getFirsttouch() == false and game.timerstart == false) then
    game.timerstart = true
  end
  if (game.timerstart == true) then
    game.baseTimer = game.baseTimer + dt
    if game.baseTimer > 1 then
      game.baseTimer = game.baseTimer - 1
      game.second = game.second + 1
    end
  end

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