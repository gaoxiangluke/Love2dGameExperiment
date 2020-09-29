local function drawCell(image,x,y)
  love.graphics.draw(image, (x - 1) * cellSize, (y - 1) * cellSize)
end
grid = {}
local images = {}
function grid:load()
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
end
function grid:update()
  
end
function grid:draw()
  for y = 1,yMax do
    for x = 1,xMax do
      drawCell(images.covered,x,y)
    end
  end
  
end