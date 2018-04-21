local entities = require('src/entities/entities')

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

    entities.startup()
    local zepp = entities.create('zepp', 128, 128)
end

function love.update(dt)
    cloud.x = cloud.x + cloud.xSpeed * dt
    if cloud.x > love.graphics.getWidth() then
        cloud.x = -cloud.w
    end
    entities:update(dt)
end

function love.draw()
    love.graphics.setColor(191, 255, 255, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight() / 2)
    love.graphics.setColor(255, 255, 255, 255)
    -- love.graphics.draw(img_cloud, cloud.x, cloud.y, 0, cloud.w / img_cloud:getWidth(), cloud.h / img_cloud:getHeight())
    love.graphics.setColor(127, 159, 0, 255)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight() / 2)
    entities:draw()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end