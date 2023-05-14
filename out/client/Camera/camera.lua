-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Players = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Players
local function startCamera()
	Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
end
return {
	startCamera = startCamera,
}
