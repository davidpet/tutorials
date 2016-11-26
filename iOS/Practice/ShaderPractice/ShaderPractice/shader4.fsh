//Bullseye
// https://www.shadertoy.com/view/Xtl3Dj
void main() {
    vec4 val = texture2D(u_texture, v_tex_coord);
    vec4 grad = texture2D(u_gradient, v_tex_coord);
    
    if (val.a < 0.1 && grad.r < 1.0 && grad.a > 0.8) {
        vec2 uv = gl_FragCoord.xy / u_size.xy*2.0-1.0;
        float len = sin(16.*length(uv)-u_time*4.)*0.5+0.5 ;
        vec3 col = vec3(len)*vec3(0.,0.98,.0);
        gl_FragColor = vec4(col,1.0);
    } else {
        gl_FragColor = val;
    }
}
