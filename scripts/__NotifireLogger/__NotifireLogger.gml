// Feather disable all

function __NotifireLogger() {
	static _logger = undefined;
	if(!is_undefined(_logger)) { return _logger;}
	
	_logger = {};
	with(_logger) {
	
		error = function(_error){
			show_error(string("Notifire {0}: {1}\n", NOTIFIRE_VERSION, _error), true);
		}

		trace = function(_message){
			show_debug_message(string("Notifire: {0}\n", _message));
		}
		
		log = function() {
			trace(" Subscriptions: " + json_stringify(__Notifire().__subscriptions, true));
			trace(" Events Index: " + json_stringify(__Notifire().__index_events, true));
			trace(" Subscribers Index: " + json_stringify(__Notifire().__index_subscribers, true));
		}
	
	}
	
	return _logger;
}
