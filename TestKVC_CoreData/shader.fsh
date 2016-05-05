/*
varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform lowp float saturation;

const mediump vec3 luminanceWeighting = vec3(0.2125, 0.7154, 0.0721);

void main()
{
    lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
    lowp float luminance = dot(textureColor.rgb, luminanceWeighting);
    lowp vec3 greyScaleColor = vec3(luminance);
    
    gl_FragColor = vec4(mix(greyScaleColor, textureColor.rgb, saturation), textureColor.w);
    
}
*/

precision lowp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;

void main()
{
    vec3 texel = texture2D(inputImageTexture, textureCoordinate).rgb;
    texel = vec3(dot(vec3(0.3, 0.6, 0.1), texel));
    texel = vec3(texture2D(inputImageTexture2, vec2(texel.r, .16666)).r);
    gl_FragColor = vec4(texel, 1.0);
}


    /*
precision lowp float;

varying highp vec2 textureCoordinate;

uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2; //blowout;
uniform sampler2D inputImageTexture3; //overlay;
uniform sampler2D inputImageTexture4; //map

void main()
{

    vec4 texel = texture2D(inputImageTexture, textureCoordinate);
    vec3 bbTexel = texture2D(inputImageTexture2, textureCoordinate).rgb;

    texel.r = texture2D(inputImageTexture3, vec2(bbTexel.r, texel.r)).r;
    texel.g = texture2D(inputImageTexture3, vec2(bbTexel.g, texel.g)).g;
    texel.b = texture2D(inputImageTexture3, vec2(bbTexel.b, texel.b)).b;

    vec4 mapped;
    mapped.r = texture2D(inputImageTexture4, vec2(texel.r, .16666)).r;
    mapped.g = texture2D(inputImageTexture4, vec2(texel.g, .5)).g;
    mapped.b = texture2D(inputImageTexture4, vec2(texel.b, .83333)).b;
    mapped.a = 1.0;

    gl_FragColor = mapped;
}
*/

/*
 void – 用于没有返回值的函式
 bool – 条件类型，其值可以是真或假
 int – 带负号整数
 float – 浮点数
 vec2 – 2 个浮点数组成的向量
 vec3 – 3 个浮点数组成的向量
 vec4 – 4 个浮点数组成的向量
 bvec2 – 2 个布林组成的向量
 bvec3 – 3 个布林组成的向量
 bvec4 – 4 个布林组成的向量
 ivec2 – 2 个整数组成的向量
 ivec3 – 3 个整数组成的向量
 ivec4 – 4 个整数组成的向量
 mat2 – 浮点数的 2X2 矩阵
 mat3 – 浮点数的 3X3 矩阵
 mat4 – 浮点数的 4X4 矩阵
 sampler1D – 用来存取一维纹理的句柄（handle）（或：操作，作名词解。）
 sampler2D – 用来存取二维纹理的句柄
 sampler3D – 用来存取三维纹理的句柄
 samplerCube – 用来存取立方映射纹理的句柄
 sampler1Dshadow – 用来存取一维深度纹理的句柄
 sampler2Dshadow – 用来存取二维深度纹理的句柄
 */