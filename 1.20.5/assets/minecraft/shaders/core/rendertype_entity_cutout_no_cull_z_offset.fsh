#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <matf.glsl>
#moj_import <noise.glsl>

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
    vec4 color = texture(Sampler0, texCoord0);

    if (cem != 0)
    {
        #moj_import <cem/frag_main_setup.glsl>

        switch (cem)
        {
            case 1: //Pig ears
            {
                modelSize /= 8;
                color = sBox(-center - vec3(0, 1, 8) * modelSize, dirTBN, vec3(7, 5, 7) * modelSize, TBN, color, minT,
                vec4(stp + vec2(-20, -25), vec2(14)), vec4(stp + vec2(-34, -25), vec2(14)),
                vec4(stp + vec2(-6, -11), vec2(14, 10)), vec4(stp + vec2(-6 - 14, -11), vec2(14, 10)),
                vec4(stp + vec2(-6 - 14 * 2, -11), vec2(14, 10)), vec4(stp + vec2(-6 - 14 * 3, -11), vec2(14, 10)));
                break;
            }
            case 2:
            {
                modelSize /= 12;
                color = sBox(-center - vec3(0, 1.5, 8) * modelSize, dirTBN, vec3(7, 2.5, 7) * modelSize, TBN, color, minT,
                vec4(stp + vec2(-20 + 14, -16), vec2(-14, 14)), vec4(stp + vec2(-34, -16), vec2(14)),
                vec4(stp + vec2(-6, -2), vec2(14, 5)), vec4(stp + vec2(-6 - 14, -2), vec2(14, 5)),
                vec4(stp + vec2(-6 - 14 * 2, -2), vec2(14, 5)), vec4(stp + vec2(-6 - 14 * 3, -2), vec2(14, 5)));

                color = sBox(-center - vec3(0, -1, 0.5) * modelSize, dirTBN, vec3(1, 2, 0.5) * modelSize, TBN, color, minT,
                vec4(stp + vec2(-43, -16), vec2(-2, 1)), vec4(stp + vec2(-45, -16), vec2(-2, 1)),
                vec4(stp + vec2(-44, -15), vec2(2, 3)), vec4(stp + vec2(-45 + 1, -15), vec2(-1, 3)),
                vec4(stp + vec2(-47, -15), vec2(2, 3)), vec4(stp + vec2(-48 + 1, -15), vec2(-1, 3)));
                break;
            }
        }

        if (minT == MAX_DEPTH)
            discard;

        writeDepth(dir * minT);
    }

    if (color.a < 0.1) {
        discard;
    }

    if (cem == 0) color *= vertexColor;

    color *= ColorModulator;
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
