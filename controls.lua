local Controls = {}
local font = nil
local text = nil

local print_exit = true
local counter = nil
local exit_text = nil

function Controls.load()
	font = love.graphics.newFont(15)
	local text1 = "This is a 2-Player Game. To score, you have to shoot the ball out of the screen, on your opponent's side.\n \n"
	local text2 = "Press A to move the green pad up. \n \n"
	local text3 = "Press W to move the green pad down. \n \n"
	local text4 = "Press E to move the blue pad up. \n \n"
	local text5 = "Press F to move the blue pad right. \n \n"
	local text6 = "Press D to move the blue pad down. \n \n"
	local text7 = "Press S to move the blue pad left. \n \n"

	local text8 = "Press UP to move the purple pad up. \n \n"
	local text9 = "Press DOWN to move the purple pad down. \n \n"
	local text10 = "Press I to move the red pad up. \n \n"
	local text11 = "Press L to move the red pad right. \n \n"
	local text12 = "Press K to move the red pad down. \n \n"
	local text13 = "Press J to move the red pad left. \n \n"

	text = {text1, {0, 1, 0}, text2..text3, {0, 0, 1}, text4..text5..text6..text7, {1, 0, 1}, text8..text9, {1, 0, 0}, text10..text11..text12..text13}

	exit_text = "Press Space to continue."
	counter = 2
end

function Controls.update(dt)
	if love.keyboard.isDown("space") then
		screen = "menu"
	end

	counter = counter + 1 * dt

	if math.floor(counter) % 2 == 0 then
		print_exit = true
	else
		print_exit = false
	end
end

function Controls.draw()
	love.graphics.setDefaultFilter("nearest")

	love.graphics.setColor(1, 1, 1)
	love.graphics.printf(text, font, 100, 50, 600, "center")

	local wt = font:getWidth(exit_text)
	local ht = font:getHeight(exit_text)

	love.graphics.setColor(1, 1, 0)
	if print_exit == true then
		love.graphics.print(exit_text, font, (love.graphics.getWidth() - wt) / 2, love.graphics.getHeight() - 20 - ht)
	end
end

return Controls