Shader "UYShader/ImageEffectsRefraction" {
	Properties {
		_SpeedStrength ("Speed (XY), Strength (ZW)", Vector) = (1, 1, 1, 1)
		_RefractTexTiling ("Refraction Tilefac", Float) = 1
		_RefractTex ("Refraction (RG), Colormask (B)", 2D) = "bump" {}
		_Color ("Color (RGB)", Color) = (1, 1, 1, 1)
		_MainTex ("Base (RGB) DON`T TOUCH IT! :)", RECT) = "white" {}
	}
	SubShader
	{
		Pass
		{
			ZTest Always Cull Off ZWrite Off
			Fog{Mode off}
			CGPROGRAM
				#pragma vertex vert_img
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"

				uniform sampler2D _MainTex;
				uniform sampler2D _RefractTex;
				uniform half4 _SpeedStrength;
				uniform half _RefractTexTiling;
				uniform fixed4 _Color;
				fixed4 frag (v2f_img i) : COLOR
				{
					half2 refrtc = i.uv*_RefractTexTiling;
					fixed4 refract = tex2D(_RefractTex, refrtc+_SpeedStrength.xy*_Time.x);
					refract.rg = refract.rg*2.0-1.0;
					fixed4 original = tex2D(_MainTex, i.uv+refract.rg*_SpeedStrength.zw);
					fixed4 output = lerp(original, original*_Color, refract.b);
					output.a = original.a;
					return output;
				}
			ENDCG
		}
	}
	Fallback off
}
