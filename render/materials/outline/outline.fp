/*
varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;

void main()
{
	// Pre-multiply alpha since all runtime textures already are
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
	gl_FragColor = texture2D(texture_sampler, var_texcoord0.xy) * tint_pm;
}

#ifdef GL_ES
#define LOWP lowp
precision mediump float;
#else
#define LOWP
#endif
*/

const float offset = 1 / 256.0;
varying mediump vec2 var_texcoord0;
//uniform sampler2D u_texture;
uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
void main()
{
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
	vec4 col = texture2D(texture_sampler, var_texcoord0.xy) * tint_pm;
	if (col.a > 0.5)
	gl_FragColor = col;
	else {
		float a = texture2D(texture_sampler, vec2(var_texcoord0.x + offset, var_texcoord0.y)).a +
		texture2D(texture_sampler, vec2(var_texcoord0.x, var_texcoord0.y - offset)).a +
		texture2D(texture_sampler, vec2(var_texcoord0.x - offset, var_texcoord0.y)).a +
		texture2D(texture_sampler, vec2(var_texcoord0.x, var_texcoord0.y + offset)).a;
		if (col.a < 1.0 && a > 0.0)
		gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
		else
		gl_FragColor = col;
	}
}