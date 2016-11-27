//water movement effect
//from https://github.com/ymc-thzi/ios8-spritekit-custom-shader/blob/master/ios8-spritekit-custom-shader/shader_water_movement.fsh
//adapted to compile

//waves are hard to see on this graphic (look closely)
//main difference in this one over previous ones is it actually does a positional shift of existing graphic
void main(void) {
    vec2 uv = v_tex_coord;
    
    uv.y += (cos((uv.y + (u_time * 0.08)) * 85.0) * 0.0019) +
    (cos((uv.y + (u_time * 0.1)) * 10.0) * 0.002);
    
    uv.x += (sin((uv.y + (u_time * 0.13)) * 55.0) * 0.0029) +
    (sin((uv.y + (u_time * 0.1)) * 15.0) * 0.002);
    
    vec4 texColor = texture2D(u_texture,uv);    //retrieve point from texture after mutating the position to get
    gl_FragColor = texColor;
}
