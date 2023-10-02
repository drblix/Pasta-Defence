using Godot;
using System;

public partial class CameraMovement : Node
{
	[Export]
	private CharacterBody3D characterBody;
	[Export]
	private Camera3D playerCamera;

	[Export(PropertyHint.Range, "0,90,radians")]
	private float maxViewAngle = 80;

	[Export]
	private float mouseSensitivity = .5f;
	[Export]
	private bool invertMouse = false;

    public override void _Ready()
    {
		Input.MouseMode = Input.MouseModeEnum.Captured;
    }

    public override void _Input(InputEvent @event)
    {
		if (@event.GetType() == typeof(InputEventMouseMotion))
		{
			// casting to usable class
			InputEventMouseMotion mouseMotion = (InputEventMouseMotion)@event;
			// getting the movement in past frame
			Vector2 mouseVelocity = mouseMotion.Relative * mouseSensitivity;

			// y rotation is handled by character body
			characterBody.RotateY(Mathf.DegToRad(-mouseVelocity.X));
				
			// up and down rotation of player camera
			if (invertMouse)
				playerCamera.RotateX(Mathf.DegToRad(mouseVelocity.Y));
			else
				playerCamera.RotateX(Mathf.DegToRad(-mouseVelocity.Y));

			playerCamera.Rotation = new(Mathf.Clamp(playerCamera.Rotation.X, -maxViewAngle, maxViewAngle), playerCamera.Rotation.Y, playerCamera.Rotation.Z);
		}
		else if (@event.GetType() == typeof(InputEventKey) && ((InputEventKey)@event).Keycode == Key.Escape)
			GetTree().Quit();
	}
}
