#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <matf.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

#moj_import <cem/frag_funcs.glsl>

void main() {
    gl_FragDepth = gl_FragCoord.z;
    float vDistance = vertexDistance;
    vec4 color = texture(Sampler0, texCoord0);

    if (cem != 0)
    {
        #moj_import <cem/frag_main_setup.glsl>

        switch (cem)
        {
            case 1: //Trident
            {
                modelSize /= 25;
                //Rotate boxes
                mat3 rotMat = Rotate3(PI / 4, Z);

                center = rotMat * center + vec3(8, 8, 0.5) * modelSize;
                dirTBN = rotMat * dirTBN;
                rotMat = TBN * inverse(rotMat);

                //Main box
                // color = sBox(-center, dirTBN, vec3(8, 8, 0.5) * modelSize, rotMat, color, minT, vec4(0, 16, 0, 0), vec4(0, 16, 0, 0), vec4(32, 32, -16, -16), vec4(0, 16, 0, 0), vec4(16, 32, 16, -16), vec4(0, 16, 0, 0));

                // if (minT != MAX_DEPTH)
                //     break;
                const int[] let = int[](0, 2, 0, 2, 2, 0, 0, 2, 2, 2, 0, 2, 2, 0, 0);

                color = sBox(-center + vec3(-0.5, -1, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(12, 16, 2, 1), vec4(11, 16, 2, 1),
                vec4(9, 17, 2, 1), vec4(11, 17, 1, 1),
                vec4(12, 17, 2, 1), vec4(8, 17, 1, 1));
                

                for(int i = 0; i < 15; i++)
                {
                    color = sBox(-center + vec3(i * modelSize, i * modelSize, 0), dirTBN, vec3(1.5, 0.5, 0.5) * modelSize, rotMat, color, minT,
                    vec4(12, 12 + let[i], 3, 1), vec4(9, 12 + let[i], 3, 1),
                    vec4(13, 13 + let[i], 3, 1), vec4(8, 13 + let[i], 1, 1),
                    vec4(9, 13 + let[i], 3, 1), vec4(12, 13 + let[i], 1, 1));
                }

                color = sBox(-center + vec3(16.5, 15, 0) * modelSize, dirTBN, vec3(3, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(15, 10, -6, 1), vec4(21, 10, -6, 1),
                vec4(16, 11, 6, 1), vec4(8, 11, 1, 1),
                vec4(9, 11, 6, 1), vec4(15, 11, 1, 1));

                color = sBox(-center + vec3(17.5, 16, 0) * modelSize, dirTBN, vec3(3, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(15, 8, -6, 1), vec4(21, 8, -6, 1),
                vec4(16, 9, 6, 1), vec4(8, 9, 1, 1),
                vec4(9, 9, 6, 1), vec4(15, 9, 1, 1));

                color = sBox(-center + vec3(16.5, 17, 0) * modelSize, dirTBN, vec3(2, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(0), vec4(0),
                vec4(28, 31, 4, 1), vec4(22, 31, 1, 1),
                vec4(23, 31, 4, 1), vec4(27, 31, 1, 1));

                color = sBox(-center + vec3(20.5, 17, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(18, 18, -2, 1), vec4(20, 18, -2, 1),
                vec4(19, 19, 2, 1), vec4(18, 19, 1, 1),
                vec4(16, 19, 2, 1), vec4(15, 19, 1, 1));

                color = sBox(-center + vec3(21.5, 18, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(18, 18, -2, 1), vec4(20, 18, -2, 1),
                vec4(19, 19, 2, 1), vec4(18, 19, 1, 1),
                vec4(16, 19, 2, 1), vec4(15, 19, 1, 1));

                color = sBox(-center + vec3(17, 18, 0) * modelSize, dirTBN, vec3(2.5, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(26, 28, -5, 1), vec4(31, 28, -5, 1),
                vec4(27, 29, 5, 1), vec4(26, 29, 1, 1),
                vec4(21, 29, 5, 1), vec4(20, 29, 1, 1));

                color = sBox(-center + vec3(15.5, 19, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(18, 18, -2, 1), vec4(20, 18, -2, 1),
                vec4(19, 19, 2, 1), vec4(18, 19, 1, 1),
                vec4(16, 19, 2, 1), vec4(15, 19, 1, 1));

                color = sBox(-center + vec3(16.5, 20, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(18, 18, -2, 1), vec4(20, 18, -2, 1),
                vec4(19, 19, 2, 1), vec4(18, 19, 1, 1),
                vec4(16, 19, 2, 1), vec4(15, 19, 1, 1));

                color = sBox(-center + vec3(17.5, 21, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(18, 18, -2, 1), vec4(20, 18, -2, 1),
                vec4(19, 19, 2, 1), vec4(18, 19, 1, 1),
                vec4(16, 19, 2, 1), vec4(15, 19, 1, 1));

                color = sBox(-center + vec3(19, 19, 0) * modelSize, dirTBN, vec3(1.5, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(12, 28, 3, 1), vec4(9, 28, 3, 1),
                vec4(13, 29, 3, 1), vec4(12, 29, 1, 1),
                vec4(9, 29, 3, 1), vec4(8, 29, 1, 1));

                color = sBox(-center + vec3(20, 20, 0) * modelSize, dirTBN, vec3(1.5, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(12, 28, 3, 1), vec4(9, 28, 3, 1),
                vec4(13, 29, 3, 1), vec4(12, 29, 1, 1),
                vec4(9, 29, 3, 1), vec4(8, 29, 1, 1));

                color = sBox(-center + vec3(20.5, 21, 0) * modelSize, dirTBN, vec3(1, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(11, 30, -2, 1), vec4(13, 30, -2, 1),
                vec4(12, 31, 2, 1), vec4(8, 31, 1, 1),
                vec4(9, 31, 2, 1), vec4(11, 31, 1, 1));

                color = sBox(-center + vec3(18, 22, 0) * modelSize, dirTBN, vec3(0.5, 0.5, 0.5) * modelSize, rotMat, color, minT,
                vec4(9, 27, 1, 1), vec4(9, 27, 1, 1),
                vec4(9, 27, 1, 1), vec4(9, 27, 1, 1),
                vec4(9, 27, 1, 1), vec4(9, 27, 1, 1));

                //Inner grid
                // for(int i = -7; i < 8; i++)
                // {
                //     color = sBox(-center + vec3(i * modelSize, 0, 0), dirTBN, vec3(0, 8, 0.5) * modelSize, rotMat, color, minT, vec4(0), vec4(0), vec4(0), vec4(i + 24, 32, 1, -16), vec4(0), vec4(i + 23, 32, 1, -16));
                //     color = sBox(-center + vec3(0, i * modelSize, 0), dirTBN, vec3(8, 0, 0.5) * modelSize, rotMat, color, minT, vec4(32, i + 23, -16, 1), vec4(32, i + 24, -16, 1), vec4(0), vec4(0), vec4(0), vec4(0));
                // }
            }
                break;
        }

        if (minT == MAX_DEPTH)
            discard;

        writeDepth(dir * minT);
        vDistance = minT;
    }

    if (color.a < 0.1) {
        discard;
    }

    if (cem == 0) color *= vertexColor;

    color *= ColorModulator;
    color *= lightMapColor;
    fragColor = linear_fog(color, vDistance, FogStart, FogEnd, FogColor);
}
