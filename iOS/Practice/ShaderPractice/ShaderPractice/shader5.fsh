//playing around with math

void main() {
    float deltax = v_tex_coord.x - 0.5;
    float deltay = v_tex_coord.y - 0.5;
    float radius = length(vec2(deltax, deltay));
    float maxradius = length(vec2(0.5, 0));
    
    float intensity = radius / maxradius;
    intensity += u_time;
    intensity = fract(intensity);
    if (intensity <= 1.0)
        gl_FragColor = vec4(intensity, intensity, intensity, 1.0);
    else
        gl_FragColor = vec4(0.0);
}
