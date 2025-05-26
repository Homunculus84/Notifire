// Feather disable all

/// Fires an event, or multiple events.
/// If data is provided, it is passed directly to all notified subscribers in their callback function.
/// Passing multiple values can be done using a struct: notifire_emit("my.event", {x: 20, y: 10})
///
/// @param		{real|string|array}	event
/// @param		{any}				data
/// @returns    N/A

function notifire_emit(_event, _data = undefined){
	static _notifire = __notifire();

	if(is_array(_event)) {
		for(var _i = 0; _i < array_length(_event); _i++) {
			_notifire.emit(_event[_i], _data);
		}
	}
	
	else {
		_notifire.emit(_event, _data);
	}
}