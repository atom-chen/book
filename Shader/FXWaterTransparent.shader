Shader "FX/FXWaterTransparent" {
	Properties {
		_horizonColor ("Horizon color", COLOR)  = ( .172 , .463 , .435 , 0)
		_WaveScale ("Wave scale", Range (0.02,0.15)) = .07
		_fresnelFactor ("fresnelFactor", Range (0,1)) = .5
		[NoScaleOffset] _ColorControl ("Reflective color (RGB) fresnel (A) ", 2D) = "" { }
		[NoScaleOffset] _BumpMap ("Waves Normalmap ", 2D) = "" { }
		WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
   }

	Subshader{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		//Blend SrcAlpha One

		Pass {

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			uniform fixed4 _horizonColor;
			uniform half4 WaveSpeed;
			uniform fixed _WaveScale;
			//uniform float4 _WaveOffset;
			uniform fixed _fresnelFactor; 

			sampler2D _BumpMap;
			sampler2D _ColorControl;

			struct appdata {
				half4 vertex : POSITION;
				half3 normal : NORMAL;
			};

			struct v2f {
				half4 pos : SV_POSITION;
				float4 bumpuv : TEXCOORD0;
				half3 viewDir : TEXCOORD2;
				UNITY_FOG_COORDS(3)
			};

			v2f vert(appdata v)
			{
				v2f o;
				half4 s;

				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

				// scroll bump waves
				half4 wpos  = mul (_Object2World, v.vertex);
				float4 offsetWave = WaveSpeed*_Time.y*0.02;
				
				o.bumpuv = (wpos.xzxz+offsetWave) * _WaveScale;
				o.bumpuv.xy *= float2(0.4,0.45);

				// object space view direction
				o.viewDir.xzy = normalize( WorldSpaceViewDir(v.vertex) );

				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}

			fixed4 frag( v2f i ) : COLOR
			{
				fixed3 bump1 = UnpackNormal(tex2D( _BumpMap, i.bumpuv.xy )).rgb;
				fixed3 bump2 = UnpackNormal(tex2D( _BumpMap, i.bumpuv.zw )).rgb;
				fixed3 bump = (bump1 + bump2) * (1-_fresnelFactor);
	
				half fresnel = dot( i.viewDir, bump );
				fixed4 water = tex2D( _ColorControl, float2(fresnel,fresnel) );
	
				fixed4 col;
				col.rgb = lerp( water.rgb, _horizonColor.rgb, water.a );
				col.a = _horizonColor.a;

				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
