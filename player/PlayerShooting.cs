using Godot;

public partial class PlayerShooting : Node
{
	[Export]
	private Area3D meatballSpawn;

	[Export]
	private Node3D playerCamera;

	[Export(PropertyHint.Range, "1,100")]
	private float throwForce = 5f;

	private Node worldNode;
	private PackedScene meatballObject;

    public override void _Ready()
    {
        meatballObject = ResourceLoader.Load("res://meatball/meatball.tscn") as PackedScene;
        
		worldNode = GetParent().GetParent().GetParent();
    }

    public override void _Process(double delta)
    {
        if (CanShoot())
        {
            RigidBody3D newMeatball = meatballObject.Instantiate() as RigidBody3D;
            worldNode.AddChild(newMeatball);
            newMeatball.GlobalPosition = meatballSpawn.GlobalPosition;

            Vector3 forwardVector = -playerCamera.GlobalTransform.Basis.Z;
            newMeatball.ApplyImpulse(forwardVector * throwForce);
        }
    }

    private bool CanShoot() => Input.IsActionJustPressed("shoot") && meatballSpawn.GetOverlappingBodies().Count == 0;
}
