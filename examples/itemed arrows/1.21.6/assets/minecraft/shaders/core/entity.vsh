#version 150

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;

out vec4 cem_pos1, cem_pos2, cem_pos3, cem_pos4;
out vec3 cem_glPos;
out vec3 cem_uv1, cem_uv2;
out vec4 cem_lightMapColor;
flat out int cem;
flat out int cem_reverse;
flat out vec4 cem_light;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);

    const vec2[4] corners = vec2[4](vec2(0), vec2(0, 1), vec2(1, 1), vec2(1, 0));
    const vec2[4] corners2 = vec2[4](vec2(0), vec2(1, 0), vec2(1, 1), vec2(0, 1));
    vec2 corner = corners[gl_VertexID % 4];

    vec2 texSize = textureSize(Sampler0, 0);
    vec2 uv = floor(UV0 * texSize);

    cem_pos1 = cem_pos2 = cem_pos3 = cem_pos4 = vec4(0);
    cem_uv1 = cem_uv2 = vec3(0);
    cem = cem_reverse = 0;
    float cem_size = 1;

    vec4 testColor = texelFetch(Sampler0, ivec2(63, 0), 0);
    vec2 armorUV = floor(UV0 * vec2(64, 32));

    vec4 armorTestColorIn = round(texelFetch(Sampler0, ivec2(uv - corners[(gl_VertexID + 3) % 4]), 0) * 255);
    vec4 armorTestColor = round(texelFetch(Sampler0, ivec2(armorUV - (1 - corner.yx) + vec2(0, 64)), 0) * 255);


#ifdef NO_CARDINAL_LIGHTING
    vertexColor = Color;
#else
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
#endif
#ifndef EMISSIVE
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
#endif
    overlayColor = texelFetch(Sampler1, UV1, 0);

    texCoord0 = UV0;
#ifdef APPLY_TEXTURE_MATRIX
    texCoord0 = (TextureMat * vec4(UV0, 0.0, 1.0)).xy;
#endif

    #moj_import <cem_user/detection.glsl>

    if (cem != 0) //Setup CEM model
    {
        #moj_import <cem/vert_setup.glsl>
    }
}
