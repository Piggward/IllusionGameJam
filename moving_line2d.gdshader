shader_type canvas_item;

uniform vec4 color: source_color;
uniform vec2 speed = vec2(-5.0, 0);
uniform float alpha = 1.0;
uniform sampler2D texture2 : repeat_enable;
uniform vec2 speed2;

void fragment() {
    vec2 uv = UV + speed * TIME;
    vec4 tex = texture(TEXTURE, uv);
    vec4 noise = texture(texture2, uv * TIME * speed2);
    // Detect "white-ish" pixels
    float threshold = 0.9;
    float is_white = step(threshold, tex.r) * step(threshold, tex.g) * step(threshold, tex.b);

    // Apply energy/color only to white pixels
    vec3 final_rgb = mix(tex.rgb, noise.rgb, is_white);

    COLOR = vec4(final_rgb, tex.a * color.a); // preserve alpha
	COLOR *= color;
	COLOR.a = 0.85;
}