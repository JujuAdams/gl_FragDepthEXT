//Make blend colours
var _t = clamp(abs(((current_time/3000) mod 2.4) - 1.2) - 0.1, 0.0, 1.0);
var _depth_0 = clamp(2.0*_t    , 0.0, 1.0);
var _depth_1 = clamp(2.0*_t-1.0, 0.0, 1.0);
var _depth_colour_l = make_colour_hsv(0, 0, 255*_depth_0);
var _depth_colour_r = make_colour_hsv(0, 0, 255*_depth_1);

//Show a visual representation of what's going on
draw_sprite_ext(sTest, 0,   257, 259,   5, 5, 0,   c_white, 1.0);
draw_sprite_general(sTest, 1,   0, 0, 50, 50,   257, 259,   5, 5, 0,   _depth_colour_l, _depth_colour_r, _depth_colour_r, _depth_colour_l, 1.0);

//Turn on Z testing
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_zfunc(cmpfunc_lessequal); //btw cmpfunc_lessequal is the default zfunc, but it's good to be explicit

shader_set(shdFragDepth);

//Draw the mask to the depth buffer, but don't draw RGBA colour
gpu_set_colorwriteenable(false, false, false, false);
draw_sprite_general(sTest, 1,   0, 0, 50, 50,   517, 259,   5, 5, 0,   _depth_colour_l, _depth_colour_r, _depth_colour_r, _depth_colour_l, 1.0);

//Now draw another image masked by the fragment depth of the mask
gpu_set_colorwriteenable(true, true, true, true);
draw_sprite_ext(sTest, 0,   517, 259,   5, 5, 0,   $FEFEFE, 1.0); //We use a sliiightly off-white colour here. Pure white (which becomes depth=0.0) can't be masked

shader_reset();

//Turn off Z testing, it's bad for your health
gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_zfunc(cmpfunc_lessequal);

//Draw some debug text
var _string = "Per-pixel z-testing example (using gl_FragDepthEXT)\n@jujuadams 2019/05/20\n\nleft  = " + string_format(_depth_0, 0, 4) + "\nright = " + string_format(_depth_1, 0, 4);
draw_set_colour(c_black);
draw_set_alpha(0.4);
draw_text(10, 12, _string);
draw_set_alpha(1.0);
draw_text( 9, 10, _string);
draw_text(10,  9, _string);
draw_text(11, 10, _string);
draw_text(10, 11, _string);
draw_set_colour(c_white);
draw_text(10, 10, _string);