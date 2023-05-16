interface Workspace extends Model {
	["클론바닥2"]: Part & {
		Footprints: Texture;
	};
	Part: Part;
	SpawnLocation: SpawnLocation;
	walls: Folder & {
		["기둥"]: UnionOperation & {
			Floor: Texture;
			Footprints: Texture;
		};
		Floor: Part & {
			Floor: Texture;
			Footprints: Texture;
		};
		["벽"]: UnionOperation & {
			Floor: Texture;
			Footprints: Texture;
		};
		["맨위방"]: Folder & {
			["맨위천장"]: Part & {
				Floor: Texture;
				Footprints: Texture;
			};
			["맨위벽"]: UnionOperation & {
				Footprints: Texture;
				Floor: Texture;
			};
			["맨위바닥"]: UnionOperation;
			["맨위천장데코레이트"]: UnionOperation;
			["맨위기둥"]: UnionOperation & {
				Floor: Texture;
				Footprints: Texture;
			};
		};
		["천장선"]: UnionOperation;
		["불빛"]: Model & {
			wall6: Part & {
				Light: SurfaceLight;
			};
			wall8: Part & {
				Light: SurfaceLight;
			};
			wall5: Part & {
				Light: SurfaceLight;
			};
			wall2: Part & {
				Light: SurfaceLight;
			};
			wall7: Part & {
				Light: SurfaceLight;
			};
			wall4: Part & {
				Light: SurfaceLight;
			};
			wall1: Part & {
				Light: SurfaceLight;
			};
			wall3: Part & {
				Light: SurfaceLight;
			};
		};
		["천장꾸밈"]: Folder & {
			["천장꾸밈"]: UnionOperation;
			["천장꾸밈불빛"]: Part & {
				SurfaceLight: SurfaceLight;
			};
			["천장유리고정"]: UnionOperation;
		};
		["천장"]: UnionOperation & {
			Floor: Texture;
			Footprints: Texture;
		};
		["바닥선"]: UnionOperation;
		["바닥카펫"]: Part & {
			Footprints: Texture;
		};
	};
	Camera: Camera;
	Baseplate: Part & {
		Texture: Texture;
	};
	["클론바닥1"]: Part & {
		Floor: Texture;
		Footprints: Texture;
	};
	Model: Model & {
		Union: UnionOperation;
		light: Part;
	};
	Clones: Folder & {
		Clone1: Part & {
			Model: Model & {
				["구멍"]: UnionOperation;
				["테두리"]: UnionOperation;
				["가시"]: UnionOperation;
			};
		};
	};
}
