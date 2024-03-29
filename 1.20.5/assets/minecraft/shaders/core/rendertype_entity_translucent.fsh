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
            // case 1: //Second skin layer
            // {
            //     modelSize /= res.y;

            //     // color = sBox(-center, dirTBN, vec3(sizes / 2, 0), TBN, color, minT,
            //     // vec4(0), vec4(0),
            //     // vec4(stp + res, -res), vec4(0),
            //     // vec4(0), vec4(0));

            //     // vec3 uvt = planeIntersect(-center, dirTBN, vec3(-sizes / 2, 0), vec3(sizes / 2 * vec2(1, -1), 0), vec3(sizes / 2 * vec2(-1, 1), 0));
            // }
            //     break;
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
