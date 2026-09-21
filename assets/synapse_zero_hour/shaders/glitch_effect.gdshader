shader_type canvas_item;

// Glitch Effect Shader for Critical Hits & Flatline Events
uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.0;
uniform float color_drift : hint_range(0.0, 0.1) = 0.02;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

float random(vec2 uv) {
	return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	if (glitch_intensity > 0.01) {
		float slice_y = floor(uv.y * 30.0);
		float slice_rand = random(vec2(slice_y, floor(TIME * 24.0)));
		if (slice_rand < glitch_intensity * 0.6) {
			uv.x += (random(vec2(slice_rand, TIME)) - 0.5) * glitch_intensity * 0.1;
		}
	}
	
	float r = texture(SCREEN_TEXTURE, uv + vec2(color_drift * glitch_intensity, 0.0)).r;
	float g = texture(SCREEN_TEXTURE, uv).g;
	float b = texture(SCREEN_TEXTURE, uv - vec2(color_drift * glitch_intensity, 0.0)).b;
	float a = texture(SCREEN_TEXTURE, uv).a;
	
	COLOR = vec4(r, g, b, a);
}
