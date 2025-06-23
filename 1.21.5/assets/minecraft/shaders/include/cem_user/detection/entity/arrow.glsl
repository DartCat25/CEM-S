if (texelFetch(Sampler0, ivec2(31, 0), 0) * 255 == vec4(0, 0, 1, 255)) //Arrow
{
    if (gl_VertexID / 4 % 9 == 0)
    {
        cem = 9;
        cem_reverse = 1;
        corner = corners[(gl_VertexID) % 4].yx;
        cem_size = 1.5;
    }
    else
    {
        gl_Position = vec4(0);
    }
}