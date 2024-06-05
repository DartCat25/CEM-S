#define VERT_A 100000

vec2 texSize = textureSize(Sampler0, 0);
vec3 Pos1 = round(cem_pos1.xyz * VERT_A / cem_pos1.w) / VERT_A;
vec3 Pos2 = round(cem_pos3.xyz * VERT_A / cem_pos3.w) / VERT_A;
vec3 Pos3 = gl_PrimitiveID % 2 == 0 ? round(cem_pos2.xyz * VERT_A / cem_pos2.w) / VERT_A : round(cem_pos4.xyz * VERT_A / cem_pos4.w) / VERT_A;

// if (ProjMat[3][0] == -1)
// {
//     Pos1 /= 0x1000;
//     Pos2 /= 0x1000;
//     Pos3 /= 0x1000;
// }

vec3 tangent = normalize(gl_PrimitiveID % 2 == 0 ? Pos3 - Pos1 : Pos2 - Pos3);
vec3 bitangent = normalize(gl_PrimitiveID % 2 == 1 ? Pos1 - Pos3 : Pos3 - Pos2);
vec3 normalT = normalize(cross(tangent, bitangent));

#ifdef MINUS_Z
if (ProjMat[3][0] == -1)
    normalT *= -1;
#endif

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

vec3 rawCenter = (Pos1 + Pos2) / 2;
vec3 center = rawCenter * TBN;
vec3 dir = normalize(cem_glPos) * mat3(ModelViewMat);
vec3 dirTBN = normalize(cem_glPos * mat3(ModelViewMat) * TBN);

if (ProjMat[3][0] == -1)
{
    center = vec3(-cem_glPos.xy + rawCenter.xy, rawCenter.z) * TBN;
    dir = vec3(0, 0, -1);
    dirTBN = normalize(dir * TBN);
}

float modelSize = length((gl_PrimitiveID % 2 == 1 ? Pos1 : Pos2) - Pos3);
vec2 sizes = vec2(length((gl_PrimitiveID % 2 == 0 ? Pos1 : Pos2) - Pos3), modelSize);

float minT = MAX_DEPTH;
color = vec4(0);
