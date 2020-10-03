timer = {}
local timerBoxWidth = 48
  local timerBoxHeight = 31
  local timerPositionX= 15
  local timerPositionY= 5
function timer:load()
  timer.images = {}
  for imageIndex,image in ipairs({
      100,101,102,103,104,105,106,107,108,109,"negative"}) do
    timer.images[image] = love.graphics.newImage('image/'..image..'.png')
  end
end

function timer:update()
end
-- draw a single digit num 0 - 9
function timer:drawadigit(num,x,y)
  love.graphics.draw(timer.images[100+num],x,y)
end
function timer:drawnumber(num,x,y)
  -- first draw number at p1
  local negative = false
  local numone = 0
  local numten = 0
  local numhundred = 0
  if (num < 0) then
    negative = true
     local numP = -num
    if (num > -9) then
      numone = numP
      numten = 0
    elseif (num < -9 and num >= - 99) then
      numone = numP % 10
      numten = (numP - numone)/10
    end
      
  else 
    numone = num % 10
    if (num <= 9) then
      numten = 0
      numhundred = 0
    elseif (num > 9 and num <= 99 ) then
      numten = (num % 100 - numone)/10
      numhundred = 0
    else
      numten = (num % 100 - numone)/10
      numhundred =( num - 10*numten - numone) / 100
    end
  end
  if (negative == false) then
    timer:drawadigit(numone,x + timerBoxWidth/3*2,y)
    timer:drawadigit(numten,x + timerBoxWidth/3,y)
    timer:drawadigit(numhundred,x,y)
  else
    timer:drawadigit(numone,x + timerBoxWidth/3*2,y)
    timer:drawadigit(numten,x + timerBoxWidth/3,y)
    love.graphics.draw(timer.images.negative,x,y)  
  end
end
function timer:drawTimer(time)
   timer:drawnumber(time,screenWidth - timerPositionX - timerBoxWidth,timerPositionY)
end
function timer:drawCount()
  timer:drawnumber(flagCount,timerPositionX,timerPositionY)
end
function timer:draw(time)
   love.graphics.setColor(0/255, 0/255, 0/255)
   love.graphics.rectangle('fill',timerPositionX,timerPositionY,timerBoxWidth,timerBoxHeight)
   love.graphics.rectangle('fill',screenWidth - timerPositionX - timerBoxWidth,timerPositionY,timerBoxWidth,timerBoxHeight)
   love.graphics.setColor(1, 1, 1)
   timer:drawCount()
   timer:drawTimer(time)
end