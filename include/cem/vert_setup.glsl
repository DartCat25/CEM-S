/* CEM-Shader. DartCat25
*  Vertex Setup (set in block if model is cem)
*  #moj_import <cem/vert_setup.glsl>
*/ 

switch (gl_VertexID % 4)
{
    case 0:
        cem_pos1 = vec4(modelPos.xyz, 1);
        cem_uv1 = vec3(uv, 1);
        break;
    case 1:
        cem_pos2 = vec4(modelPos.xyz, 1);
        break;
    case 2:
        cem_pos3 = vec4(modelPos.xyz, 1);
        cem_uv2 = vec3(uv, 1);
        break;
    case 3:
        cem_pos4 = vec4(modelPos.xyz, 1);
        break;
}

vec2 cornerT = corner * 2 - 1;
vec3 cem_Pos = Position + vec3(cornerT * 2 * cem_size, 0);
cem_Pos.z = min(cem_Pos.z, -1);
gl_Position = ProjMat * ModelViewMat * vec4(cem_Pos, 1);
cem_glPos = cem_Pos;

vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, vec4(1.0));
cem_lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
