//GM doesn't usually enable gl_FragDepthEXT, but we can force it on
#extension GL_EXT_frag_depth : enable

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); //Default to red
    
    #ifdef GL_EXT_frag_depth
    gl_FragColor = vec4(0.0, 1.0, 0.0, 1.0); //If gl_FragDepthEXT is enabled, use green instead
    #endif
}