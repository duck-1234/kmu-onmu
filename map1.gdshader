shader_type canvas_item;

uniform float outline_size = 0.0;
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 tex = texture(TEXTURE, UV);

	float alpha = tex.a;

	float outline = 0.0;

	//  outline_size 있을 때만 계산
	if (outline_size > 0.0) {
		for (float x = -outline_size; x <= outline_size; x++) {
			for (float y = -outline_size; y <= outline_size; y++) {
				vec2 offset = vec2(x, y) * TEXTURE_PIXEL_SIZE;
				outline += texture(TEXTURE, UV + offset).a;
			}
		}
	}

	//최종 출력 분기 (return 없음)
	if (outline_size > 0.0 && alpha == 0.0 && outline > 0.0) {
		COLOR = outline_color;
	} else {
		COLOR = tex;
	}
}