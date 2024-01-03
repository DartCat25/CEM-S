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

uniform mat3 IViewRotMat;

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
