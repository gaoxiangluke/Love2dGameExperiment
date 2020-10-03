game = {}
function game:reset()
  flagCount = BombNum
  require "selectionBox"
  require "grid"
  require 'titleBar'
  require 'timer'
  require 'difficulty'
  game.state = "selection"
  game.status = "normal"
  game.timerstart = false
  titleBar:load()
  timer:load()
  difficulty:load()
  game.second = 0
  game.baseTimer = 0
  BombNum = 0
  flagCount = BombNum
end
function game:loadgame()
  grid:load()
  selectionBox:load()
  game.state = "play"
end
function game:load()
  game:reset()
end
function game:draw()
  titleBar:draw(game.status)
  timer:draw(game.second)
  if game.state == "play" then
    grid:draw()
    selectionBox:draw()
  elseif game.state == "selection" then
    
    difficulty:draw()
  end
 -- difficulty:draw()
end
function game:update(dt)
  if (game.state == "play")then
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
end

function game:pressed(key) 
  if (game.state == "play") then
      selectionBox:pressed(key)
    if (game.status == "gameover" or game.status == "gamewin") then
      if (key == 'j') then
        game:reset()
      end
    end
  elseif (game.state == "selection") then
    local diff = difficulty:pressed(key)
    if (diff == 1) then
      BombNum = 15
      flagCount = BombNum
      game:loadgame()
    elseif (diff==2) then
      BombNum = 25
      flagCount = BombNum
      game:loadgame()
    elseif(diff==3) then
      BombNum = 35
      flagCount = BombNum
      game:loadgame()
    end
  end
end
function game:released(key)
  if (game.state == "play") then
     selectionBox:released(key)
  end
end