shader_type canvas_item;
// One jet of steam in the Boiler Room (see steam_valves.gd). Drawn on a Sprite2D
// that covers the jet's zone, with a seamless noise texture: two layers of it roll
// down at different speeds and sway a little, inside a soft plume that comes out
// narrow under the pipe and spreads to fill the zone.

// 1 = blowing hard, 0 = shut (the steam thins away).
uniform float strength : hint_range(0.0, 1.0) = 1.0;
// Size of the zone in room pixels, so the clouds keep their shape in any zone.
uniform vec2 zone_size = vec2(240.0, 460.0);
// Moves each jet's clouds to a different part of the noise.
uniform float seed = 0.0;
uniform vec4 tint : source_color = vec4(0.93, 0.91, 0.87, 1.0);

void fragment() {
	vec2 uv = UV;
	vec2 p = uv * zone_size / 400.0;
	float t = TIME;
	float sway = sin(t * 0.45 + uv.y * 4.0 + seed) * 0.04 * uv.y;
	float n1 = texture(TEXTURE, p * vec2(1.0, 0.7) + vec2(seed + sway, -t * 0.10)).r;
	float n2 = texture(TEXTURE, p * 1.8 + vec2(seed * 1.7 - sway, -t * 0.22)).r;
	float cloud = smoothstep(0.2, 0.95, n1 * 0.62 + n2 * 0.48);

	// The plume: a narrow hissing jet under the pipe, billowing out to fill the zone
	// a third of the way down.
	float half_width = mix(0.05, 0.5, smoothstep(0.0, 0.34, uv.y));
	float dx = abs(uv.x - 0.5);
	float sides = 1.0 - smoothstep(half_width * 0.6, half_width, dx);
	float top = smoothstep(0.0, 0.02, uv.y);
	float bottom = 1.0 - smoothstep(0.82, 1.0, uv.y);
	// Thickest straight under the pipe.
	float core = 1.0 - smoothstep(0.0, 0.5, dx);

	// The jet itself: dense and bright just under the pipe, thinning as it spreads.
	float jet = (1.0 - smoothstep(0.0, 0.05, dx)) * (1.0 - smoothstep(0.0, 0.3, uv.y));
	float alpha = max((0.45 + 0.55 * cloud) * (0.6 + 0.4 * core), jet) * sides * top * bottom;
	vec3 colour = tint.rgb * (0.86 + 0.2 * cloud + 0.12 * jet);
	COLOR = vec4(colour, alpha * 0.82 * strength);
}
