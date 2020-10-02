titleBar = {}
function titleBar:load()
   titleBar.images = {}
   titleBar.images["sad"] = love.graphics.newImage('image/sad.png')
   titleBar.images["cool"] = love.graphics.newImage('image/cool.png')
   titleBar.images["happy"] = love.graphics.newImage('image/happy.png')
end

function titleBar:update()
end
function titleBar:drawface(image)
  --draw face 
  local boxSize = 32
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle('line',screenWidth/2-1/2*boxSize,titleBarHeight/2-1/2*boxSize,boxSize,boxSize)
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(image, screenWidth/2-1/2*boxSize,titleBarHeight/2-1/2*boxSize)
end
function titleBar:draw(status)
  -- draw back ground
  local grayNum = 189
  love.graphics.setColor(grayNum/255, grayNum/255, grayNum/255)
  love.graphics.rectangle('fill',0,0,screenWidth,titleBarHeight)
  love.graphics.setColor(1, 1, 1)
  
  --draw face 
  if status == "gamewin" then 
    titleBar:drawface(self.images.cool)
  elseif status == "gameover" then
    titleBar:drawface(self.images.sad)
  else 
     titleBar:drawface(self.images.happy)
  end
end