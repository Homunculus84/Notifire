if(mouse_check_button_pressed(mb_left)) {
	if (position_meeting(mouse_x, mouse_y, id)) {
	    dragging = true;
	}
}

if(mouse_check_button_released(mb_left)) {
	if(dragging) {
		dragging = false;
		
		var _inst = (instance_position(mouse_x, mouse_y, obj_button));
		
		if (_inst != noone) {
			notifire_subscribe(string("button.{0}", _inst.color), function(_event, _data) {
				image_index = _data;
			});
			
			if(!array_contains(buttons, _inst)) {
				array_push(buttons, _inst);
			}
		}
		
	}
}