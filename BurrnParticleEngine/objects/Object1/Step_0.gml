

if (keyboard_check_pressed(ord("R"))) {
	game_restart();
}
if (keyboard_check_pressed(vk_enter)) {
	room_goto(Room2);
}


// pause existing particles
if (keyboard_check_pressed(ord("P"))) {
	//particle_pause(particle, true);
	particle_pause_all(true);
}
// resume existing particles
if (keyboard_check_pressed(ord("O"))) {
	//particle_pause(particle, false);
	particle_pause_all(false);
}
// pause existing particles
if (keyboard_check_pressed(ord("U"))) {
	particle_pause(particle, true);
}
// resume existing particles
if (keyboard_check_pressed(ord("I"))) {
	particle_pause(particle, false);
}
// move existing particle
if (keyboard_check(ord("M"))) {
	particle_move(mouse_x, mouse_y, particle);
}
// destroy existing particle
if (keyboard_check_pressed(ord("D"))) {
	particle_destroy(particle);
}
// disable last particle emission
if (keyboard_check_pressed(ord("Q"))) {
	particle_set_emission_enabled(particle, false);
}
// enable last particle emission
if (keyboard_check_pressed(ord("W"))) {
	particle_set_emission_enabled(particle, true);
}



if (mouse_check_button(mb_left)) {
	particle = particle_create(mouse_x, mouse_y, part_explosion, true, global.particles_renderer, 60);
}

if (mouse_check_button_pressed(mb_right)) {
	particle = particle_create(mouse_x, mouse_y, part_explosion, true, global.particles_renderer);
}

if (keyboard_check_pressed(ord("G"))) {
	particle = particle_create(mouse_x, mouse_y, part_fire, false, global.particles_renderer);
}
if (keyboard_check_pressed(ord("H"))) {
	var part = particle_get_type(part_fire, 0);
	part_type_direction(part, 270, 270, 0, 0);
	particle = particle_create(mouse_x, mouse_y, part_fire, false, global.particles_renderer);
}


if (keyboard_check(vk_space)) {
	instance_create_layer(random(room_width), random(room_height), "Missiles", obj_missile);
}






