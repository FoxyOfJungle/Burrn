
/// Feather ignore all
#macro BPE_VERSION "v0.1"
#macro BPE_RELEASE_DATE "June, 7, 2023"

show_debug_message($"Burrn Particle Engine {BPE_VERSION} | Copyright (C) 2023 FoxyOfJungle");


// particles list
global.__bpe_particles_array = [];

/// @ignore
function __bpe_trace(text) {
	gml_pragma("forceinline");
	if (BPE_CFG_DEBUG_MESSAGES) show_debug_message("# Burnn >> " + string(text));
}

// run every step
__particles_verify_ts = time_source_create(time_source_game, 1, time_source_units_frames, function() {
	var _array = global.__bpe_particles_array;
	var i = 0, isize = array_length(_array), _part;
	repeat(isize) {
		_part = _array[i];
		if (_part.timer != -1) {
			if (!_part.paused) _part.timer -= 1;
			if (_part.timer <= 0) {
				part_system_destroy(_part.system);
				array_delete(_array, i, 1);
				i -= 1;
			}
		}
		++i;
	}
}, [], -1);
time_source_start(__particles_verify_ts);
