import { Players, Workspace } from "@rbxts/services";

export function startCamera() {
  Players.LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson;
}