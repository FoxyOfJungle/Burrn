
timer++;
if (timer > 3) {
	// set new missile direction
	var _rot = direction + 180 + random_range(-10, 10);
	
	// get particle type
	var part = particle_get_type(part_missile, 0);
	
	// set particle type direction
	part_type_direction(part, _rot, _rot, 0, 0);
	
	// create particles
	particle_create(x, y, part_missile, true, global.missiles_particles_renderer);
	
	
	// reset missile timer
	timer = irandom_range(1, 3);
}

// visual
image_angle = direction;
direction -= 1 * way;
speed += 0.005;
