import { StarterGui } from "@rbxts/services";
import { startCamera } from "./Camera/camera";
import { nextLevel } from "./Game/game";

startCamera();
nextLevel();
StarterGui.SetCore("ResetButtonCallback", false)