#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;
out vec4 normal;

out vec4 cem_pos1, cem_pos2, cem_pos3, cem_pos4;
out vec3 cem_glPos;
out vec3 cem_uv1, cem_uv2;
out vec4 cem_lightMapColor;
flat out int cem;
flat out int cem_reverse;
flat out vec4 cem_light;

void main() {
    //gl_Position = ProjMat * ModelViewMat * vec4(Position + normalize(Light1_Direction), 1.0);
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    texCoord0 = UV0;
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);

    const vec2[4] corners = vec2[4](vec2(0), vec2(0, 1), vec2(1, 1), vec2(1, 0));
    const vec2[4] corners2 = vec2[4](vec2(0), vec2(1, 0), vec2(1, 1), vec2(0, 1));
    vec2 corner = corners[gl_VertexID % 4];

    vec2 texSize = textureSize(Sampler0, 0);
    vec2 uv = floor(UV0 * texSize);

    cem_pos1 = cem_pos2 = cem_pos3 = cem_pos4 = vec4(0);
    cem_uv1 = cem_uv2 = vec3(0);
    cem = cem_reverse = 0;
    float cem_size = 1;

    // if (texelFetch(Sampler0, ivec2(63, 0), 0) == vec4(1, 0, 0, 1) && uv - corners[(gl_VertexID + 3) % 4] * 8 == vec2(8)) //Get pig Face to add ears
    if (texelFetch(Sampler0, ivec2(63, 0), 0) == vec4(1, 0, 0, 1) && gl_VertexID / 4 % (6 * 7) == 3) //Get pig Face to add ears
    {
        cem = 1;
        cem_reverse = 1;
    }
    if (texelFetch(Sampler0, ivec2(63, 0), 0) == vec4(0, 0, 240, 255) / 255)
    {
        vec2 tUV = corners[(gl_VertexID + 3) % 4];
        vec2 rUV = corners2[(gl_VertexID + 2) % 4];

        if (uv - tUV * vec2(2, 7) == vec2(2)) //Head
        {
            cem = 2;
            cem_reverse = 1;
        }
        else if (uv - tUV * vec2(2, 7) == vec2(18, 2)) //Body
        {
            cem = 3;
            cem_reverse = 1;
        }
        else if (uv - rUV * vec2(2, 12) == vec2(34, 18)) //Left Hand
        {
            cem = 4;
        }
        else if (uv - tUV * vec2(2, 12) == vec2(26, 2)) //Right Hand
        {
            cem = 5;
            cem_reverse = 1;
        }
        else if (uv - rUV * vec2(2, 11) == vec2(42, 18)) //Left Leg
        {
            cem = 6;
        }
        else if (uv - tUV * vec2(2, 11) == vec2(10, 2)) //Right Leg
        {
            cem = 7;
            cem_reverse = 1;
        }
        else gl_Position = vec4(0);
    }

    if (cem != 0) //Setup CEM model
    {
        #moj_import <cem/vert_setup.glsl>
    }
}
