//Wobble Spiral
// https://www.shadertoy.com/view/XtsGDj

void main() {
    vec4 val = texture2D(u_texture, v_tex_coord);
    vec4 grad = texture2D(u_gradient, v_tex_coord);
    
    if (val.a < 0.1 && grad.r < 0.65 && grad.a > 0.8) {
        float t = u_time;
        
        //shadertoy: creates a linear spread of -1 to 1 along both axes
        //iOS: creates linear spread of -1 to 23 instead
        vec2 uv = (gl_FragCoord.xy / u_size.xy)*2.0-1.0;
        
        //angle = angle of coordinate relative to origin point (plus time)
        //time domain: at any given point, angle increases by 1 radian per second
        //coordinate domain: at any given time, angle increases by 1 radian per radian relative to origin
        float angle = atan(uv.y,uv.x) + t;
        
        //sin wave completely in time domain (period = 2PI seconds, amplitude = 2)
        float k = true ? sin(t)*2.0 : 1.0;
        
        //angle is reduced by sine wave (time domain) * radius from origin
        angle -= length(uv) * k;
        
        //output color = green w/ magnitude that is cosine wave w/ respect to angle above
        //this is some kind of crazy polar coordinate math that's hard to understand
        //however, the only difference between iOS and shadertoy is that the origin is in a different spot
        vec3 gold = vec3(.0, 0.94, 0.0);
        gl_FragColor = vec4(gold*vec3(cos(8.*angle)),1.0);
    } else {
        gl_FragColor = val;
    }
}
