/// @jujuadams 2019/05/21
///
/// Returns <true> if gl_FragDepthEXT was successfully enabled, <false> otherwise

//Create a teeny tiny 1x1 surface
var _surface = surface_create(1, 1);

//Create a buffer big enough for one pixel of RGBA data (4 bytes per pixel)
var _buffer = buffer_create(4, buffer_grow, 1);

//Use a shader to determine if gl_FragDepthEXT was successfully enabled (shader code below)
surface_set_target(_surface);
shader_set(shdFragDepthCheckCompatibility);
draw_surface(_surface, 0, 0);
shader_reset();
surface_reset_target();

//Copy the surface to the buffer
buffer_get_surface(_buffer, _surface, buffer_surface_copy, 0, 0);

//Grab the contents of the green channel
var _test = buffer_peek(_buffer, 1, buffer_u8);

//Free up the memory we used for the surface and buffer
surface_free(_surface);
buffer_delete(_buffer);

//Return a bool
return (_test > 0);



/*
shdFragDepthCheckCompatibility:

##### Vertex #####

attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(in_Position.xyz, 1.0);
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

##### Fragment #####

//GM doesn't usually enable gl_FragDepthEXT, but we can force it on
#extension GL_EXT_frag_depth : enable

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); //Default to red
    
    //If we've successfully enabled the extension, make this pixel white
    #ifdef GL_EXT_frag_depth
    gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0); //If gl_FragDepthEXT is enabled, use green instead
    #endif
}
*/