if (testColor == vec4(3. / 255, 0, 0, 1) && gl_VertexID / 4 % (6 * 7 * 2) == 3) //Get pig Face to add ears
{
    cem = 13;
    cem_reverse = 1;
}