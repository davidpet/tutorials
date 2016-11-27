//Bullseye
// https://www.shadertoy.com/view/Xtl3Dj
void main() {
    vec4 val = texture2D(u_texture, v_tex_coord);
    vec4 grad = texture2D(u_gradient, v_tex_coord);
    
    if (val.a < 0.1 && grad.r < 1.0 && grad.a > 0.8) {
        //on shadertoy, this looks like rings rippling out from the center (with lots of black in between)
        //on iOS, looks like a window on that far away (can see pieces of rings passing through going up-right)
        
        //shadertoy: creates a linear spread of -1 to 1 along both axes
        //iOS: creates linear spread of -1 to 23 instead
        vec2 uv = gl_FragCoord.xy / u_size.xy*2.0-1.0;
        
        //time domain: sine wave w/ period 1.57 S (PI / 2) [ripple peaks hits any point at that period]
        //coordinate domain: sine wave w/ period 0.4 based on radius from center (of mapping created above)
        //output: 0 to 1 in sine pattern (based on radius and time as above)
        //shadertoy: coordinates centered at center of screen
        //iOS: coordinates centered near bottom left of the screen
        //      could make it act like shadertoy by sacling to v_tex_coord instead
        float len = sin(16.*length(uv)-u_time*4.)*0.5+0.5 ;
        
        //value above (0 to 1 sine) mapped as green component of new 3D vector (slightly attenuated)
        vec3 col = vec3(len)*vec3(0.,0.98,.0);
        
        //output color is col with alpha full on
        gl_FragColor = vec4(col,1.0);
    } else {
        gl_FragColor = val;
    }
}
