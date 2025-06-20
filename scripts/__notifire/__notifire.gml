// Feather disable all

#macro NOTIFIRE_VERSION		"1.0.0"
#macro NOTIFIRE_DEBUG		false

__Notifire();

function __Notifire() {
	static _notifire = undefined;
	if(!is_undefined(_notifire)) { return _notifire;}
	
	_notifire = {};
	with(_notifire) {
		
		__subscriptions			= {};
		__index_subscribers		= {};
		__index_events			= {};
		
		__logger				= __NotifireLogger();
	
		#region private
	
		__index_add = function(_index, _key, _subscription) {
			var _subscriptions = _index[$ _key];
		
			if(is_undefined(_subscriptions)) {
				_index[$ _key] = [_subscription];
			}
			else {
				array_push(_subscriptions, _subscription);
			}
		}
	
		__index_remove = function(_index, _key, _subscription) {
			var _subscriptions = _index[$ _key];
			var _i = array_get_index(_subscriptions, _subscription);
	
			if(_i < 0) { __logger.error("Mismatching subscription index"); }
	
			array_delete(_subscriptions, _i, 1);
		
			if(array_length(_subscriptions) == 0) {
				struct_remove(_index, _key);
			}
		}
	
		__subscriber_events = function(_subscriber) {
			var _subscriptions = __index_subscribers[$ _subscriber];
			if(is_undefined(_subscriptions)) { return []; }

			var _events = array_map(_subscriptions, function(_subscription) {
				return _subscription.event;
			});
		
			return _events;
		}
	
		__hash = function(_subscriber, _event) {
			return variable_get_hash(string("{0}::{1}", _subscriber, _event));
		}
	
		#endregion

		#region public

		subscribe = function(_subscriber, _event, _fn) {
			var _hash = __hash(_subscriber, _event);
		
			if(struct_exists_from_hash(__subscriptions, _hash)) { return; }
		
			var _subscription = new __NotifireSubscription(_subscriber, _event, _fn);
			struct_set_from_hash(__subscriptions, _hash, _subscription);
		
			__index_add(__index_subscribers, _subscriber, _subscription);
			__index_add(__index_events, _event, _subscription);
			
			if(NOTIFIRE_DEBUG) { __logger.trace(string("Subscribed {0}", _subscription)); }
		}

		unsubscribe = function(_subscriber, _event = undefined) {
			if(is_undefined(_event)) {
				var _events = __subscriber_events(_subscriber);
			
				for(var _i = 0; _i < array_length(_events); _i++) {
					unsubscribe(_subscriber, _events[_i]);
				}
			
				return;
			}
		
			var _hash = __hash(_subscriber, _event);
			var _subscription = struct_get_from_hash(__subscriptions, _hash);
		
			if(is_undefined(_subscription)) { return; }
		
			struct_remove_from_hash(__subscriptions, _hash);
		
			__index_remove(__index_events, _event, _subscription);
			__index_remove(__index_subscribers, _subscriber, _subscription);
			
			if(NOTIFIRE_DEBUG) { __logger.trace(string("Unsubscribed {0}", _subscription)); }
		}

		emit = function(_event, _payload) {	
			if(NOTIFIRE_DEBUG) { __logger.trace(string("Event {0} broadcasted with payload {1}",_event, _payload)); }
			
			var _subscriptions = __index_events[$ _event];
			if(is_undefined(_subscriptions)) { return; }
		
			for(var _i = 0; _i < array_length(_subscriptions); _i++) {
				var _subscription = _subscriptions[_i];
				
				if(!instance_exists(_subscription.subscriber)) { __logger.error("Trying to notify an instance that no longer exists"); }
				if(!is_callable(_subscription.fn)) { __logger.error("Instance callback is not a function"); }
				
				_subscription.fn(_event, _payload);
				
				if(NOTIFIRE_DEBUG) { __logger.trace(string("Notified {0}}", _subscription)); }
			}
		}
	
		#endregion
	
	}
	
	return _notifire;
}