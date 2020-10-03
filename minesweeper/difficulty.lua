difficulty = {}
selection = {}
function difficulty:load()
  difficultyBarHeight = 40
  difficultyBarWidth = 80
  difficulty.selectedBarlocation = {}
  difficulty.image = love.graphics.newImage('image/difficulty.png')
  difficulty.possible = {{x = screenWidth / 2 -0.5 * difficultyBarWidth,y = titleBarHeight + 20},{x = screenWidth / 2 -0.5 * difficultyBarWidth,y = titleBarHeight + 80},{x = screenWidth / 2 -0.5 * difficultyBarWidth,y = titleBarHeight + 140}}
  selection.x = self.possible[1].x
  selection.y = self.possible[1].y
  selection.num = 1
end
function difficulty:draw()
  local grayNum = 160
  love.graphics.setColor(grayNum/255, grayNum/255, grayNum/255)
  love.graphics.rectangle('fill',0,titleBarHeight,screenWidth,screenHeight)
  --love.graphics.rectangle('fill',screenWidth / 2 -0.5 * difficultyBarWidth ,titleBarHeight + 80,difficultyBarWidth,difficultyBarHeight)
  --love.graphics.rectangle('fill',screenWidth / 2 -0.5 * difficultyBarWidth ,titleBarHeight + 140,difficultyBarWidth,difficultyBarHeight)
  --love.graphics.rectangle('fill',0 ,0,100,100)
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(difficulty.image, self.possible[1].x,self.possible[1].y)
  love.graphics.draw(difficulty.image, self.possible[2].x,self.possible[2].y)
  love.graphics.draw(difficulty.image, self.possible[3].x,self.possible[3].y)
   love.graphics.setColor(0, 0, 0)
   love.graphics.setNewFont(20)
  love.graphics.print("Easy",self.possible[1].x + 18,self.possible[1].y+5)
  love.graphics.print("Medium",self.possible[2].x,self.possible[2].y+5)
  love.graphics.print("Hard",self.possible[3].x + 18,self.possible[3].y+5)
  love.graphics.setColor(1, 1, 1)
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle('line',selection.x ,selection.y,difficultyBarWidth,difficultyBarHeight)
  love.graphics.setColor(1, 1, 1)
end
function difficulty:selectedBar()
  
end
function difficulty:update(dt)
  
end
function difficulty:pressed(key)
  if key == 'up' then
    if (selection.num ~= 1) then
      selection.num = selection.num-1
      selection.x = self.possible[selection.num].x
      selection.y = self.possible[selection.num].y
    end
  end
  if key == 'down' then
    if (selection.num ~= 3) then
      selection.num = selection.num+1
      selection.x = self.possible[selection.num].x
      selection.y = self.possible[selection.num].y
    end
  end
  if key == 'j' then
    return selection.num
  end
  return -1
end
