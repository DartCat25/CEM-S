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

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
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
            case 1: //Arrow
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

                break;
            }
            case 2:
            {
                modelSize /= 5;
                color = sBox(-center, dirTBN, vec3(7, 2.5, 0) * modelSize, TBN, color, minT, vec4(0), vec4(0), vec4(stp, res), vec4(0), vec4(0), vec4(0));
                

                mat3 rotMat = Rotate3(PI / 4, Z);
                vec3 center_rot = rotMat * (center - vec3(0, 1, 0) * modelSize);
                vec3 dirTBN_rot = rotMat * dirTBN;
                rotMat = TBN * inverse(rotMat);

                color = sBox(-center_rot - vec3(1, 9, 7) * modelSize, dirTBN_rot, vec3(2.5, 0, 1) * modelSize, rotMat, color, minT, vec4(stp + vec2(-42, 34), 5, 2), vec4(stp + vec2(-42, 34), 5, 2), vec4(0), vec4(0), vec4(0), vec4(0));
                color = sBox(-center_rot - vec3(1, 3, 7) * modelSize, dirTBN_rot, vec3(2.5, 0, 1) * modelSize, rotMat, color, minT, vec4(stp + vec2(-42, 34), 5, 2), vec4(stp + vec2(-42, 34), 5, 2), vec4(0), vec4(0), vec4(0), vec4(0));

                color = sBox(-center_rot - vec3(3.5, 6, 7) * modelSize, dirTBN_rot, vec3(0, 3, 1) * modelSize, rotMat, color, minT, vec4(0), vec4(0), vec4(0), vec4(stp + vec2(-28, 34), 2, 6), vec4(0), vec4(stp + vec2(-28, 34), 2, 6));
                color = sBox(-center_rot - vec3(-1.5, 6, 7) * modelSize, dirTBN_rot, vec3(0, 3, 1) * modelSize, rotMat, color, minT, vec4(0), vec4(0), vec4(0), vec4(stp + vec2(-28, 34), 2, 6), vec4(0), vec4(stp + vec2(-28, 34), 2, 6));


                rotMat = Rotate3(-PI / 4, Z);
                center_rot = rotMat * (center - vec3(0, 1, 0) * modelSize);
                dirTBN_rot = rotMat * dirTBN;
                rotMat = TBN * inverse(rotMat);

                color = sBox(-center_rot - vec3(-1, 9, 7) * modelSize, dirTBN_rot, vec3(2.5, 0, 1) * modelSize, rotMat, color, minT, vec4(stp + vec2(-42, 34), 5, 2), vec4(stp + vec2(-42, 34), 5, 2), vec4(0), vec4(0), vec4(0), vec4(0));
                color = sBox(-center_rot - vec3(-1, 3, 7) * modelSize, dirTBN_rot, vec3(2.5, 0, 1) * modelSize, rotMat, color, minT, vec4(stp + vec2(-42, 34), 5, 2), vec4(stp + vec2(-42, 34), 5, 2), vec4(0), vec4(0), vec4(0), vec4(0));

                color = sBox(-center_rot - vec3(1.5, 6, 7) * modelSize, dirTBN_rot, vec3(0, 3, 1) * modelSize, rotMat, color, minT, vec4(0), vec4(0), vec4(0), vec4(stp + vec2(-28, 34), 2, 6), vec4(0), vec4(stp + vec2(-28, 34), 2, 6));
                color = sBox(-center_rot - vec3(-3.5, 6, 7) * modelSize, dirTBN_rot, vec3(0, 3, 1) * modelSize, rotMat, color, minT, vec4(0), vec4(0), vec4(0), vec4(stp + vec2(-28, 34), 2, 6), vec4(0), vec4(stp + vec2(-28, 34), 2, 6));

                break;
            }
            case 3:
            {
                modelSize /= 4;

                center.x *= -1;
                dirTBN.x *= -1;

                color = sBox(-center - vec3(7.5, 0, 0.5) * modelSize, dirTBN, vec3(1, 2, 0.5) * modelSize, TBN, color, minT, vec4(stp + vec2(-2, -1), 2, 1), vec4(stp + vec2(0, -1), 2, 1), vec4(stp + vec2(-1, 0), 2, 4), vec4(stp + vec2(0, 0), 1, 4), vec4(stp + vec2(1, 0), 2, 4), vec4(stp + vec2(-3, 0), 1, 4));

                break;
            }
            case 4:
            {
                modelSize /= 4;

                center.x *= -1;
                dirTBN.x *= -1;

                color = sBox(-center - vec3(-7.5, 0, 0.5) * modelSize, dirTBN, vec3(1, 2, 0.5) * modelSize, TBN, color, minT, vec4(stp + vec2(-2, -1), 2, 1), vec4(stp + vec2(0, -1), 2, 1), vec4(stp + vec2(-1, 0), 2, 4), vec4(stp + vec2(0, 0), 1, 4), vec4(stp + vec2(1, 0), 2, 4), vec4(stp + vec2(-3, 0), 1, 4));

                break;
            }
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
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;
    fragColor = linear_fog(color, vDistance, FogStart, FogEnd, FogColor);
}
