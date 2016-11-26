//health value and circle clipping

void main() {
    vec4 val = texture2D(u_texture, v_tex_coord);
    vec4 grad = texture2D(u_gradient, v_tex_coord);

    //if transparent and health is high enough and not masked out, make it green
    if (val.a < 0.1 && grad.r < u_health && grad.a > 0.8) {
        gl_FragColor = vec4(0.0,1.0,0.0,1.0);
    } else {
        gl_FragColor = val;
    }
}
