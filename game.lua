local Game = {}

love.graphics.setDefaultFilter("nearest")

local WIDTH = love.graphics.getWidth()
local HEIGHT = love.graphics.getHeight()

local player1Goal = {}
local player1Player = {}
local player2Goal = {}
local player2Player = {}
local ball = {}

local font = nil
local text_scores = nil

local sndBounce = love.audio.newSource('audio/bounce.wav', 'static')
local sndGoal = love.audio.newSource('audio/goal.wav', 'static')
local sndWin = love.audio.newSource("audio/win.wav", 'static')

function Game.load()
	player1Goal.width = 20
	player1Goal.height = 80
	player1Goal.x = 30
	player1Goal.y = (HEIGHT - player1Goal.height) / 2
	player1Goal.score = 0
	player1Goal.speed = 300

	player1Player.width = 20
	player1Player.height = 80
	player1Player.x = 150
	player1Player.y = (HEIGHT - player1Player.height)  /2
	player1Player.speed = 300

	player2Goal.width = 20
	player2Goal.height = 80
	player2Goal.x = WIDTH - player2Goal.width - 30
	player2Goal.y = (HEIGHT - player1Goal.height) / 2
	player2Goal.score = 0
	player2Goal.speed = 300

	player2Player.width = 20
	player2Player.height = 80
	player2Player.x = WIDTH - player2Player.width - 150
	player2Player.y = (HEIGHT - player1Player.height)  /2
	player2Player.speed = 300

	ball.radius = 15
	ball.vx = 200
	ball.vy = 200
	ball.x = WIDTH / 2
	ball.y = HEIGHT / 2
	ball.inMotion = false

	font = love.graphics.newFont(48)

	CenterBall()

	text_scores = love.graphics.newText(font, {{0, 0, 1}, tostring(player1Goal.score), {1, 1, 1}, " - ", {1, 0, 0}, tostring(player2Goal.score)})
end

function CenterBall()
	ball.x = WIDTH / 2
	ball.y = HEIGHT / 2
	ball.inMotion = false

	player2Player.x = WIDTH - player2Player.width - 150
	player2Player.y = (HEIGHT - player1Player.height)  /2

	player2Goal.x = WIDTH - player2Goal.width - 30
	player2Goal.y = (HEIGHT - player1Goal.height) / 2

	player1Player.x = 150
	player1Player.y = (HEIGHT - player1Player.height)  /2

	player1Goal.x = 30
	player1Goal.y = (HEIGHT - player1Goal.height) / 2
end

function newGame()
	player1Goal.score = 0
	player2Goal.score = 0
	CenterBall()
end

