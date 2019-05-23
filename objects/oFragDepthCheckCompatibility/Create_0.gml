if shader_is_compiled(shdFragDepth)
{
    //If this device support gl_FragDepthEXT, go to the next room
    room_goto_next();
}
else
{
    //...otherwise throw an error :(
    show_error("gl_FragDepthEXT unsupported on this device.\n ", true);
}