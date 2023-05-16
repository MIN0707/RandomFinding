-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local SoundService = _services.SoundService
local Workspace = _services.Workspace
local cloneOjects = TS.import(script, script.Parent.Parent, "Objects", "objects").cloneOjects
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gameOverScreen = playerGui:WaitForChild("Over")
local gameOverText = gameOverScreen:WaitForChild("TextLabel")
local HealthScreen = playerGui:WaitForChild("Health")
local BlinderScreen = playerGui:WaitForChild("Blinder")
local BlinderFrame = BlinderScreen:WaitForChild("Frame")
local BlinderText = BlinderFrame:WaitForChild("TextLabel")
local board = {}
local randomsNumber = {}
do
	local i = 0
	local _shouldIncrement = false
	while true do
		if _shouldIncrement then
			i += 1
		else
			_shouldIncrement = true
		end
		if not (i < 100) then
			break
		end
		randomsNumber[i + 1] = i
	end
end
do
	local i = 0
	local _shouldIncrement = false
	while true do
		if _shouldIncrement then
			i += 1
		else
			_shouldIncrement = true
		end
		if not (i < 10) then
			break
		end
		board[i + 1] = {}
		do
			local j = 0
			local _shouldIncrement_1 = false
			while true do
				if _shouldIncrement_1 then
					j += 1
				else
					_shouldIncrement_1 = true
				end
				if not (j < 10) then
					break
				end
				board[i + 1][j + 1] = nil
			end
		end
	end
end
local gameover = false
local level = 0
local healthPoint = 3
local comboCount = 1
local function movePlayerToSpawnPoint()
	local character = player.Character
	if character then
		local primaryPart = character.PrimaryPart
		local spawnPosition = game:GetService("Workspace").SpawnLocation.Position
		local _vector3 = Vector3.new(0, 1, 0)
		primaryPart.CFrame = CFrame.new(spawnPosition + _vector3)
	end
end
local reduceHealthPoint, resetGame, nextLevel
local function createObject(board, x, y)
	local objectNumber = x * 10 + y
	local randomObjectNumber = math.random(0, #cloneOjects - 1)
	local randomObject = cloneOjects[randomObjectNumber + 1]
	-- cloneOjects.remove(randomObjectNumber);
	-- const objectPart = new Instance("Part");
	local objectPart = randomObject:Clone()
	-- objectPart.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
	-- objectPart.Size = new Vector3(4,4,4);
	local position = Vector3.new(x * 8, 2.85, y * 8)
	local rotation = objectPart.Model.PrimaryPart.Orientation
	local cframe = CFrame.new(position, position + rotation)
	local _lookVector = CFrame.new(0, 0, 1).LookVector
	local _arg0 = rotation * _lookVector
	local newFrame = CFrame.new(position, position + _arg0)
	objectPart.Name = "Object" .. tostring(objectNumber)
	objectPart.CFrame = cframe
	objectPart.Model:SetPrimaryPartCFrame(newFrame)
	objectPart.Parent = Workspace
	objectPart.Anchored = true
	local clickDetector = Instance.new("ClickDetector")
	clickDetector.Parent = objectPart
	clickDetector.MouseClick:Connect(function()
		if healthPoint <= 0 then
			return nil
		end
		if not board[x + 1][y + 1].active then
			reduceHealthPoint()
			if healthPoint == 0 then
				if gameover then
					return nil
				end
				gameover = true
				local soundPart = SoundService:FindFirstChild("gameover")
				soundPart:Play()
				gameOverScreen.Enabled = true
				gameOverText:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, false)
				wait(1)
				resetGame()
				gameOverText:TweenPosition(UDim2.new(0, 0, -1.2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, false)
				wait(0.3)
				gameOverScreen.Enabled = false
			end
			return nil
		end
		local soundPart = SoundService:FindFirstChild("comb" .. tostring((if comboCount > 13 then "over" else comboCount)))
		soundPart:Play()
		comboCount += 1
		board[x + 1][y + 1].active = false
		BlinderScreen.Enabled = true
		BlinderFrame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, false)
		wait(0.3)
		if level <= 100 then
			nextLevel()
			wait(0.3)
			BlinderText.Text = "LEVEL. " .. (tostring(level) .. "/100")
			wait(0.3)
			BlinderFrame:TweenPosition(UDim2.new(0, 0, -1.2, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, false)
			wait(0.3)
			BlinderScreen.Enabled = false
		else
			BlinderText.Text = "LEVEL CLEAR!"
		end
	end)
	return objectPart
end
function nextLevel()
	local ArrayrandomsNumber = math.random(0, #randomsNumber - 1)
	local randoms = randomsNumber[ArrayrandomsNumber + 1]
	local x = math.floor(randoms / 10)
	local y = randoms % 10
	table.remove(randomsNumber, ArrayrandomsNumber + 1)
	movePlayerToSpawnPoint()
	level += 1
	board[x + 1][y + 1] = {
		active = true,
		instance = createObject(board, x, y),
	}
end
function reduceHealthPoint()
	local lights = Workspace.walls["불빛"]
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < #lights:GetChildren()) then
				break
			end
			local block = lights:GetChildren()[i + 1]
			local light = block:FindFirstChild("Light")
			light.Color = Color3.fromRGB(255, 0, 0)
		end
	end
	healthPoint -= 1
	local soundPart = SoundService:FindFirstChild("lostlife")
	soundPart:Play()
	comboCount = 1
	local _arg0 = function(name)
		return HealthScreen:FindFirstChild(name)
	end
	local _exp = { "heart1", "heart2", "heart3" }
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#_exp)
	for _k, _v in _exp do
		_newValue[_k] = _arg0(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.map ▲
	local hearts = _newValue
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < #hearts) then
				break
			end
			hearts[i + 1].Visible = i < healthPoint
		end
	end
	wait(0.5)
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < #lights:GetChildren()) then
				break
			end
			local block = lights:GetChildren()[i + 1]
			local light = block:FindFirstChild("Light")
			light.Color = Color3.fromRGB(255, 255, 255)
		end
	end
end
function resetGame()
	gameover = false
	level = 0
	healthPoint = 3
	comboCount = 1
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < 100) then
				break
			end
			randomsNumber[i + 1] = i
		end
	end
	BlinderScreen.Enabled = false
	BlinderFrame.Position = UDim2.new(0, 0, -1.2, 0)
	BlinderText.Text = "LEVEL. 1/100"
	local _arg0 = function(name)
		return HealthScreen:FindFirstChild(name)
	end
	local _exp = { "heart1", "heart2", "heart3" }
	-- ▼ ReadonlyArray.map ▼
	local _newValue = table.create(#_exp)
	for _k, _v in _exp do
		_newValue[_k] = _arg0(_v, _k - 1, _exp)
	end
	-- ▲ ReadonlyArray.map ▲
	local hearts = _newValue
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < #hearts) then
				break
			end
			hearts[i + 1].Visible = i < healthPoint
		end
	end
	do
		local i = 0
		local _shouldIncrement = false
		while true do
			if _shouldIncrement then
				i += 1
			else
				_shouldIncrement = true
			end
			if not (i < 10) then
				break
			end
			do
				local j = 0
				local _shouldIncrement_1 = false
				while true do
					if _shouldIncrement_1 then
						j += 1
					else
						_shouldIncrement_1 = true
					end
					if not (j < 10) then
						break
					end
					if board[i + 1][j + 1] ~= nil then
						board[i + 1][j + 1].instance:Destroy()
						board[i + 1][j + 1] = nil
					end
				end
			end
		end
	end
	nextLevel()
end
return {
	nextLevel = nextLevel,
}
