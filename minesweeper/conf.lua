function love.conf(t)

	SCALE = 1
  yMax = 11
  xMax = 18
  cellSize = 18
  screenWidth = xMax * cellSize
  screenHeight = yMax * cellSize
  delayMax = 0.1
  BombNum = 40
  easynum = 25
  mediumnum = 35
  hardnum = 40
  flagCount = BombNum
  titleBarHeight = 40
  t.window.title = "minesweeper"
  t.window.width = 320
  t.window.height = 240
  t.version="11.1"
   
end
