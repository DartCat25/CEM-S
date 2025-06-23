if (gl_VertexID / 4 % 24 == 9 && armorTestColorIn.a == 252)
{
    if (armorTestColorIn.rgb == vec3(255, 0, 1))
    {
        cem = 10;
        cem_reverse = 1;
    }
    else
    {
        gl_Position = vec4(0);
    }
    cem_size = 1.5;
}