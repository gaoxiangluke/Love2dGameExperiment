timer = {}
function timer:load()
  local timerBoxWidth = 54
  local timerBoxHeight = 36
  local timerPositionX= 15
  local timerPositionY= 15
end

function timer:update()
end

function timer:draw()
  
   love.graphics.setColor(/255, /255, /255)
  love.graphics.rectangle('fill',timerPositionX,0,screenWidth,titleBarHeight)
  love.graphics.setColor(1, 1, 1)
end