selectionBox = {
  x = 0,
  y = 0
}
local currentDelay = 0
local firstmove = true
local gameover = false
local firsttouch = true --if the first selection is bomb reset bomb position
function selectionBox:reset()
  require "grid"
  self.x = 0
  self.y = 0
  gameover = false
  firstmove = true
  currentDelay = 0
  firsttouch = true
end
function selectionBox:load()
  selectionBox:reset()
end

function selectionBox:update(dt)
  currentDelay = currentDelay + dt
  if love.keyboard.isDown('right') and ( firstmove == true or currentDelay > delayMax )  then 
     self.x = self.x + cellSize
     currentDelay = 0
     firstmove = false
  end
  if love.keyboard.isDown('left') and ( firstmove == true or currentDelay > delayMax ) then 
     self.x = self.x - cellSize
     currentDelay = 0
     firstmove = false
   
  end
  if love.keyboard.isDown('up') and ( firstmove == true or currentDelay > delayMax ) then 
     self.y = self.y - cellSize
     currentDelay = 0
     firstmove = false
   
  end
  if love.keyboard.isDown('down') and ( firstmove == true or currentDelay > delayMax ) then 
     self.y = self.y + cellSize
     currentDelay = 0
     firstmove = false
  end
  
  --check if box out of boundry
  if self.x < 0 then
    self.x = 0
  end
  if self.x > screenWidth - cellSize then
    self.x = screenWidth - cellSize
  end
  if self.y < 0 then
    self.y = 0
  end
   if self.y > screenHeight - cellSize then
    self.y = screenHeight - cellSize
  end
  
  selectedX = math.floor(self.x/cellSize) + 1
  selectedY = math.floor(self.y/cellSize) + 1
  if selectedX > xMax then
    selectedX = xMax
  end
  if selectedY > yMax then
    selectedY = yMax
  end
  grid:setSelected(selectedX,selectedY)
  return gameover;
end
function selectionBox:draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle('line',self.x,self.y + titleBarHeight,cellSize,cellSize)
  love.graphics.setColor(1, 1, 1)
end
function selectionBox:pressed(key)
  if ( key == 'j' and grid:isflag(selectedX,selectedY)==false) then
    if (grid:isBomb(selectedX,selectedY) and firsttouch == false) then
      gameover = true
      firsttouch = false
    elseif (grid:isBomb(selectedX,selectedY) and firsttouch == true) then
      firsttouch = false
      placeBomb(selectedX,selectedY)
    end
    firsttouch = false
    grid:uncovered(selectedX,selectedY)
  end
  if (key == 'k') then
    grid:setFlag(selectedX,selectedY)
  end
end
function selectionBox:getFirsttouch()
  return firsttouch
end
function selectionBox:released(key)
  if key == 'right' or key == 'left' or key == 'up' or key == 'down' then
    currentDelay = 0
    firstmove = true
  end
end