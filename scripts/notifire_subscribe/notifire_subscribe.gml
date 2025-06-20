// Feather disable all

/// Subscribes the current instance to an event, or multiple events if an array is passed.
/// Optionally, the instance can be specified explicitly.
///
/// The callback function fn will be triggered, in the scope of the subscribed instance,
/// when the event gets triggered. The function will get two parameters: event and data.
///
/// Example:
///
/// notifire_subscribe("health.decresed", function(event, data) {
///		show_debug_message("Event {0} was triggered! Health decreased by {1}", event, data.amount);
/// });
///
/// @param		{real|string|array}	event
/// @param		{function}			fn
/// @param		{instance}			[instance]
/// @returns    N/A

function notifire_subscribe(_event, _fn, _instance = self){
	static _notifire = __Notifire();
	
	var _subscriber = _instance.id;
	
	if(is_array(_event)) {
		for(var _i = 0; _i < array_length(_event); _i++) {
			_notifire.subscribe(_subscriber, _event[_i], _fn);
		}
	}
	
	else {
		_notifire.subscribe(_subscriber, _event, _fn);
	}
}