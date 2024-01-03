#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in vec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

uniform vec2 ScreenSize;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 normal;

flat out int armorType;
flat out vec4 tint;

out vec4 cem_pos1, cem_pos2, cem_pos3, cem_pos4;
out vec3 cem_glPos;
out vec3 cem_uv1, cem_uv2;
out vec4 cem_lightMapColor;
flat out int cem;
flat out int cem_reverse;
flat out vec4 cem_light;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    texCoord0 = UV0;
    vertexDistance = fog_distance(ModelViewMat, Position, FogShape);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color) * texelFetch(Sampler2, UV2 / 16, 0);

    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);

    vec2 texSize = textureSize(Sampler0, 0);
    vec2 uv = floor(UV0 * texSize);

    const vec2[4] corners = vec2[4](vec2(0), vec2(0, 1), vec2(1, 1), vec2(1, 0));
    vec2 corner = corners[gl_VertexID % 4];

    cem_pos1 = cem_pos2 = cem_pos3 = cem_pos4 = vec4(0);
    cem_uv1 = cem_uv2 = vec3(0);
    cem = cem_reverse = 0;
    cem_light = texelFetch(Sampler2, UV2 / 16, 0);
    float cem_size = 1;

    if (gl_VertexID / 4 == 3)
        corner.x = 1 - corner.x;

    if (cem != 0)
    {
        #moj_import <cem/vert_setup.glsl>
    }
}
