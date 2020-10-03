local function drawCell(image,x,y)
  love.graphics.draw(image, (x - 1) * cellSize, titleBarHeight+(y - 1) * cellSize)
end
grid = {}
local images = {}
local selectedX = 0
  local selectedY = 0
function getSurrodingBombCount(x,y)
  local surrodingBombCount = 0
    for dy = -1 ,1 do
      for dx = -1,1 do
        if not (dx == 0 and dy == 0) 
        and grid[y+dy]
        and grid[y+dy][x+dx]
        and grid[y+dy][x+dx].bomb then
          surrodingBombCount = surrodingBombCount + 1
        end
      end
    end
    return surrodingBombCount
end

function grid:updateBombNum()
  for y = 1, yMax do
    for x = 1, xMax do
    local num =  getSurrodingBombCount(x,y)
    grid[y][x].number = num 
    end
  end
end

function placeBomb(xs,ys)
  -- reset all bomb positions
  for y = 1, yMax do 
    grid[y] = {}
    for x = 1, xMax do
      grid[y][x] = {
          bomb = false,
          number = 0,
          state = "covered",
      }
    end
  end
  
  local possibleBombPosition = {}
  for y = 1, yMax do
    for x = 1, xMax do
      if (xs == -1 and ys == -1) then
        table.insert(possibleBombPosition,{x = x, y = y})
      else 
        if (x ~= xs and y ~= ys) then
          table.insert(possibleBombPosition,{x = x, y = y})
        end
      end
    end
  end
  
  for flowerIndex = 1,BombNum do
    local position = table.remove(possibleBombPosition,love.math.random(#possibleBombPosition))
    grid[position.y][position.x].bomb = true
  end
  grid:updateBombNum()
end
function grid:reset()
   for imageIndex,image in ipairs({
      1,2,3,4,5,6,7,8,
      'uncovered','covered_highlighted','covered','flower','flag','question'}) do
    images[image] = love.graphics.newImage('image/'..image..'.png')
  end
  for y = 1, yMax do 
    grid[y] = {}
    for x = 1, xMax do
      grid[y][x] = {
          state = "covered",
          bomb = false,
          number = 0
      }
    end
  end
  selectedX = 0
  selectedY = 0
  
  placeBomb(-1,-1)
end
function grid:load()
 grid:reset()
end
function grid:update()
  
end
function grid:draw()
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
            drawCell(images.covered,x,y)
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
  
end

-- set current selected cell
function grid:setSelected(x,y)
  selectedX = x
  selectedY = y
end
--set a particular cell to uncovered update to full version later
function grid:uncovered(x,y)
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
      if (getSurrodingBombCount(x,y) == 0) then
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
end
function grid:setFlag(x,y)
  if grid[y][x].state == 'covered' then
    grid[y][x].state = 'flag'
    flagCount = flagCount - 1;
  elseif grid[y][x].state == 'flag' then
     grid[y][x].state = 'covered'
     flagCount = flagCount + 1;
  end
end
function grid:isflag(x,y)
  if grid[y][x].state == 'flag' then
    return true
  else
    return false
  end
end
function grid:cancelFlag(x,y)
  grid[y][x].state = 'covered'
end
function grid:isBomb(x,y)
  return grid[y][x].bomb
end

function grid:revealgrid()
  for y = 1,yMax do
    for x = 1,xMax do
      grid[y][x].state = 'uncovered'
    end
  end
end

function grid:checkifGameWin()
  local gamewin = true
  for y = 1,yMax do
    for x = 1,xMax do
      if grid[y][x].bomb == true and grid[y][x].state ~= 'flag' then
        gamewin = false
        break
      end
    end
  end 
  return gamewin;
end