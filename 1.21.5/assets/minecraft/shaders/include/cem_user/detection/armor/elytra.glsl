if (round(texelFetch(Sampler0, ivec2(1, 0), 0) * 255) == vec4(0, 0, 4, 255))
{
    cem_size = 2;
    if (gl_VertexID / 4 % 12 == 5)
    {
        cem = 12;
        cem_reverse = 1;
        corner.xy = 1-corner.xy;
        corner.x -= 0.7;
        corner.x *= 3;
        
    }
    else if (gl_VertexID / 4 % 12 == 11)
    {
        cem = 11;
        corner.xy = 1-corner.xy;
        corner.x += 0.15;
        corner.x *= 2;
    }
    else
    {
        gl_Position = vec4(0);
    }
}