Shader "UYShader/WaterTransparent" {
	Properties {
		_horizonColor ("Horizon color", COLOR)  = ( .172 , .463 , .435 , 0)
		_WaveScale ("Wave scale", Range (0.02,0.15)) = .07
		_fresnelFactor ("fresnelFactor", Range (0,1)) = .5
		[NoScaleOffset] _ColorControl ("Reflective color (RGB) fresnel (A) ", 2D) = "" { }
		[NoScaleOffset] _BumpMap ("Waves Normalmap ", 2D) = "" { }
		WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
   }

    CGINCLUDE

	#include "UnityCG.cginc"

	uniform fixed4 _horizonColor;
	uniform float4 WaveSpeed;
	uniform float _WaveScale;
	uniform float4 _WaveOffset;
	uniform float _fresnelFactor; 

	struct appdata {
		float4 vertex : POSITION;
		float3 normal : NORMAL;
	};

	struct v2f {
		float4 pos : SV_POSITION;
		float2 bumpuv[2] : TEXCOORD0;
		float3 viewDir : TEXCOORD2;
		float fogCoord : TEXCOORD3;
	};

	v2f vert(appdata v)
	{
		v2f o;
		float4 s;

		o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

		// scroll bump waves
		float4 temp;
		float4 wpos = mul (_Object2World, v.vertex);
		temp.xyzw = wpos.xzxz * _WaveScale + _WaveOffset;
		o.bumpuv[0] = temp.xy * float2(.4, .45);
		o.bumpuv[1] = temp.wz;

		// object space view direction
		o.viewDir.xzy = normalize( WorldSpaceViewDir(v.vertex) );

		if(unity_FogParams.w == 0)
			o.fogCoord =1.0f;
		else
			o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
		return o;
	}

	ENDCG

	Subshader{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		ZWrite on Cull Back
		Blend SrcAlpha OneMinusSrcAlpha

		//Blend SrcAlpha One

		Pass {

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			sampler2D _BumpMap;
			sampler2D _ColorControl;

			fixed4 frag( v2f i ) : COLOR
			{
				half3 bump1 = UnpackNormal(tex2D( _BumpMap, i.bumpuv[0] )).rgb;
				half3 bump2 = UnpackNormal(tex2D( _BumpMap, i.bumpuv[1] )).rgb;
				half3 bump = (bump1 + bump2) * (1-_fresnelFactor);
	
				half fresnel = dot( i.viewDir, bump );
				half4 water = tex2D( _ColorControl, float2(fresnel,fresnel) );
	
				fixed4 col;
				col.rgb = lerp( water.rgb, _horizonColor.rgb, water.a );
				col.a = _horizonColor.a;

				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
				return col;
			}
			ENDCG
		}
	}
}
