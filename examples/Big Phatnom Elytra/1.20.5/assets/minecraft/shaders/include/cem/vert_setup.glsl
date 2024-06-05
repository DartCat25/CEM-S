/* CEM-Shader. DartCat25
*  Vertex Setup (set in block if model is cem)
*  #moj_import <cem/vert_setup.glsl>
*/ 

vec4 modelPos = vec4(Position, 1.0);
modelPos.xyz += vec3(ProjMat[3].xy / vec2(ProjMat[0][0], ProjMat[1][1]), 0) * mat3(ModelViewMat);

vec2 cornerT = corner * 2 - 1;
if (ProjMat[3][0] == -1)
    cornerT = cornerT.yx * 32;

vec4 cem_Pos = ModelViewMat * modelPos + vec4(cornerT * 2 * cem_size, 0, 0);

modelPos.w = 1;

#ifdef TRIDENT
if (ProjMat[3][0] == -1)
{
    modelPos *= (sin(GameTime * 1000) + 1) * 1000;
}
#endif

switch (gl_VertexID % 4)
{
    case 0:
        cem_pos1 = modelPos;
        cem_uv1 = vec3(uv, 1);
        break;
    case 1:
        cem_pos2 = modelPos;
        break;
    case 2:
        cem_pos3 = modelPos;
        cem_uv2 = vec3(uv, 1);
        break;
    case 3:
        cem_pos4 = modelPos;
        break;
}

cem_Pos.z = min(cem_Pos.z, -1);
cem_glPos = cem_Pos.xyz;
//cem_Pos -= ProjMat[3] / cem_Pos.z;
mat4 proj = ProjMat;
proj[3].xy = vec2(0, 0);
gl_Position = proj * cem_Pos;

vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, vec4(1));
cem_lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
