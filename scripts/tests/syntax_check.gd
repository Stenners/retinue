extends SceneTree

func _init() -> void:
	print("--- Running Script Syntax Check ---")
	
	var scripts_to_check = [
		"res://scripts/components/health_component.gd",
		"res://scripts/components/hitbox.gd",
		"res://scripts/components/hurtbox.gd",
		"res://scripts/player.gd",
		"res://scripts/enemies/skeleton_rogue.gd",
		"res://scripts/ui/hud.gd",
		"res://scripts/arena_manager.gd",
		"res://scripts/exit_gate.gd"
	]
	
	var success = true
	for path in scripts_to_check:
		print("Checking: ", path)
		var script = load(path)
		if script == null:
			printerr("FAILED to load script: ", path)
			success = false
		else:
			print("OK: ", path)
			
	if success:
		print("--- ALL SCRIPTS SYNTAX CHECK PASSED ---")
		quit(0)
	else:
		printerr("--- SCRIPTS SYNTAX CHECK FAILED ---")
		quit(1)

