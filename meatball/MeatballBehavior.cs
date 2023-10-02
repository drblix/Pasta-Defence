using Godot;
using System;

public partial class MeatballBehavior : Node
{
    [Export]
    private RigidBody3D meatballBody;

    [Export]
    private StringName enemyGroup = "enemy";

    public override void _Ready()
    {
        meatballBody.BodyEntered += BodyEntered;
    }

    private void BodyEntered(Node otherBody)
    {
        if (otherBody.IsInGroup(enemyGroup))
        {
            otherBody.QueueFree();
        }
        
        // destroy meatball
        GetParent().QueueFree();
    }
}
