using Godot;

public partial class PlayerMovement : Node
{
    [Export(PropertyHint.Range, "0,25")]
    private float moveSpeed = 3f;

    [Export(PropertyHint.Range, "0,10")]
    private float jumpPower = 5f;

    [Export]
    private CharacterBody3D characterBody;
    [Export]
    private Camera3D playerCamera;

    private float gravity;

    public override void _Ready()
    {
        gravity = (float) ProjectSettings.GetSetting("physics/3d/default_gravity");
    }

    public override void _PhysicsProcess(double delta)
    {
        // get input vector and map to a vector3
        Vector2 inputVector = Input.GetVector("left", "right", "up", "down");
        Vector3 moveVector = new (inputVector.X, 0f, inputVector.Y);

        // move player relative to where they're facing
        Vector3 direction = (characterBody.Transform.Basis * moveVector).Normalized();

        // handle player jumping
        if (characterBody.IsOnFloor() && Input.IsActionPressed("jump"))
            characterBody.Velocity = new Vector3(characterBody.Velocity.X, jumpPower, characterBody.Velocity.Z);
        
        // is the player pressing any buttons?
        if (direction != Vector3.Zero)
        {
            Vector3 newVelocity = new (direction.X * moveSpeed, characterBody.Velocity.Y, direction.Z * moveSpeed);
            characterBody.Velocity = newVelocity;
        }
        // gradually brings the player's side velocities to a halt
        else
        {
            float movedX = Mathf.MoveToward(characterBody.Velocity.X, 0f, moveSpeed);
            float movedZ = Mathf.MoveToward(characterBody.Velocity.Z, 0f, moveSpeed);
            Vector3 newVelocity = new (movedX, characterBody.Velocity.Y, movedZ);

            characterBody.Velocity = newVelocity;
        }

        // apply gravity
        float newY = characterBody.Velocity.Y - ((float)delta * gravity);
        
        characterBody.Velocity = new (characterBody.Velocity.X, newY, characterBody.Velocity.Z);

        // repeated transformation changes leads to progressive inaccuracies
        // orthonormalization counteracts this
        characterBody.Orthonormalize();

        characterBody.MoveAndSlide();
    }
}
