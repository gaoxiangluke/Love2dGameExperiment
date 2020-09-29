
function love.load()
  

  images = {}
  firstmove = true
  
  selectedX = 0
  selectedY = 0
  gameOver = false
  for imageIndex,image in ipairs({
      1,2,3,4,5,6,7,8,
      'uncovered','covered_highlighted','covered','flower','flag','question'}) do
    images[image] = love.graphics.newImage('image/'..image..'.png')
  end
  
  
  
  --flower placement
  local possibleFlowerPosition = {}
  for y = 1, yMax do
    for x = 1, xMax do
      table.insert(possibleFlowerPosition,{x = x, y = y})
    end
  end
  
  for flowerIndex = 1,BombNum do
    local position = table.remove(possibleFlowerPosition,love.math.random(#possibleFlowerPosition))
    grid[position.y][position.x].bomb = true
  end
  function updateFlowernum()
    for y = 1, yMax do
      for x = 1, xMax do
      local num =  getSurrodingFlowerCount(x,y)
      grid[y][x].number = num 
      end
    end
  end
  
  updateFlowernum()
end
function getSurrodingFlowerCount(x,y)
  local surrodingFlowerCount = 0
    for dy = -1 ,1 do
      for dx = -1,1 do
        if not (dx == 0 and dy == 0) 
        and grid[y+dy]
        and grid[y+dy][x+dx]
        and grid[y+dy][x+dx].bomb then
          surrodingFlowerCount = surrodingFlowerCount + 1
        end
      end
    end
    return surrodingFlowerCount
end
function gameoverTodo()
   for y = 1, yMax do
      for x = 1, xMax do
        grid[y][x].state = "uncovered"
      end
   end
 end
 

function drawCell(image,x,y)
  love.graphics.draw(image, (x - 1) * cellSize, (y - 1) * cellSize)
end

function love.keyreleased(key)
  if key == 'right' or key == 'left' or key == 'up' or key == 'down' then
    currentDelay = 0
    firstmove = true
  end
end

function selectionBox:update(dt)
  
  
  
  selectedX = math.floor(self.x/cellSize) + 1
  selectedY = math.floor(self.y/cellSize) + 1
  if selectedX > xMax then
    selectedX = xMax
  end
  if selectedY > yMax then
    selectedY = yMax
  end
  
  -- check if a cell is selected
  if love.keyboard.isDown('j') then
    
  end
  
    
end

function love.keypressed(key)
  
end




function love.keyreleased(key) 
  if key == 'j' and  (grid[selectedY][selectedX].state ~= 'flag' and grid[selectedY][selectedX].state ~= 'question' )then
    local stack = {
     {
        x = selectedX,
        y = selectedY
     }
    }
    --local function uncoverNext(x,y)
    while #stack > 0 do
      local current = table.remove(stack)
      grid[current.y][current.x].state = 'uncovered'
      local x = current.x
      local y = current.y
      if (getSurrodingFlowerCount(x,y) == 0) then
        for dy = -1,1 do
          for dx = -1,1 do
             if not (dx == 0 and dy == 0) 
              and grid[y+dy]
              and grid[y+dy][x+dx]
              and ( grid[y+dy][x+dx].state == 'covered' or grid[y+dy][x+dx].state == 'question' )then
              table.insert(stack,{x = x+ dx, y = y+dy})
             end
          end
        end
      end
            
    end
    if grid[selectedY][selectedX].bomb == true then
      gameOver = true
      --gameoverTodo()
    end
  
  end
  if key == 'k' and (grid[selectedY][selectedX].state == 'covered')then
    grid[selectedY][selectedX].state = 'flag'
    flagCount = flagCount - 1
  elseif key == 'k' and grid[selectedY][selectedX].state == 'flag' then
    grid[selectedY][selectedX].state = 'covered'
    flagCount = flagCount + 1
  end
end
    
function love.update(dt)
  selectionBox:update(dt)
  
end
function love.draw() 
  local function drawFlag(x,y)
    if grid[y][x].state == "flag" then
       
      drawCell(images.flag,x,y)
    end
     if grid[y][x].state == "question" then
      drawCell(images.question,x,y)
    end
  end
  
    
  for y = 1,yMax do
    for x = 1,xMax do
      if (x == selectedX and y== selectedY) then
          if grid[y][x].state == "uncovered" then
            drawCell(images.uncovered,x,y)
         else
            drawCell(images.covered_highlighted,x,y)
             drawFlag(x,y)
         end
      else
         if grid[y][x].state == "uncovered" then
           drawCell(images.uncovered,x,y)
         else
           drawCell(images.covered,x,y)
            drawFlag(x,y)
         end
      end
      if grid[y][x].state == "uncovered" then
        if grid[y][x].bomb then
          drawCell(images.flower,x,y)
        elseif grid[y][x].number > 0 then
          drawCell(images[grid[y][x].number],x,y)
        end
      end

    end
  end
  selectionBox:draw()
  love.graphics.print('x: '..selectedX..' y: '..selectedY..'  status: '..grid[selectedY][selectedX].state)
end

      