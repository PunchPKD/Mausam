shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;
// We look up the texture rendered behind this specific panel
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec3 result = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur_amount).rgb;
    
    // 3. Blend the background blur with your Panel's built-in theme style
    COLOR.rgb = result;
}