function Game.update(dt)
	if player1Goal.score == 10 then
		sndWin:play()
		winner = "Player 1"
		screen = "victory"
	elseif player2Goal.score == 10 then
		sndWin:play()
		winner = "Player 2"
		screen = "victory"
	end

	-- Déplacement du goal du jouer 1
	if love.keyboard.isDown("a") then
		player1Goal.y = player1Goal.y - player1Goal.speed * dt

		if player1Goal.y < 0 then player1Goal.y = 0 end
	end

	if love.keyboard.isDown("w") then
		player1Goal.y = player1Goal.y + player1Goal.speed * dt

		if player1Goal.y + player1Goal.height > HEIGHT then player1Goal.y = HEIGHT - player1Goal.height end			
	end

	--Déplacement de l'attaquant du joueur 1

	if love.keyboard.isDown("e") then
		player1Player.y = player1Player.y - player1Player.speed * dt

		if player1Player.y < 0 then player1Player.y = 0 end
	end

	if love.keyboard.isDown("d") then
		player1Player.y = player1Player.y + player1Player.speed * dt

		if player1Player.y + player1Player.height > HEIGHT then player1Player.y = HEIGHT - player1Player.height end
	end

	if love.keyboard.isDown("f") then
		player1Player.x = player1Player.x + player1Player.speed * dt

		if player1Player.x + player1Player.width > WIDTH / 2 then player1Player.x = WIDTH / 2 - player1Player.width end
	end

	if love.keyboard.isDown("s") then
		player1Player.x = player1Player.x - player1Player.speed * dt

		if player1Player.x < player1Goal.x + player1Goal.width then player1Player.x = player1Goal.x + player1Goal.width end
	end

	-- Déplacement du goal du joueur 2

	if love.keyboard.isDown("up") then
		player2Goal.y = player2Goal.y - player2Goal.speed * dt

		if player2Goal.y < 0 then player2Goal.y = 0 end 
	end

	if love.keyboard.isDown("down") then
		player2Goal.y = player2Goal.y + player2Goal.speed * dt

		if player2Goal.y + player2Goal.height > HEIGHT then player2Goal.y = HEIGHT - player2Goal.height end
	end


	-- Déplacement de l'attaquant du joueur 2

	if love.keyboard.isDown("i") then
		player2Player.y = player2Player.y - player2Player.speed * dt

		if player2Player.y < 0 then player2Player.y = 0 end
	end

	if love.keyboard.isDown("j") then
		player2Player.x = player2Player.x - player2Player.speed * dt

		if player2Player.x < WIDTH / 2 then player2Player.x = WIDTH / 2 end
	end

	if love.keyboard.isDown("l") then
		player2Player.x = player2Player.x + player2Player.speed * dt

		if player2Player.x  + player2Player.width > player2Goal.x then player2Player.x = player2Goal.x - player2Player.width end
	end

	if love.keyboard.isDown("k") then
		player2Player.y = player2Player.y + player2Player.speed * dt

		if player2Player.y + player2Player.height > HEIGHT then player2Player.y = HEIGHT - player2Player.height end
	end

	if ball.inMotion == false then
		if ball.x + ball.radius > player1Player.x and ball.x - ball.radius < player1Player.x + player1Player.width and ball.y + ball.radius > player1Player.y and ball.y - ball.radius < player1Player.y + player1Player.height then
			ball.inMotion = true
			ball.vx = -200
		end

		if ball.x + ball.radius > player2Player.x and ball.x - ball.radius < player2Player.x + player2Player.width and ball.y + ball.radius > player2Player.y and ball.y - ball.radius < player2Player.y + player2Player.height then
			ball.inMotion = true
		end

		local rand = love.math.random(1, 2)
		if rand == 2 then ball.vy = -ball.vy end
	else
		-- Move the ball
		ball.x = ball.x + ball.vx * dt
		ball.y = ball.y + ball.vy * dt
	end

	if ball.y + ball.radius > HEIGHT then
			ball.vy = -ball.vy
			ball.y = HEIGHT - ball.radius
			sndBounce:play()
	end

	if ball.x + ball.radius > WIDTH then
		ball.vx = -ball.vx
		ball.x = WIDTH - ball.radius

		-- Lost ! 
		CenterBall()
		sndGoal:play()
		player1Goal.score = player1Goal.score + 1
	end

	if ball.y - ball.radius < 0 then
		ball.vy = -ball.vy
		ball.y = ball.radius
		sndBounce:play()
	end

	if ball.x - ball.radius < 0 then
		ball.vx = -ball.vx
		ball.x = ball.radius

		-- Lost ! 
		sndGoal:play()
		CenterBall()

		player2Goal.score = player2Goal.score + 1
	end

	if ball.x + ball.radius >= player2Goal.x and ball.y + ball.radius >= player2Goal.y and ball.y - ball.radius <= player2Goal.y + player2Goal.height and ball.x - ball.radius <= player2Goal.x + player2Goal.width then
		ball.vx = -ball.vx
		sndBounce:play()

		if ball.x < player2Goal.x then
			ball.x = player2Goal.x - ball.radius
		elseif ball.x > player2Goal.x + player2Goal.width then
			ball.x = player2Goal.x + player2Goal.width + ball.radius
		else
			ball.vx = -ball.vx
			ball.vy = -ball.vy

			if ball.y < player2Goal.y then
				ball.y = player2Goal.y - ball.radius
			elseif ball.y > player2Goal.y + player2Goal.height then
				ball.y = player2Goal.y + player2Goal.height + ball.radius
			end
		end
	end 

	if ball.x + ball.radius >= player1Goal.x and ball.y + ball.radius >= player1Goal.y and ball.y - ball.radius <= player1Goal.y + player1Goal.height and ball.x - ball.radius <= player1Goal.x + player1Goal.width then
		ball.vx = -ball.vx
		sndBounce:play()

		if ball.x > player1Goal.x + player1Goal.width then
			ball.x = player1Goal.x + ball.radius + player1Goal.width
		elseif ball.x < player1Goal.x then
			ball.x = player1Goal.x - ball.radius
		else
			ball.vx = -ball.vx
			ball.vy = -ball.vy

			if ball.y < player1Goal.y then
				ball.y = player1Goal.y - ball.radius
			elseif ball.y > player1Goal.y + player1Goal.height then
				ball.y = player1Goal.y + player1Goal.height + ball.radius
			end
		end
	end

	if ball.x + ball.radius > player1Player.x and ball.x - ball.radius < player1Player.x + player1Player.width and ball.y + ball.radius > player1Player.y and ball.y - ball.radius < player1Player.y + player1Player.height then

		if ball.x > player1Player.x + player1Player.width then
			ball.x = player1Player.x + player1Player.width + ball.radius

			if math.abs(ball.vx) ~= ball.vx then
				ball.vx = -ball.vx
				sndBounce:play()
			end
		elseif ball.x < player1Player.x then
			ball.x = player1Player.x - ball.radius

			if math.abs(ball.vx) == ball.vx then
				ball.vx = -ball.vx
				sndBounce:play()
			end
		else
			ball.vy = -ball.vy
			sndBounce:play()

			if ball.y < player1Player.y then
				ball.y = player1Player.y - ball.radius
			elseif ball.y > player1Player.y + player1Player.height then
				ball.y = player1Player.y + player1Player.height + ball.radius
			end
		end
	end 

	if ball.x + ball.radius >= player2Player.x and ball.x - ball.radius <= player2Player.x + player2Player.width and ball.y + ball.radius >= player2Player.y and ball.y - ball.radius <= player2Player.y + player2Player.height then
		if ball.x < player2Player.x then
			ball.x = player2Player.x - ball.radius

			if math.abs(ball.vx) == ball.vx then
				ball.vx = -ball.vx
				sndBounce:play()
			end
		elseif ball.x > player2Player.x + player2Player.width then
			ball.x = player2Player.x + player2Player.width + ball.radius

			if math.abs(ball.vx) ~= ball.vx then
				ball.vx = -ball.vx
				sndBounce:play()
			end
		else
			ball.vy = -ball.vy
			sndBounce:play()

			if ball.y < player2Player.y then
				ball.y = player2Player.y - ball.radius
			elseif ball.y > player2Player.y + player2Player.height then
				ball.y = player2Player.y + player2Player.height + ball.radius
			end
		end
	end	

	text_scores:set({{0, 0, 1}, tostring(player1Goal.score), {1, 1, 1}, " - ", {1, 0, 0}, tostring(player2Goal.score)})
end

function Game.draw()
	love.graphics.draw(text_scores, (WIDTH - text_scores:getWidth()) / 2, 10)
	final_score = text_scores

	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", WIDTH / 2 - 1, 0, 2, HEIGHT)

	love.graphics.setColor(0, 1, 0)
	love.graphics.rectangle("fill", player1Goal.x, player1Goal.y, player1Goal.width, player1Goal.height)

	love.graphics.setColor(0, 0, 1)
	love.graphics.rectangle("fill", player1Player.x, player1Player.y, player1Player.width, player1Player.height)

	love.graphics.setColor(1, 0, 1)
	love.graphics.rectangle("fill", player2Goal.x, player2Goal.y, player2Goal.width, player2Goal.height)

	love.graphics.setColor(1, 0, 0)
	love.graphics.rectangle("fill", player2Player.x, player2Player.y, player2Player.width, player2Player.height)

	love.graphics.setColor(1, 1, 0)
	love.graphics.circle("fill", ball.x, ball.y, ball.radius)

	love.graphics.setColor(1, 1, 1)
end

return Game