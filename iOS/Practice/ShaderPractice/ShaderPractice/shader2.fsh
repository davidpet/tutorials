//fill transparent pixels with green

void main() {
    vec4 val = texture2D(u_texture, v_tex_coord);
    if (val.a == 0.0) {
        gl_FragColor = vec4(0.0,1.0,0.0,1.0);
    } else {
        gl_FragColor = val;
    }
}
