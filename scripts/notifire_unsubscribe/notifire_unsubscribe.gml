// Feather disable all

/// Unsibscribes the current instance from an event, or multiple events in case an array is provided.
/// If no event is provided, the instance gets unsubscribed from all its events.
/// Optionally, the instance can be specified explicitly.
///
/// @param		{real|string|array}	[event]
/// @param		{instance}			[instance]
/// @returns    N/A

function notifire_unsubscribe(_event = undefined, _instance = self){
	static _notifire = __notifire();
	
	var _subscriber = _instance.id;
	
	if(is_array(_event)) {
		for(var _i = 0; _i < array_length(_event); _i++) {
			_notifire.unsubscribe(_subscriber, _event[_i]);
		}
	}
	
	else {
		_notifire.unsubscribe(_subscriber, _event);
	}
}