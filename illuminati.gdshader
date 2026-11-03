shader_type canvas_item;

uniform float speed = 0.5;
uniform float frequency = 3.0;
uniform float intensity = 1.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float hue = fract(UV.x * frequency + TIME * speed);

    vec3 rainbow = 0.5 + 0.5 * cos(
        6.28318 * (hue + vec3(0.0, 0.333, 0.666))
    );

    COLOR = vec4(
        mix(tex.rgb, tex.rgb * rainbow, intensity),
        tex.a
    );
}