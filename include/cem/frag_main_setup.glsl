vec2 texSize = textureSize(Sampler0, 0);
vec3 Pos1 = round(cem_pos1.xyz * 10000 / cem_pos1.w) / 10000;
vec3 Pos2 = round(cem_pos3.xyz * 10000 / cem_pos3.w) / 10000;
vec3 Pos3 = gl_PrimitiveID % 2 == 0 ? round(cem_pos2.xyz * 10000 / cem_pos2.w) / 10000 : round(cem_pos4.xyz * 10000 / cem_pos4.w) / 10000;

vec3 tangent = normalize(gl_PrimitiveID % 2 == 0 ? Pos3 - Pos1 : Pos2 - Pos3);
vec3 bitangent = normalize(gl_PrimitiveID % 2 == 1 ? Pos1 - Pos3 : Pos3 - Pos2);
vec3 normalT = normalize(cross(tangent, bitangent));

if (cem_reverse == 1)
{
    tangent = -tangent;
    bitangent = -bitangent;
}

mat3 TBN = mat3(tangent, bitangent, normalT);

vec2 UV1 = round(cem_uv1.xy / cem_uv1.z);
vec2 UV2 = round(cem_uv2.xy / cem_uv2.z);

vec2 stp = min(UV1, UV2);
vec2 res = abs(UV1 - UV2);
