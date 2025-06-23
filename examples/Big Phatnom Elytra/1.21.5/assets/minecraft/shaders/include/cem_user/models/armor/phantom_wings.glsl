case 11:
    center.x *= -1;
    dirTBN.x *= -1;
case 12:
{
    center.y *= -1;
    dirTBN.y *= -1;
    modelSize /= 12;
    float angle = (TBN * vec3(0, -1, 0)).y;
    float controller = -pow(-min(angle, 0), 0.8) * 0.7;
    float flapController = clamp(0.5 - abs(angle - 0.25), 0, 0.5);
    float flapTime = GameTime * 15000;

    dirTBN *= 0.5;
    center = (center - vec3(2.5, 5, -1) * modelSize) * 0.5 + vec3(2.5, 4, -1) * modelSize;

    mat3 rotate = Rotate3(flapController * sin(flapTime), X);
    dirTBN = rotate * dirTBN;
    center = rotate * (center - vec3(2.5, 5, -1) * modelSize) + vec3(2.5, 5, -1) * modelSize;

    vec3 secLayOff = vec3(0, 0, modelSize * 0.25);

    vec3[] quad0 = vec3[](vec3(-2.5, -5, 1), vec3(-2.5, -2.5, 1),
                            vec3(2.5, -5, 1), vec3(2.5, -2.5, 1));

    vec3[] quad1 = quad0;

    vec3[] quad2 = vec3[](vec3(-2.5, -5, 1), vec3(-2.5, 0, 1),
            vec3(2.5, -5, 1), vec3(2.5, 0, 1));

    mat3 rotate1 = Rotate3(controller * 1.8, Z);
    mat3 rotation1 = rotate1;
    vec3 pivot = quad0[1];

    quad0[3] = rotation1 * (quad0[3] - pivot) + pivot;

    color = sQuad(-center, dirTBN, modelSize, quad0[0], quad0[1], quad0[2], quad0[3], color, minT, vec4(0, 16, 8, 16));
    color = sQuad(-center - secLayOff, dirTBN, modelSize, quad0[0], quad0[1], quad0[2], quad0[3], color, minT, vec4(32, 16, 8, 16));
    color = sQuad(-center, dirTBN, modelSize, quad0[0], quad0[1], quad0[0] + vec3(0, 0, 0.25), quad0[1] + vec3(0, 0, 0.25), color, minT, vec4(0, 16, 8, 1));

    vec3 d = vec3(0, 2.5, 0);
    for (int i = 0; i < 4; i++)
        quad1[i] += d;
    
    quad1[2] = quad0[3];

    rotation1 *= rotate1;

    quad1[1] = rotation1 * (quad1[1] - pivot) + pivot;
    quad1[3] = rotation1 * (quad1[3] - pivot) + pivot;

    d += rotation1 * vec3(0, 2.5, 0);
    for (int i = 0; i < 4; i++)
        quad2[i] += d;
    

    float rotAngle = 2;
    rotate1 = Rotate3(-controller * rotAngle, Z);
    rotation1 *= rotate1;
    pivot = quad1[1];

    quad1[3] = rotate1 * (quad1[3] - pivot) + pivot;

    color = sQuad(-center, dirTBN, modelSize, quad1[0], quad1[1], quad1[2], quad1[3], color, minT, vec4(8, 16, 8, 16));
    color = sQuad(-center - secLayOff, dirTBN, modelSize, quad1[0], quad1[1], quad1[2], quad1[3], color, minT, vec4(40, 16, 8, 16));
    color = sQuad(-center, dirTBN, modelSize, quad1[0], quad1[1], quad1[0] + vec3(0, 0, 0.25), quad1[1] + vec3(0, 0, 0.25), color, minT, vec4(8, 16, 8, 1));

    quad2[2] = quad1[3];

    rotation1 *= Rotate3(flapController * sin(flapTime + PI / 3) * 1.3, X) * Rotate3(-controller * rotAngle / 2, Z);
    // rotation1 *= Rotate3(-controller * rotAngle / 2, Z);

    quad2[3] = rotation1 * (quad2[3] - pivot) + pivot;

    rotation1 *= Rotate3(-controller * rotAngle / 2, Z);

    quad2[1] = rotation1 * (quad2[1] - pivot) + pivot;

    color = sQuad(-center, dirTBN, modelSize, quad2[0], quad2[1], quad2[2], quad2[3], color, minT, vec4(16, 16, 16, 16));
    color = sQuad(-center - secLayOff, dirTBN, modelSize, quad2[0], quad2[1], quad2[2], quad2[3], color, minT, vec4(48, 16, 16, 16));
    color = sQuad(-center, dirTBN, modelSize, quad2[0], quad2[1], quad2[0] + vec3(0, 0, 0.25), quad2[1] + vec3(0, 0, 0.25), color, minT, vec4(16, 16, 16, 1));
}
break;