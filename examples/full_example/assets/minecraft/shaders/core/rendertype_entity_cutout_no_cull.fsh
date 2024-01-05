#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>
#moj_import <matf.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

#moj_import <cem/frag_funcs.glsl>

void main() {
    gl_FragDepth = gl_FragCoord.z;
    vec4 color = texture(Sampler0, texCoord0);

    if (cem != 0)
    {
        #moj_import <cem/frag_main_setup.glsl>

        switch (cem)
        {
            case 1:
                modelSize /= 8;
                break;
            case 2: case 3:
                modelSize /= 7;
                break;
            case 4: case 5:
                modelSize /= 12;
                break;
            case 6: case 7:
                modelSize /= 11;
                break;
        }

        switch (cem)
        {
            case 1: //Pig ears
                //Set face back
                ADD_SQUARE(vec3(-4, -4, 0), vec3(4, -4, 0), vec3(-4, 4, 0), vec4(8))

                ADD_BOX_ROTATE(vec3(-4.35, 0, -4), vec3(0.5, 2.5, 2),   //Pos, Size,
                Rotate3((sin(GameTime * 1000) * 0.5 + 1.5) * PI * -0.05, Z), vec3(0.5, 2.5, 0),
                vec4(23, 23, 1, 4), vec4(22, 23, 1, 4),  //Down, Up,
                vec4(22, 27, 1, 5), vec4(18, 27, 4, 5), //North, East,
                vec4(27, 27, 1, 5), vec4(23, 27, 4, 5)) //South, West

                ADD_BOX_ROTATE(vec3(4.35, 0, -4), vec3(0.5, 2.5, 2),   //Pos, Size,
                Rotate3((sin(GameTime * 1000) * 0.5 + 1.5) * PI * 0.05, Z), vec3(-0.5, 2.5, 0),
                vec4(23, 23, 1, 4), vec4(22, 23, 1, 4),  //Down, Up,
                vec4(22, 27, 1, 5), vec4(18, 27, 4, 5), //North, East,
                vec4(27, 27, 1, 5), vec4(23, 27, 4, 5)) //South, West
                break;
            //Armorstand
            case 2: //Head
                ADD_BOX(vec3(0, 1, -1), vec3(4),   //Pos, Size,
                vec4(16, 0, 8, 8), vec4(8, 0, 8, 8), //Down, Up,
                vec4(8, 8, 8, 8), vec4(0, 8, 8, 8), //North, East,
                vec4(24, 8, 8, 8), vec4(16, 8, 8, 8)) //South, West
                break;
            case 3: //Body
                ADD_BOX(vec3(-2, 0, -1), vec3(4, 6, 2),   //Pos, Size,
                vec4(28, 16, 8, 4), vec4(20, 16, 8, 4), //Down, Up,
                vec4(20, 20, 8, 12), vec4(16, 20, 4, 12), //North, East,
                vec4(32, 20, 8, 12), vec4(28, 20, 4, 12)) //South, West
                break;
            case 4: //Left Hand
                ADD_BOX(vec3(0, 0, -1), vec3(2, 6, 2),   //Pos, Size,
                vec4(40, 48, 4, 4), vec4(36, 48, 4, 4), //Down, Up,
                vec4(36, 52, 4, 12), vec4(32, 52, 4, 12), //North, East,
                vec4(44, 52, 4, 12), vec4(40, 52, 4, 12)) //South, West
                break;
            case 5: //Right Hand
                ADD_BOX(vec3(0, 0, -1), vec3(2, 6, 2),   //Pos, Size,
                vec4(48, 16, 4, 4), vec4(44, 16, 4, 4), //Down, Up,
                vec4(44, 20, 4, 12), vec4(40, 20, 4, 12), //North, East,
                vec4(52, 20, 4, 12), vec4(48, 20, 4, 12)) //South, West
                break;
            case 6: //Left Leg
                ADD_BOX(vec3(0, -1, -1), vec3(2, 6, 2),   //Pos, Size,
                vec4(40, 48, 4, 4), vec4(20, 48, 4, 4), //Down, Up,
                vec4(20, 52, 4, 12), vec4(16, 52, 4, 12), //North, East,
                vec4(28, 52, 4, 12), vec4(24, 52, 4, 12)) //South, West
                break;
            case 7: //Right Leg
                ADD_BOX(vec3(0, -1, -1), vec3(2, 6, 2),   //Pos, Size,
                vec4(8, 16, 4, 4), vec4(4, 16, 4, 4), //Down, Up,
                vec4(4, 20, 4, 12), vec4(0, 20, 4, 12), //North, East,
                vec4(12, 20, 4, 12), vec4(8, 20, 4, 12)) //South, West
                break;
        }

        if (minT == MAX_DEPTH)
            discard;

        writeDepth(dir * minT);
    }

    if (color.a < 0.1) {
        discard;
    }

    if (cem == 0) color *= vertexColor;

    color *= ColorModulator;
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
