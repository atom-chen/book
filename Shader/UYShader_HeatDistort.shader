Shader "UYShader/Distort/HeatDistort" {
	Properties {
		_BumpAmt  ("Distortion", range (0,30)) = 10
		_MainTex ("MainTex (RGB)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
	}
	CGINCLUDE
	#pragma fragmentoption ARB_precision_hint_fastest
	#pragma fragmentoption ARB_fog_exp2
	#include "UnityCG.cginc"

	sampler2D _GrabTexture : register(s0);
	float4 _GrabTexture_TexelSize;
	sampler2D _BumpMap : register(s1);
	sampler2D _MainTex : register(s2);

	struct v2f {
		 float4 vertex : POSITION;
		 float4 uvgrab : TEXCOORD0;
		 float2 uvbump : TEXCOORD1;
		 float2 uvmain : TEXCOORD2;
	};

	uniform float _BumpAmt;


	fixed4 frag( v2f i ) : COLOR
	{
		 // 计算扰乱坐标
		 half2 bump = UnpackNormal(tex2D( _BumpMap, i.uvbump )).rg; // we could optimize this by just reading the x & y without reconstructing the Z
		 float2 offset = bump * _BumpAmt * _GrabTexture_TexelSize.xy;
		 i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;
 
		 float last_x = i.uvgrab.x/i.uvgrab.w;
		 float last_y = i.uvgrab.y/i.uvgrab.w;
		 fixed4 col = tex2D( _GrabTexture, float2(last_x,last_y) );
		 fixed4 tint = tex2D( _MainTex, i.uvmain );
		 fixed4 finalCol = col * tint;
	     return finalCol;
	}
	ENDCG

	Category {
		// We must be transparent, so other objects are drawn before this one.
		Tags { "Queue"="Transparent+10" "IgnoreProjector"="True" "RenderType"="Transparent" }
	     Blend SrcAlpha OneMinusSrcAlpha
		 AlphaTest Greater .01
		 ColorMask RGB
		 Cull Off Lighting Off ZWrite Off

		SubShader {
			// This pass grabs the screen behind the object into a texture.
			// We can access the result in the next pass as _GrabTexture
			GrabPass {       
			Name "BASE"
			Tags { "LightMode" = "Always" }
		   }

		   // Main pass: Take the texture grabbed above and use the bumpmap to perturb it
		   // on to the screen
		   Pass {
				Name "BASE"
				Tags { "LightMode" = "Always" }
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				struct appdata_t {
				 float4 vertex : POSITION;
				 float2 texcoord: TEXCOORD0;
				};

				v2f vert (appdata_t v)
				{
					 v2f o;
					 o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					 #if UNITY_UV_STARTS_AT_TOP
						float scale = -1.0;
					 #else
						float scale = 1.0;
					 #endif
					 o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y*scale) + o.vertex.w) * 0.5;
					 o.uvgrab.zw = o.vertex.zw;
					 o.uvbump = MultiplyUV( UNITY_MATRIX_TEXTURE1, v.texcoord );
					 o.uvmain = MultiplyUV( UNITY_MATRIX_TEXTURE2, v.texcoord );
					 return o;
				}
				ENDCG
		   }
		}
	}
}