Shader  "UYShader/Dissolve/EffectDissolveAdd"
{
Properties {
	_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
	_MainTex ("Particle Texture", 2D) = "white" {}
	_DissolveTex ("Dissolve Texture", 2D) = "white" {}
	_DissolveFactor ("Dissolve Factor", Float) = 0
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha One
	//AlphaTest Greater .01
	//ColorMask RGB
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
	
	SubShader {
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			sampler2D _DissolveTex;
			fixed4 _TintColor;
			float _DissolveFactor;
			
			struct app2v
			{
				float4 pos : POSITION;
				fixed4 color : COLOR;
				float2 uv : TEXCOORD0;
			};

			struct v2f 
			{
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
				float2 uv0 : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
			};
			
			float4 _MainTex_ST;
			float4 _DissolveTex_ST;

			v2f vert (app2v i)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, i.pos);
				o.color = i.color;
				o.uv0 = TRANSFORM_TEX(i.uv,_MainTex);
				o.uv1	= TRANSFORM_TEX(i.uv,_DissolveTex);
				return o;
			}

	
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 ds = tex2D(_DissolveTex, i.uv1);
				fixed4 finalColor = fixed4(1, 1, 1, 1);
				
				if (ds.a < _DissolveFactor)
					finalColor.a = 0.0f;
				else
					finalColor = 2.0f * i.color * _TintColor * tex2D(_MainTex, i.uv0);
				
				return finalColor;
			}
			ENDCG 
		}
	}	
}
}
