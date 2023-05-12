import { Players, Workspace } from "@rbxts/services";

const player = Players.LocalPlayer;
const camera = Workspace.CurrentCamera!;

export function startCamera(){
  Workspace.Camera.CameraSubject = player.Character?.PrimaryPart;
}