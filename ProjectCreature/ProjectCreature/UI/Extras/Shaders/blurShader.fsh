//
//  blurShader.fsh
//
//  Adapted from https://www.youtube.com/wav_tex_coordh?v=eYHId0zgkdE
//


void main()
{
    vec4 sum = vec4(0.0);

    float blur = radius/resolution;
    
    int x;
    int y;
    
    for (x=-6; x<=6; x++)
    {
        for (y=-6; y<=6; y++)
        {
            vec2 offset = vec2(x, y) * blur;
            sum += texture2D(u_texture, v_tex_coord + offset);
        }
    }
    
    gl_FragColor = sum / (13.0*13.0);
}
