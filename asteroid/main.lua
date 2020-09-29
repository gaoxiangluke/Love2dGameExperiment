function love.load()
  scale = 1
  arenaWidth = 800 * scale
  arenaHeight = 600 * scale
  -- set windows size
  love.window.setMode(arenaWidth,arenaHeight)
  shipRadius = 30 * scale
  bulletRadius = 5 * scale
  asteroidStages = {
    {
      speed = 120*scale,
      radius = 15* scale
    },
    {
      speed = 70*scale,
      radius = 30* scale
    },
    {
      speed = 50*scale,
      radius = 50* scale
    },
    {
      speed = 20*scale,
      radius = 80* scale
    },
  }
  asteroids = {
    {
        x = 100 * scale,
        y = 100 * scale
    },
    {
      x = arenaWidth - 100*scale,
      y = 100 * scale
    },
    {
      x = arenaWidth / 2,
      y = arenaHeight - 100* scale
    }
  }
  
  function reset()
    shipX = arenaWidth/2
    shipY = arenaHeight/2
    shipAngle = 0
    angleSpeed = 10 * scale
    shipSpeedX = 0
    shipSpeedY = 0
    shipspeed = 100 * scale
    bullets = {}
    bulletSpeed = 500 * scale
    for asteroidIndex, asteroid in ipairs(asteroids) do
      asteroid.angle = love.math.random() *(math.pi*2)
      asteroid.stage = #asteroidStages
    end
  end
  reset()
end
--collision function
 function areCirclesIntersecting(aX,aY,aRadius,bX,bY,bRadius)
  return (aX - bX)^2 + (aY - bY)^2 <= (aRadius + bRadius)^2
end
function love.update(dt) 
  if love.keyboard.isDown('right') then 
     shipAngle =(shipAngle + angleSpeed*dt)%(2*math.pi)
  end
  if love.keyboard.isDown('left') then 
    shipAngle = (shipAngle - angleSpeed*dt) %(2*math.pi)
  end
  if love.keyboard.isDown('up') then
    shipSpeedX = shipSpeedX + math.cos(shipAngle) * shipspeed * dt
    shipSpeedY = shipSpeedY + math.sin(shipAngle) * shipspeed * dt
  end

  
  for bulletIndex = #bullets,1,-1 do
    local bullet = bullets[bulletIndex]
    bullet.timeLeft = bullet.timeLeft - dt
    if bullet.timeLeft <= 0 then
      table.remove(bullets,bulletIndex)
    else
      bullet.x = (bullet.x + math.cos(bullet.angle) * bulletSpeed * dt) % arenaWidth
      bullet.y = (bullet.y + math.sin(bullet.angle) * bulletSpeed * dt ) % arenaHeight
    end
    
    --check bullet touch asteroid or not
    for asteroidIndex = #asteroids, 1, -1 do
      local asteroid = asteroids[asteroidIndex]
     if areCirclesIntersecting(bullet.x,bullet.y,bulletRadius,asteroid.x,asteroid.y,asteroidStages[asteroid.stage].radius) then
        table.remove(bullets,bulletIndex)
        local  angle1 = love.math.random()*(2*math.pi)
        local  angle2 = (angle1 - math.pi) % (2*math.pi)
        if asteroid.stage > 1 then
          table.insert(asteroids,{
              x = asteroid.x,
              y = asteroid.y,
              angle = angle1 ,
              stage = asteroid.stage - 1
            })
          table.insert(asteroids,{
              x = asteroid.x,
              y = asteroid.y,
              angle = angle2,
              stage = asteroid.stage - 1
          })
        end
        table.remove(asteroids,asteroidIndex)
        
        
      end
    end
  end
  shipX = (shipX + shipSpeedX * dt) % arenaWidth
  shipY = (shipY + shipSpeedY * dt) % arenaHeight
  
  
  --update asteroid
  for asteroidIndex, asteroid in ipairs(asteroids) do
    asteroid.x = (asteroid.x + math.cos(asteroid.angle) * asteroidStages[asteroid.stage].speed * dt) % arenaWidth
    asteroid.y = (asteroid.y + math.sin(asteroid.angle) * asteroidStages[asteroid.stage].speed * dt) % arenaHeight
    
    --restart game if collisied
    if areCirclesIntersecting(shipX,shipY,shipRadius,asteroid.x,asteroid.y,asteroidStages[asteroid.stage].radius) then
      love.load()
      break
    end
  end
    -- restart game when finished
    if #asteroids == 0 then
      love.load()
    end
end
function love.draw()
  for y = -1 ,1 do
    for x = -1,1 do
      love.graphics.origin()
      love.graphics.translate(x * arenaWidth ,  y * arenaHeight)
      love.graphics.setColor(0,0,1)
      love.graphics.circle('fill',shipX,shipY,shipRadius)
  
      love.graphics.setColor(0,1,255/255)
      local shipCircleDistance = 20 * scale
      love.graphics.circle('fill',shipX+math.cos(shipAngle) * shipCircleDistance,
                             shipY+math.sin(shipAngle) * shipCircleDistance,
                             5
      )
      
      for bulletIndex, bullet in ipairs(bullets) do
        love.graphics.setColor(1,0,0)
        love.graphics.circle('fill',bullet.x,bullet.y ,bulletRadius)
      end
      
      for asteroidIndex, asteroid in ipairs(asteroids) do
        love.graphics.setColor(1,1,0)
        love.graphics.circle('fill',asteroid.x,asteroid.y,asteroidStages[asteroid.stage].radius)
      end
    end
  end
  
  --temo
  love.graphics.origin()
  love.graphics.setColor(1,1,1)
  --[[love.graphics.print(table.concat({'shipAngle: '..shipAngle,
                                    'shipX: '..shipX,
                                    'shipY: '..shipY},'\n')) --]]
end
function love.keypressed(key)
  if key == 'j' then
    table.insert(bullets,{x = shipX+ math.cos(shipAngle) * shipRadius, y = shipY + math.sin(shipAngle) * shipRadius,angle = shipAngle,timeLeft = 4})
  end
  if key == 'k' then
    bulletSpeed = 100
    shipSpeedX = shipSpeedX / 2
    shipSpeedY = shipSpeedY / 2
    for asteroidIndex, asteroidStage in ipairs(asteroidStages) do
      asteroidStage.speed = asteroidStage.speed/2
    end
  end
  if key == 'escape' then 
    love.event.quit()
  end
end
function love.keyreleased(key)
  if key == 'k' then
    bulletSpeed = 500
    shipSpeedX = shipSpeedX * 2
    shipSpeedY = shipSpeedY * 2
    for asteroidIndex, asteroidStage in ipairs(asteroidStages) do
      asteroidStage.speed = asteroidStage.speed*2
    end
  end
end

