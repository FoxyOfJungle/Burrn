
/// @desc This class serves to create a "pointer" that will define in which layer the new particles will be created.
/// @param {any} layer_id The layer name/id.
/// @param {bool} persist If true, the particles will not be destroyed when leaving the room.
function ParticleRenderer(layer_id, persist=false) constructor {
	// Base
	__layer = layer_id;
	__persistent = persist;
	__system = part_system_create_layer(layer_id, persist);
	
	#region Public Methods
	
	/// @func GetLayer()
	static GetLayer = function() {
		return __layer;
	}
	
	/// @func SetLayer(new_layer)
	static SetLayer = function(new_layer) {
		__layer = new_layer;
	}
	
	#endregion
	
}
