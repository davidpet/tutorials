vec3 getColor(float partitions, float partitionNumber, float partitionSize, float magnitude) {
    vec3 ret = vec3(0.0);
    
    magnitude = (magnitude - (partitionSize * partitionNumber)) / partitionSize;
    
    if (partitionNumber == 0.0) {   //red to yellow
        ret.r = 1.0;
        ret.g = magnitude;
    }
    else if (partitionNumber == 1.0) {  //yellow to green
        ret.g = 1.0;
        ret.r = 1.0 - magnitude;
    }
    else if (partitionNumber == 2.0) {  //green to cyan
        ret.g = 1.0;
        ret.b = magnitude;
    }
    else if (partitionNumber == 3.0) {  //cyan to blue
        ret.b = 1.0;
        ret.g = 1.0 - magnitude;
    }
    else if (partitionNumber == 4.0) {  //blue to purple
        ret.b = 1.0;
        ret.r = magnitude;
    }
    else if (partitionNumber == 5.0) {  //purple to red
        ret.r = 1.0;
        ret.b = 1.0 - magnitude;
    }
    
    return ret;
}

void main() {
    //u_aspect = float aspect ratio (width/height)
    
    //constants
    const float rFrequency = 0.4;
    const float tFrequency = -0.5;
    const float partitions = 6.0;
    
    //calculations
    vec2 point = vec2(v_tex_coord.x * u_aspect, v_tex_coord.y);
    float radius = length(point - vec2(u_aspect * 0.5, 0.5));
    float magnitude = fract(u_time * tFrequency + radius * rFrequency);
    
    //color partitioning
    float partitionSize = 1.0 / partitions;
    vec3 color = getColor(partitions, floor(magnitude / partitionSize), partitionSize, magnitude);
    
    //output
    gl_FragColor = vec4(color, 1.0);
}
