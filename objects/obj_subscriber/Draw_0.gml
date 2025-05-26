if (dragging) {
    draw_set_color(c_white);
    draw_line(x, y, mouse_x, mouse_y);
}

for(var _i = 0; _i < array_length(buttons); _i++) {
	var _button = buttons[_i];
	
	draw_set_color(c_white);
	draw_line(x, y, _button.x, _button.y);
}

draw_self();