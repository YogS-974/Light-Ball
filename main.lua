local game = require('game')
local menu = require('menu')
local controls = require('controls')
local victory = require('victory')

screen = "menu"

final_score = nil
winner = nil

music = love.audio.newSource("audio/music.mp3", "stream")

function love.load()
	love.window.setTitle("Light-Ball")
	love.window.setMode(800, 600)

	menu.load()
	controls.load()
	game.load()
	victory.load()

	music:setLooping(true)
	music:play()
end

function love.update(dt)
	if screen == "menu" then
		menu.update(dt)
	elseif screen == "game" then
		game.update(dt)
	elseif screen == "controls" then
		controls.update(dt)
	elseif screen == "victory" then
		victory.update(dt)
	end
end

function love.draw()
	if screen == "menu" then
		menu.draw()
	elseif screen == "game" then
		game.draw()
	elseif screen == "controls" then
		controls.draw()
	elseif screen == "victory" then
		victory.draw()
	end
end

function love.mousepressed(x, y, b)
	if screen == "menu" then
		menu.mousepressed(x, y, b)
	end
end