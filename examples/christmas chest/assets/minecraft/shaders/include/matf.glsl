#version 150

#define X 0
#define Y 1
#define Z 2

#define PI 3.14159265

//matrix 4

mat4 MakeMat4()
{
	return mat4(1.0, 0.0, 0.0, 0.0,
				0.0, 1.0, 0.0, 0.0,
				0.0, 0.0, 1.0, 0.0,
				0.0, 0.0, 0.0, 1.0);
}

mat4 Rotate(float angle, int type)
{

	float sin = sin(angle);
	float cos = cos(angle);

	if (type == 0)
		return mat4(1.0, 0.0,  0.0, 0.0,
					0.0, cos, -sin, 0.0,
					0.0, sin,  cos, 0.0,
					0.0, 0.0,  0.0, 1.0);
	if (type == 1)
		return mat4( cos, 0.0, sin, 0.0,
					 0.0, 1.0, 0.0, 0.0,
					-sin, 0.0, cos, 0.0,
					 0.0, 0.0, 0.0, 1.0);
	if (type == 2)
		return mat4(cos, -sin, 0.0, 0.0,
					sin,  cos, 0.0, 0.0,
					0.0,  0.0, 1.0, 0.0,
					0.0,  0.0, 0.0, 1.0);				

	return mat4(0.0);
}

mat3 Rotate3(float angle, int type)
{

	float sin = sin(angle);
	float cos = cos(angle);

	if (type == 0)
		return mat3(1.0, 0.0, 0.0,
					0.0, cos, -sin,
					0.0, sin,  cos);
	if (type == 1)
		return mat3( cos, 0.0, sin,
					 0.0, 1.0, 0.0,
					-sin, 0.0, cos);
	if (type == 2)
		return mat3(cos, -sin, 0.0,
					sin,  cos, 0.0,
					0.0,  0.0, 1.0);				

	return mat3(0.0);
}

mat4 RotateByAxis(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}