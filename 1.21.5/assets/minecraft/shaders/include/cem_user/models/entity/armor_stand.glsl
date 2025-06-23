//Armorstand
case 2: //Head
{
    modelSize /= 7;
    ADD_BOX(vec3(0, 1, -1), vec3(4),   //Pos, Size,
    vec4(16, 0, 8, 8), vec4(8, 0, 8, 8), //Down, Up,
    vec4(8, 8, 8, 8), vec4(0, 8, 8, 8), //North, East,
    vec4(24, 8, 8, 8), vec4(16, 8, 8, 8)) //South, West
}
break;
case 3: //Body
{
    modelSize /= 7;
    ADD_BOX(vec3(-2, 0, -1), vec3(4, 6, 2),   //Pos, Size,
    vec4(28, 16, 8, 4), vec4(20, 16, 8, 4), //Down, Up,
    vec4(20, 20, 8, 12), vec4(16, 20, 4, 12), //North, East,
    vec4(32, 20, 8, 12), vec4(28, 20, 4, 12)) //South, West
}
break;
case 4: //Left Hand
{
    modelSize /= 12;
    ADD_BOX(vec3(0, 0, -1), vec3(2, 6, 2),   //Pos, Size,
    vec4(40, 48, 4, 4), vec4(36, 48, 4, 4), //Down, Up,
    vec4(36, 52, 4, 12), vec4(32, 52, 4, 12), //North, East,
    vec4(44, 52, 4, 12), vec4(40, 52, 4, 12)) //South, West
}
break;
case 5: //Right Hand
{
    modelSize /= 12;
    ADD_BOX(vec3(0, 0, -1), vec3(2, 6, 2),   //Pos, Size,
    vec4(48, 16, 4, 4), vec4(44, 16, 4, 4), //Down, Up,
    vec4(44, 20, 4, 12), vec4(40, 20, 4, 12), //North, East,
    vec4(52, 20, 4, 12), vec4(48, 20, 4, 12)) //South, West
}
break;
case 6: //Left Leg
{
    modelSize /= 11;
    ADD_BOX(vec3(0, -1, -1), vec3(2, 6, 2),   //Pos, Size,
    vec4(40, 48, 4, 4), vec4(20, 48, 4, 4), //Down, Up,
    vec4(20, 52, 4, 12), vec4(16, 52, 4, 12), //North, East,
    vec4(28, 52, 4, 12), vec4(24, 52, 4, 12)) //South, West
}
break;
case 7: //Right Leg
{
    modelSize /= 11;
    ADD_BOX(vec3(0, -1, -1), vec3(2, 6, 2),   //Pos, Size,
    vec4(8, 16, 4, 4), vec4(4, 16, 4, 4), //Down, Up,
    vec4(4, 20, 4, 12), vec4(0, 20, 4, 12), //North, East,
    vec4(12, 20, 4, 12), vec4(8, 20, 4, 12)) //South, West
}
break;