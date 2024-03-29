package main



import "core:fmt"
import "core:strings"

import "raylib"
import "skald"
//import "skald2"


tex: raylib.Texture;

test_proc1 :: proc() { fmt.printf("fuck1\n"); }
test_proc2 :: proc() { fmt.printf("fuck2\n"); }

new_test :: proc() {
	fmt.printf("fuck1\n");

	text: [dynamic]string;
	append(&text, "Fuck me?","No fuck me!");
	menuOptions: [dynamic]skald.MenuOption;
	append(&menuOptions, skald.MenuOption{text="X",effect=new_test});
	res := skald.create_textbox(
		textboxRect={  0, 460, 1280, 260},
		optionsRect={100, 460,  200, 100},
		texture=tex,
		textDynamic=text, fontColor=raylib.RED,
		options=menuOptions);
	//	textboxRect={  0, 460, 1280, 260},
	//	optionsRect={100, 460,  200, 100},
	//	fontSize=16,
	//	offset={32,32},
	//	textSingle="Choose target",
	//	options=options);
	skald.output_error(res);
}

//= Main
main :: proc() {

	{ // Initialization
		raylib.init_window(1280, 720, "Skald Testing");
		raylib.set_target_fps(60);
	}

	res := skald.init_skald(speed=1);
	if skald.output_error(res) do return;

	img := raylib.load_image("data/skald/textbox.png");
	tex  = raylib.load_texture_from_image(img);
	raylib.unload_image(img);

	font := raylib.load_font("data/skald/kong.ttf");

	text: [dynamic]string;
	append(&text, "Fuck me?","No fuck me!");

	menuOptions: [dynamic]skald.MenuOption;
	append(&menuOptions, skald.MenuOption{text="Fight",effect=new_test}, skald.MenuOption{text="Items",effect=test_proc2}, skald.MenuOption{text="Run",effect=skald.default_option});

	res = skald.create_textbox(
		font=font, fontSize=16,
		textboxRect=raylib.Rectangle{100,100,600,200},
		texture=tex,
		textDynamic=text, fontColor=raylib.RED,
		options=menuOptions);
	if skald.output_error(res) do return;


	for !raylib.window_should_close() {
		// Updating
		{
			res = skald.update_textboxes();
			if skald.output_error(res) do return;
		}

		// Drawing
		{
			raylib.begin_drawing();
				raylib.clear_background(raylib.RAYWHITE);
					
					res = skald.draw_textboxes();
					if skald.output_error(res) do return;

					raylib.draw_fps((8 * 3), (8 * 5));
			raylib.end_drawing();
		}
	}

	res = skald.free_skald();
	if skald.output_error(res) do return;

	raylib.close_window();
}
