import { Players, Workspace } from "@rbxts/services";
import { startCamera } from "./Camera/camera";

type boardType = undefined | { active: boolean, instance: Instance };

const player = Players.LocalPlayer
const board: boardType[][] = [];

startCamera();

for (let i = 0; i < 10; i++) {
	board[i] = [];
	for (let j = 0; j < 10; j++) {
		const part = new Instance("Part");
		const clickDetector = new Instance("ClickDetector");
		const number = i * 10 + j;
		part.Name = `Object${number}`
		part.Size = new Vector3(4, 4, 4);
		part.Position = new Vector3(i * 8, 1, j * 8);
		part.Parent = Workspace;
		part.Anchored = true;
		part.BrickColor = new BrickColor("Bright blue");

		clickDetector.Parent = part;
		clickDetector.MouseClick.Connect(() => {
			if (!board[i][j]!.active) return;
			board[i][j]!.active = false;
			part.BrickColor = new BrickColor("Really red");
		});

		clickDetector.RightMouseClick.Connect(() => {
			if (board[i][j]!.active) return;
			board[i][j]!.active = true;
			part.BrickColor = new BrickColor("Bright blue");
		});

		board[i][j] = { active: true, instance: part };
	}
}
