interface Workspace extends Model {
	Floor: Part;
	Camera: Camera;
	SpawnLocation: SpawnLocation;
	Baseplate: Part & {
		Texture: Texture;
	};
}
