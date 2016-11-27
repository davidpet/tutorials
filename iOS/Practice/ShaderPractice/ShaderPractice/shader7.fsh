// testing gl_FragCoord

void main() {
    float magnitude = gl_FragCoord.x / u_size.x / 12.;
    vec3 color = vec3(magnitude);
    gl_FragColor = vec4(color, 1.0);
}
