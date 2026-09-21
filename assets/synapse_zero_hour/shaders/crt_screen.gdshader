shader_type canvas_item;

// CRT Screen Shader for SYNAPSE: ZERO-HOUR
// Provides curvature, scanlines, phosphor tint, and chromatic aberration

uniform float scanline_count : hint_range(100.0, 1000.0) = 480.0;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.25;
uniform float curvature : hint_range(0.0, 0.2) = 0.03;
uniform float chromatic_aberration : hint_range(0.0, 0.02) = 0.005;
uniform vec4 phosphor_tint : source_color = vec4(0.9, 1.05, 0.95, 1.0);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

vec2 curve(vec2 uv) {
	uv = (uv - 0.5) * 2.0;
	uv *= 1.0 + pow(length(uv) * curvature, 2.0);
	return (uv / 2.0) + 0.5;
}

void fragment() {
	vec2 uv = curve(SCREEN_UV);
	if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		// Chromatic aberration
		float r = texture(SCREEN_TEXTURE, uv + vec2(chromatic_aberration, 0.0)).r;
		float g = texture(SCREEN_TEXTURE, uv).g;
		float b = texture(SCREEN_TEXTURE, uv - vec2(chromatic_aberration, 0.0)).b;
		vec3 color = vec3(r, g, b) * phosphor_tint.rgb;
		
		// Scanlines
		float scanline = sin(uv.y * scanline_count * 3.14159) * 0.5 + 0.5;
		color -= scanline * scanline_intensity;
		
		// Vignette
		float vignette = uv.x * (1.0 - uv.x) * uv.y * (1.0 - uv.y);
		color *= clamp(pow(16.0 * vignette, 0.25), 0.0, 1.0);
		
		COLOR = vec4(color, 1.0);
	}
}
