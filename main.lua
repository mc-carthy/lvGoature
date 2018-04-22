local Entities = require('src/entities/entities')
local Explosion = require('src/entities/explosion')

local cloud = {}

function love.load()
    img_cloud = love.graphics.newImage('src/assets/img/cloud.png')
    img_ball = love.graphics.newImage('src/assets/img/ball.png')
    img_man = love.graphics.newImage('src/assets/img/man.png')
    cloud.x = 128
    cloud.y = 128
    cloud.w = 128
    cloud.h = 64
    cloud.xSpeed = 32
    score = 0

    Entities.startup()
    for i = 1, 3 do
        local zepp = Entities.create('zepp', love.math.random(128, 256), 128, true)
    end
end

function love.update(dt)
    cloud.x = cloud.x + cloud.xSpeed * dt
    if cloud.x > love.graphics.getWidth() then
        cloud.x = -cloud.w
    end
    updateBackgroundExplosions(dt)
    Entities:update(dt)
end

function love.draw()
    love.graphics.setColor(127, 191, 255, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight() / 2)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(img_cloud, cloud.x, cloud.y, 0, cloud.w / img_cloud:getWidth(), cloud.h / img_cloud:getHeight())
    drawBackgroundExplosions()
    Entities:drawBackground()
    love.graphics.setColor(127, 159, 0, 255)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight() / 2)
    Entities:draw()
    love.graphics.setColor(25, 25, 25, 255)
    love.graphics.print('Score: ' .. score, 16, 16, 0)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then
        Entities.shoot(x, y)
    end
end

function pointInBox(px, py, x, y, w, h)
    if px > x and px < x + w then
        if py > y and py < y + h then
            return true
        end
    end
    return false
end

function addScore(v)
    score = score + v
end