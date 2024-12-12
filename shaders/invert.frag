#pragma header
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor

uniform float invert;
void main(){
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
	vec2 iResolution = openfl_TextureSize;
	vec4 color = texture(iChannel0, fragCoord.xy/iResolution.xy);
		
	fragColor = invert == 0 ? color : vec4(flixel_texture2D(iChannel0,uv).a-color.rgb,flixel_texture2D(iChannel0,uv).a);
}