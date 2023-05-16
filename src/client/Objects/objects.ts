import { Workspace } from "@rbxts/services";

type objects = Part & {
    Model: Model
}
export const cloneOjects:objects[] = [];

export function reset(){
    cloneOjects.push(Workspace.Clones.Clone1)
    // cloneOjects.push(Workspace.Clones.Clone2)
}

reset();