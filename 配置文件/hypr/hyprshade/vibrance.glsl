precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;
void main() {
    vec4 c = texture2D(tex, v_texcoord);
    // 1. 伽马值 (Gamma)：低于1.0可以让画面变得深邃，有效去除“白雾”
    c.rgb = pow(c.rgb, vec3(0.85));
    // 2. 对比度 (Contrast)：大于1.0增加明暗反差
    c.rgb = (c.rgb - 0.5) * 1.15 + 0.5;
    // 3. 饱和度 (Saturation)：大于1.0让色彩更浓郁
    float gray = dot(c.rgb, vec3(0.299, 0.587, 0.114));
    c.rgb = mix(vec3(gray), c.rgb, 1.3);
    gl_FragColor = vec4(c.rgb, c.a);
}

