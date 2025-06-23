case 8:
{
    // vec3 square = squareIntersect(-center, dirTBN, vec3(-0.5, -0.5, 0) * sizes.xyy, vec3(0.5, -0.5, 0) * sizes.xyy, vec3(-0.5, 0.5, 0) * sizes.xyy);
    // if (minT > square.z)
    // {
    //     minT = square.z;
    //     color = vec4(square.xy, 0, 1);
    // }

    // color = sSquare(-center, dirTBN, vec3(-0.5, -0.5, 0) * sizes.xyy, vec3(0.5, -0.5, 0) * sizes.xyy, vec3(-0.5, 0.5, 0) * sizes.xyy, vertexColor, color, minT, vec4(stp, res));

    vec3 cN;
    vec3 cube = boxIntersect(-center - vec3(0, 0, 0.06), dirTBN, vec3(sizes * 0.55, 0.08), cN);
    if (cube.z == MAX_DEPTH)
        discard;

    vec3 square;
    
    #define LAYERS 60
    float len = 500;
        
    for (float i = 0; i < LAYERS; i++)
    {
        float offset = (50 - i) / 500;
        vec2 size = sizes.xy * 0.5 + mix(vec2(0), vec2(offset * 1.1), -i / LAYERS);
        square = squareIntersect(-center, dirTBN, vec3(size * vec2(-1, -1), offset), vec3(size * vec2(1, -1), offset), vec3(size * vec2(-1, 1), offset));

        if (minT < square.z)
            continue;

        vec4 furColor = texelFetch(Sampler0, ivec2(stp + res - square.xy * res), 0);

        if (furColor.a < 0.1)
            continue;

        vec2 cell = square.xy * res * 32;
        
        float noise = noise(ivec2(cell), 1) % 3 / 2.0;
        noise *= noise * noise * noise;
        float radius = length(cell - floor(cell) - 0.5);

        if (radius > noise * ((1 - i / LAYERS) * 5))
            continue;                    

        color = vec2(i / LAYERS * 2 - 0.9, 1).xxxy * furColor;
        minT = square.z;

        color *= vertexColor;
    }
}
break;