-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local StarterGui = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").StarterGui
local startCamera = TS.import(script, script.Parent, "Camera", "camera").startCamera
local nextLevel = TS.import(script, script.Parent, "Game", "game").nextLevel
startCamera()
nextLevel()
StarterGui:SetCore("ResetButtonCallback", false)
