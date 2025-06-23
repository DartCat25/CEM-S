#version 150

#moj_import <light.glsl>
#moj_import <minecraft:fog.glsl>
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

out vec4 fragColor;

#moj_import <cem/frag_funcs.glsl>

void main() {
    gl_FragDepth = gl_FragCoord.z;
    vec4 color = texture(Sampler0, texCoord0);
    
#ifdef ALPHA_CUTOUT
    if (color.a < ALPHA_CUTOUT) {
        discard;
    }
#endif
    color *= vertexColor * ColorModulator;


    if (cem != 0)
    {
        #moj_import <cem/frag_main_setup.glsl>

        switch (cem)
        {
            #moj_import <cem_user/models.glsl>
        }

        if (minT == MAX_DEPTH)
            discard;

        writeDepth(dir * minT);
    }
    else
    {
        if (round(color.a * 255) == 252)
            discard;
    }

#ifndef NO_OVERLAY
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
#endif
#ifndef EMISSIVE
    color *= lightMapColor;
#endif

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
