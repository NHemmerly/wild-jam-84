shader_type canvas_item;
render_mode unshaded;

uniform sampler3D gradient: hint_default_black;

void fragment()
{
	vec4 input_color = texture(TEXTURE, UV);
	vec4 green_color.rgb = mix(input_color.rgb, vec4(0, 1, 0));
	//float grayscale_value = dot(input_color.rgb, vec3(0.299, 0.587, 0.114));
	//vec4 sampled_color = texture(gradient, vec2(grayscale_value, 0.0)).rgb;

	COLOR.rgba = green_color;
	//COLOR.a = input_color.a;
}