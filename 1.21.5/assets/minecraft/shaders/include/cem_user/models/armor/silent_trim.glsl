case 10:
{
    modelSize /= 8;
    vec4 testColor = round(texelFetch(Sampler0, ivec2(stp - vec2(0, 1)), 0) * 255);
    if (testColor.rgb == vec3(203, 255, 245) || testColor.rgb == vec3(21, 179, 161))
        stp.y += 10;
    ADD_BOX(vec3(-8.5, 5, -4), vec3(5, 5, 0),
            vec4(0, 0, 0, 0), vec4(0, 0, 0, 0),
            vec4(stp + vec2(14, -8), 10, 10), vec4(0, 0, 0, 0),
            vec4(stp + vec2(24, -8), -10, 10), vec4(0, 0, 0, 0))
    ADD_BOX(vec3(8.5, 5, -4), vec3(5, 5, 0),
            vec4(0, 0, 0, 0), vec4(0, 0, 0, 0),
            vec4(stp + vec2(24, -8), -10, 10), vec4(0, 0, 0, 0),
            vec4(stp + vec2(14, -8), 10, 10), vec4(0, 0, 0, 0))
}
break;