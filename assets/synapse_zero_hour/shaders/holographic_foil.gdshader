shader_type canvas_item;

// Holographic Foil Shader for Glitch-Tier Gear Cards
uniform float foil_speed : hint_range(0.1, 5.0) = 1.2;
uniform float foil_intensity : hint_range(0.0, 1.0) = 0.65;

void fragment() {
	vec4 base_color = texture(TEXTURE, UV);
	if (base_color.a < 0.05) {
		COLOR = base_color;
		return;
	}
	
	// Rainbow angle phase
	float phase = UV.x + UV.y + sin(TIME * foil_speed);
	vec3 rainbow = 0.5 + 0.5 * cos(6.28318 * (phase + vec3(0.0, 0.33, 0.67)));
	
	vec3 final_rgb = mix(base_color.rgb, base_color.rgb + rainbow * 0.5, foil_intensity);
	COLOR = vec4(final_rgb, base_color.a);
}
