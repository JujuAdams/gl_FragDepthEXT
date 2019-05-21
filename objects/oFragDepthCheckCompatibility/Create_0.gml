if check_gl_FragDepthEXT()
{
    room_goto_next();
}
else
{
    show_error("gl_FragDepthEXT unsupported on this device.\n ", true);
}