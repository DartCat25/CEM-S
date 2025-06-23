if (testColor == vec4(0, 0, 240, 255) / 255)
{
    vec2 tUV = corners[(gl_VertexID + 3) % 4];
    vec2 rUV = corners2[(gl_VertexID + 2) % 4];

    if (uv - tUV * vec2(2, 7) == vec2(2)) //Head
    {
        cem = 2;
        cem_reverse = 1;
    }
    else if (uv - tUV * vec2(2, 7) == vec2(18, 2)) //Body
    {
        cem = 3;
        cem_reverse = 1;
    }
    else if (uv - rUV * vec2(2, 12) == vec2(34, 18)) //Left Hand
    {
        cem = 4;
    }
    else if (uv - tUV * vec2(2, 12) == vec2(26, 2)) //Right Hand
    {
        cem = 5;
        cem_reverse = 1;
    }
    else if (uv - rUV * vec2(2, 11) == vec2(42, 18)) //Left Leg
    {
        cem = 6;
    }
    else if (uv - tUV * vec2(2, 11) == vec2(10, 2)) //Right Leg
    {
        cem = 7;
        cem_reverse = 1;
    }
    else gl_Position = vec4(0);
}