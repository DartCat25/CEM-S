#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <matf.glsl>

uniform sampler2D Sampler0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

#moj_import <cem/frag_funcs.glsl>

void main() {
    gl_FragDepth = gl_FragCoord.z;
    float vDistance = vertexDistance;

    vec4 color;

    if (cem != 0)
    {
        #define MINUS_Z
        #moj_import <cem/frag_main_setup.glsl>

        switch (cem)
        {
            case 1:
                center.x *= -1;
                dirTBN.x *= -1;
            case 2:
            {
                modelSize /= 12;
                float angle = (TBN * vec3(0, 1, 0)).y;
                float controller = -pow(-min(angle, 0), 0.8) * 0.7;
                // float flapController = clamp(0.5 - abs(angle - 0.25), 0, 0.5);
                // float flapTime = GameTime * 15000;

                dirTBN *= 0.5;
                center = (center - vec3(2.5, 5, -1) * modelSize) * 0.5 + vec3(2.5, 4, -1) * modelSize;

                // mat3 rotate = Rotate3(flapController * sin(flapTime), X);
                // dirTBN = rotate * dirTBN;
                // center = rotate * (center - vec3(2.5, 5, -1) * modelSize) + vec3(2.5, 5, -1) * modelSize;

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

                // rotation1 *= Rotate3(flapController * sin(flapTime + PI / 3), X) * Rotate3(-controller * rotAngle / 2, Z);
                rotation1 *= Rotate3(-controller * rotAngle / 2, Z);

                quad2[3] = rotation1 * (quad2[3] - pivot) + pivot;

                rotation1 *= Rotate3(-controller * rotAngle / 2, Z);

                quad2[1] = rotation1 * (quad2[1] - pivot) + pivot;

                color = sQuad(-center, dirTBN, modelSize, quad2[0], quad2[1], quad2[2], quad2[3], color, minT, vec4(16, 16, 16, 16));
                color = sQuad(-center - secLayOff, dirTBN, modelSize, quad2[0], quad2[1], quad2[2], quad2[3], color, minT, vec4(48, 16, 16, 16));
                color = sQuad(-center, dirTBN, modelSize, quad2[0], quad2[1], quad2[0] + vec3(0, 0, 0.25), quad2[1] + vec3(0, 0, 0.25), color, minT, vec4(16, 16, 16, 1));

                color *= vertexColor;

                break;
            }
        }

        if (minT == MAX_DEPTH)
            discard;
            
        writeDepth(dir * minT);
        vDistance = minT;
        color *= cem_light * ColorModulator;
    }
    else
    {
        color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
        if (round(color.a * 255) == 252)
            discard;
    }

    if (color.a < 0.1) discard;

    fragColor = linear_fog(color, vDistance, FogStart, FogEnd, FogColor);
}
