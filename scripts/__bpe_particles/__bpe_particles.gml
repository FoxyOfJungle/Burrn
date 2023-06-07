
/// Feather ignore all

/// @desc Create particle from asset.
/// @param {real} x The x position the particle will be created at.
/// @param {real} y The y position the particle will be created at.
/// @param {Asset.GMParticleSystem} particle_asset The particle asset created in the Particle Editor.
/// @param {Bool} burst If enabled, the particle must be created once and then will be destroyed (useful for explosions).
/// If disabled, the particle is of the type that keeps creating/streaming (useful for fire).
/// @param {Struct} renderer Description.
/// @param {Real} life_time Description.
function particle_create(x, y, particle_asset, burst, renderer, life_time=60) {
	if (instanceof(renderer) != "ParticleRenderer") {
		__bpe_trace("\"renderer\" is not an instance of ParticleRenderer() class.");
		exit;
	}
	var _info = particle_get_info(particle_asset),
	_part_sys = part_system_create_layer(renderer.__layer, renderer.__persistent, particle_asset),
	_particle = {
		info : _info,
		asset : particle_asset,
		system : _part_sys,
		timer : burst ? life_time : -1,
		paused : false,
	};
	
	if (burst) {
		part_system_position(_part_sys, x, y);
	} else {
		particle_move(x, y, _particle);
	}
	array_push(global.__bpe_particles_array, _particle);
	return _particle;
}

/// @desc This function checks if the particle exists.
/// @param {Struct} particle_id Particle struct, created with particle_create().
function particle_exists(particle_id) {
	return !is_undefined(particle_id);
}

/// @desc Move previously created particle.
/// @param {Real} x The new particle x position.
/// @param {Real} y The new particle y position.
/// @param {Struct} particle_id Particle struct, created with particle_create().
function particle_move(x, y, particle_id) {
	if (!particle_exists(particle_id)) {
		__bpe_trace("Particle does not exists.");
		exit;
	}
	var _emitters = particle_id.info.emitters,
	_sys = particle_id.system,
	i = 0, isize = array_length(_emitters), _emitter = undefined;
	repeat(isize) {
		_emitter = _emitters[i];
		part_emitter_region(_sys, i, x+_emitter.xmin, x+_emitter.xmax, y+_emitter.ymin, y+_emitter.ymax, _emitter.shape, _emitter.distribution);
		++i;
	}
}

/// @desc Move the particle system in a fixed way.
/// @param {Real} x The new particle x position.
/// @param {Real} y The new particle y position.
/// @param {Struct} particle_id Particle struct, created with particle_create().
function particle_move_fixed(x, y, particle_id) {
	if (!particle_exists(particle_id)) {
		__bpe_trace("Particle does not exists.");
		exit;
	}
	part_system_position(particle_id.system, x, y);
}

/// @desc Destroy previously created particle.
function particle_destroy(particle_id) {
	if (!particle_exists(particle_id)) {
		__bpe_trace("Particle does not exists.");
		exit;
	}
	part_system_destroy(particle_id.system);
}

/// @desc This function defines whether particles should be emitted. [EXPERIMENTAL - I know the particle order is buggy.. idk why]
/// @param {Struct} particle_id Particle struct, created with particle_create().
/// @param {bool} enabled If true, the particle will emit.
function particle_set_emission_enabled(particle_id, enabled) {
	var _emitters = particle_id.info.emitters,
	_emitter = undefined,
	i = 0, isize = array_length(_emitters);
	repeat(isize) {
		_emitter = _emitters[i];
		part_emitter_stream(particle_id.system, i, _emitter.parttype.ind, enabled ? _emitter.number : 0);
		++i;
	}
}

/// @desc This function defines emission amount from an emitter.
/// @param {Struct} particle_id Particle struct, created with particle_create().
/// @param {real} amount Emission amount.
/// @param {real} emitter_index The emitter index.
function particle_set_emission(particle_id, amount, emitter_index=0) {
	var _emitter = particle_id.info.emitters[emitter_index];
	part_emitter_stream(particle_id.system, _emitter, _emitter.parttype.ind, amount);
}

/// @desc Pause previously created particle.
function particle_pause(particle_id, pause) {
	if (!particle_exists(particle_id)) {
		__bpe_trace("Particle does not exists.");
		exit;
	}
	particle_id.paused = pause;
	part_system_automatic_update(particle_id.system, !pause);
}

/// @desc Pause all particles.
function particle_pause_all(pause) {
	var _array = global.__bpe_particles_array;
	var i = 0, isize = array_length(_array), _part;
	repeat(isize) {
		_part = _array[i];
		_part.paused = pause;
		part_system_automatic_update(_part.system, !pause);
		++i;
	}
}

/// @desc This function is used to get the particle type of an emitter from the particle asset. Useful for modifying particles on the fly.
/// @param {Asset.GMParticleSystem} particle_asset The particle asset created in the Particle Editor.
/// @param {Real} emitter_index Emitter index, from the particle asset.
function particle_get_type(particle_asset, emitter_index=0) {
	return particle_get_info(particle_asset).emitters[emitter_index].parttype.ind;
}
