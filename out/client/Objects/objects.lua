-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Workspace = TS.import(script, game:GetService("ReplicatedStorage"), "rbxts_include", "node_modules", "@rbxts", "services").Workspace
local cloneOjects = {}
local function reset()
	local _clone1 = Workspace.Clones.Clone1
	table.insert(cloneOjects, _clone1)
	-- cloneOjects.push(Workspace.Clones.Clone2)
end
reset()
return {
	reset = reset,
	cloneOjects = cloneOjects,
}
