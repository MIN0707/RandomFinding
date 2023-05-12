-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local _services = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services")
local Players = _services.Players
local Workspace = _services.Workspace
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local function startCamera()
	local _result = player.Character
	if _result ~= nil then
		_result = _result.PrimaryPart
	end
	Workspace.Camera.CameraSubject = _result
end
return {
	startCamera = startCamera,
}
