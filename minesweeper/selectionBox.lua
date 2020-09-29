selectionBox = {
  x = 0,
  y = 0
}
local currentDelay = 0
local firstmove = true
function selectionBox:load()
  require "grid"
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
  
  return false;
end
function selectionBox:draw()
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle('line',self.x,self.y,cellSize,cellSize)
  love.graphics.setColor(1, 1, 1)
end
function selectionBox:keypressed(key)
  
end

function selectionBox:keyreleased(key)
  if key == 'right' or key == 'left' or key == 'up' or key == 'down' then
    currentDelay = 0
    firstmove = true
  end
end