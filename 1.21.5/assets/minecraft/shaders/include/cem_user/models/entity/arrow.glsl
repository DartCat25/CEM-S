case 9: //Arrow
{
    modelSize /= 4;
    //Rotate boxes
    mat3 rotMat = Rotate3(-PI / 4 * 3, Z) * Rotate3(PI / 4 * 3, X);

    center = rotMat * center;
    dirTBN = rotMat * dirTBN;
    rotMat = TBN * inverse(rotMat);

    vec3 norm;
    if (boxIntersect(-center, dirTBN, vec3(8, 8, 0.5) * modelSize, norm).z == MAX_DEPTH) //Out of arrow box
        discard;

    //Main box
    color = sBox(-center, dirTBN, vec3(8, 8, 0.5) * modelSize, rotMat, color, minT, vec4(0, 16, 0, 0), vec4(0, 16, 0, 0), vec4(32, 32, -16, -16), vec4(0, 16, 0, 0), vec4(16, 32, 16, -16), vec4(0, 16, 0, 0));

    if (minT != MAX_DEPTH)
        break;

    //Inner grid
    for(int i = -7; i < 8; i++)
    {
        color = sBox(-center + vec3(i * modelSize, 0, 0), dirTBN, vec3(0, 8, 0.5) * modelSize, rotMat, color, minT, vec4(0), vec4(0), vec4(0), vec4(i + 24, 32, 1, -16), vec4(0), vec4(i + 23, 32, 1, -16));
        color = sBox(-center + vec3(0, i * modelSize, 0), dirTBN, vec3(8, 0, 0.5) * modelSize, rotMat, color, minT, vec4(32, i + 24, -16, 1), vec4(32, i + 23, -16, 1), vec4(0), vec4(0), vec4(0), vec4(0));
    }
}
break;