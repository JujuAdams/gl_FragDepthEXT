//GM doesn't usually enable gl_FragDepthEXT, but we can force it on
#extension GL_EXT_frag_depth : require

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

float colourGetIntensity(vec4 colour)
{
    return (colour.r + colour.g + colour.b)/3.0;
}

void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    
    //gl_FragDepthEXT can be used to set the depth of each pixel (technically each texel) individually
    //Depth is a value from 0.0 -> 1.0. Typically depth=1.0 is the very back of the scene and depth=0.0 is the very front
    //Use the inverse of the intensity value as the depth so that pure white is at the very front (depth=0.0)
    //...we also but force depth to 1.0 (the very back) if the alpha is less than 100%
    gl_FragDepthEXT = (gl_FragColor.a < 1.0)? 1.0 : (1.0-colourGetIntensity(gl_FragColor));
}