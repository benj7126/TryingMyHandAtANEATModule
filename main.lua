NEAT = require("neat"):new(1, 1, 500, false, 1, function ()
    return {res = {}}
end, function (ai)
    return {
        math.random()
    }
end, function (instance, output, dt, curTime, input)
    table.insert(instance.res, {input[1], output[1]})
    return instance, curTime-0.01
end, function (ai)
    local total = 0
    local len = 0
    for i, v in pairs(ai.res) do
        len = len + 1
        local input = v[1]
        local output = v[2]
        total = total + 1/math.abs((input) - output)
    end
    return total/len
end)

NEAT:setupNNs()

function love.update(dt)
    NEAT:update(1)
end

function love.draw()
    love.graphics.setPointSize(4)
    for x = 0, 1, 1/100 do
        love.graphics.setColor(1, 0, 0)
        love.graphics.points(x*800, x*400+100)
        love.graphics.setColor(0, 0, 1)
        love.graphics.points(x*800, (NEAT.species[1].genomes[1].network:evaluateNetwork({x})[1])*400+100)
        love.graphics.setColor(0, 1, 1)
        love.graphics.points(x*800, (NEAT:evalBestNet({x})[1])*400+100)
    end
end