import { Players, SoundService, Workspace } from "@rbxts/services";
import { cloneOjects } from "client/Objects/objects";

type boardType = undefined | { active: boolean, instance: Instance };

const player = Players.LocalPlayer;
const playerGui = player.WaitForChild("PlayerGui");

const gameOverScreen = playerGui.WaitForChild("Over") as ScreenGui;
const gameOverText = gameOverScreen.WaitForChild("TextLabel") as TextLabel;

const HealthScreen = playerGui.WaitForChild("Health") as ScreenGui;
const BlinderScreen = playerGui.WaitForChild("Blinder") as ScreenGui;

const BlinderFrame = BlinderScreen.WaitForChild("Frame") as Frame;
const BlinderText = BlinderFrame.WaitForChild("TextLabel") as TextLabel;

const board: boardType[][] = [];
const randomsNumber: number[] = [];

for (let i = 0; i < 100; i++) {
    randomsNumber[i] = i;
}
for (let i = 0; i < 10; i++) {
    board[i] = [];
    for (let j = 0; j < 10; j++) {
        board[i][j] = undefined;
    }
}

let gameover = false;
let level = 0;
let healthPoint = 3;
let comboCount = 1;

function movePlayerToSpawnPoint() {
    const character = player.Character;
    if (character) {
        const primaryPart = character.PrimaryPart!;
        const spawnPosition = game.GetService("Workspace").SpawnLocation.Position;
        primaryPart.CFrame = new CFrame(spawnPosition.add(new Vector3(0, 1, 0)));
    }
}

function createObject(board: boardType[][], x: number, y: number) {
    const objectNumber = x * 10 + y;

    const randomObjectNumber = math.random(0, cloneOjects.size() - 1)
    const randomObject = cloneOjects[randomObjectNumber];
    // cloneOjects.remove(randomObjectNumber);

    // const objectPart = new Instance("Part");
    const objectPart = randomObject.Clone()

    // objectPart.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    // objectPart.Size = new Vector3(4,4,4);

    const position = new Vector3(x * 8, 2.85, y * 8);
    const rotation = objectPart.Model.PrimaryPart!.Orientation;
    const cframe = new CFrame(position, position.add(rotation));
    const newFrame = new CFrame(position, position.add(rotation.mul(new CFrame(0, 0, 1).LookVector)));

    objectPart.Name = `Object${objectNumber}`
    objectPart.CFrame = cframe;
    objectPart.Model.SetPrimaryPartCFrame(newFrame);
    objectPart.Parent = Workspace;
    objectPart.Anchored = true;

    const clickDetector = new Instance("ClickDetector");
    clickDetector.Parent = objectPart;
    clickDetector.MouseClick.Connect(() => {
        if (healthPoint <= 0) return;
        if (!board[x][y]!.active) {
            reduceHealthPoint();
            if (healthPoint === 0) {
                if (gameover) return;
                gameover = true;
                const soundPart = SoundService.FindFirstChild("gameover") as Sound;
                soundPart.Play();
                gameOverScreen.Enabled = true;
                gameOverText.TweenPosition(
                    new UDim2(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quad,
                    0.3, false);
                wait(1);
                resetGame();
                gameOverText.TweenPosition(
                    new UDim2(0, 0, -1.2, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quad,
                    0.3, false);
                wait(0.3)
                gameOverScreen.Enabled = false;
            }
            return
        }
        const soundPart = SoundService.FindFirstChild("comb" + (comboCount > 13 ? "over" : comboCount)) as Sound;
        soundPart.Play();
        comboCount++;
        board[x][y]!.active = false;

        BlinderScreen.Enabled = true;
        BlinderFrame.TweenPosition(
            new UDim2(0, 0, 0, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quad,
            0.3, false);
        wait(0.3);
        if (level <= 100) {
            nextLevel();
            wait(0.3);
            BlinderText.Text = `LEVEL. ${level}/100`;
            wait(0.3);
            BlinderFrame.TweenPosition(
                new UDim2(0, 0, -1.2, 0),
                Enum.EasingDirection.Out,
                Enum.EasingStyle.Quad,
                0.3, false);
            wait(0.3);
            BlinderScreen.Enabled = false;
        } else {
            BlinderText.Text = `LEVEL CLEAR!`;
        }
    });

    return objectPart;
}

function nextLevel() {
    const ArrayrandomsNumber = math.random(0, randomsNumber.size() - 1);
    const randoms = randomsNumber[ArrayrandomsNumber];
    const x = math.floor(randoms / 10);
    const y = randoms % 10;
    randomsNumber.remove(ArrayrandomsNumber);

    movePlayerToSpawnPoint();
    level++;
    board[x][y] = { active: true, instance: createObject(board, x, y) };
}

function reduceHealthPoint() {
    const lights = Workspace.walls.불빛 as Model;
    for (let i = 0; i < lights.GetChildren().size(); i++) {
        const block = lights.GetChildren()[i] as Part;
        const light = block.FindFirstChild("Light") as Light;
        light.Color = Color3.fromRGB(255, 0, 0);
    }
    healthPoint--;
    const soundPart = SoundService.FindFirstChild("lostlife") as Sound;
    soundPart.Play();
    comboCount = 1;
    const hearts = ["heart1", "heart2", "heart3"].map(name => HealthScreen.FindFirstChild(name) as ImageLabel);
    for (let i = 0; i < hearts.size(); i++) {
        hearts[i].Visible = i < healthPoint;
    }
    wait(0.5)
    for (let i = 0; i < lights.GetChildren().size(); i++) {
        const block = lights.GetChildren()[i] as Part;
        const light = block.FindFirstChild("Light") as Light;
        light.Color = Color3.fromRGB(255, 255, 255);
    }
}

function resetGame() {
    gameover = false;
    level = 0;
    healthPoint = 3;
    comboCount = 1;
    for (let i = 0; i < 100; i++) {
        randomsNumber[i] = i;
    }
    BlinderScreen.Enabled = false;
    BlinderFrame.Position = new UDim2(0, 0, -1.2, 0);
    BlinderText.Text = `LEVEL. 1/100`;
    const hearts = ["heart1", "heart2", "heart3"].map(name => HealthScreen.FindFirstChild(name) as ImageLabel);
    for (let i = 0; i < hearts.size(); i++) {
        hearts[i].Visible = i < healthPoint;
    }
    for (let i = 0; i < 10; i++) {
        for (let j = 0; j < 10; j++) {
            if (board[i][j] !== undefined) {
                board[i][j]!.instance.Destroy();
                board[i][j] = undefined;
            }
        }
    }
    nextLevel();
}

export { nextLevel };