case 13:
{
    modelSize /= 8;
    //Set face back
    ADD_SQUARE(vec3(-4, -4, 0), vec3(4, -4, 0), vec3(-4, 4, 0), vec4(8))

    ADD_BOX_ROTATE(vec3(-4.35, 0, -4), vec3(0.5, 2.5, 2),   //Pos, Size,
    Rotate3((sin(GameTime * 1000) * 0.5 + 1.5) * PI * -0.05, Z), vec3(0.5, 2.5, 0),
    vec4(5, 26, 1, 4), vec4(4, 26, 1, 4), //Down, Up,
    vec4(5, 30, 1, 5), vec4(0, 30, 4, 5), //North, East,
    vec4(9, 30, 1, 5), vec4(5, 30, 4, 5)) //South, West

    ADD_BOX_ROTATE(vec3(4.35, 0, -4), vec3(0.5, 2.5, 2),   //Pos, Size,
    Rotate3((sin(GameTime * 1000) * 0.5 + 1.5) * PI * 0.05, Z), vec3(-0.5, 2.5, 0),
    vec4(5, 26, 1, 4), vec4(4, 26, 1, 4), //Down, Up,
    vec4(5, 30, 1, 5), vec4(0, 30, 4, 5), //North, East,
    vec4(9, 30, 1, 5), vec4(5, 30, 4, 5)) //South, West
}
break;