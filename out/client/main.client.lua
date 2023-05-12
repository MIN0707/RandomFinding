-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local Workspace = _services.Workspace
local startCamera = TS.import(script, script.Parent, "Camera", "camera").startCamera
local player = Players.LocalPlayer
local board = {}
startCamera()
do
	local _i = 0
	local _shouldIncrement = false
	while true do
		local i = _i
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
			local _j = 0
			local _shouldIncrement_1 = false
			while true do
				local j = _j
				if _shouldIncrement_1 then
					j += 1
				else
					_shouldIncrement_1 = true
				end
				if not (j < 10) then
					break
				end
				local part = Instance.new("Part")
				local clickDetector = Instance.new("ClickDetector")
				local number = i * 10 + j
				part.Name = "Object" .. tostring(number)
				part.Size = Vector3.new(4, 4, 4)
				part.Position = Vector3.new(i * 8, 1, j * 8)
				part.Parent = Workspace
				part.Anchored = true
				part.BrickColor = BrickColor.new("Bright blue")
				clickDetector.Parent = part
				clickDetector.MouseClick:Connect(function()
					if not board[i + 1][j + 1].active then
						return nil
					end
					board[i + 1][j + 1].active = false
					part.BrickColor = BrickColor.new("Really red")
				end)
				clickDetector.RightMouseClick:Connect(function()
					if board[i + 1][j + 1].active then
						return nil
					end
					board[i + 1][j + 1].active = true
					part.BrickColor = BrickColor.new("Bright blue")
				end)
				board[i + 1][j + 1] = {
					active = true,
					instance = part,
				}
				_j = j
			end
		end
		_i = i
	end
end
