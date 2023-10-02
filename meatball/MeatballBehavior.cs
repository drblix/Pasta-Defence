using Godot;
using System;

public partial class MeatballBehavior : Node
{
    [Export]
    private RigidBody3D meatballBody;

    public override void _Ready()
    {
        meatballBody.BodyEntered += BodyEntered;
    }

    private void BodyEntered(Node otherBody)
    {
        GetParent().QueueFree();
    }
}
