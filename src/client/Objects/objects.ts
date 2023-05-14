import { Workspace } from "@rbxts/services";

export const cloneOjects:BasePart[] = [];

export function reset(){
    cloneOjects.push(Workspace.Clones.Clone1)
    cloneOjects.push(Workspace.Clones.Clone2)
}

reset();