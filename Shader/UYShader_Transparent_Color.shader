Shader "UYShader/Transparent_Color" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
        _DiffIntensity ("DiffIntensity", Range(0, 1)) = 0.8632484
        _SpecColor ("SpecColor", Color) = (0.3278546,0.05017301,0.4264706,1)
        _Gloss ("Gloss", Range(0, 1)) = 1
        _EmissIntensity ("EmissIntensity", Range(0, 1)) = 0.6068386
        
		_AreaTex("AreaTex", 2D) = "black"{}
		_ColorR("ColorR", Color) = (1,1,1,1)
		_ColorG("ColorG", Color) = (1,1,1,1)
		_ColorB("ColorB", Color) = (1,1,1,1)

		[HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Blend SrcAlpha OneMinusSrcAlpha
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
           
		    uniform fixed4 _LightColor0;
			uniform fixed4 _SpecColor;

            uniform sampler2D _Texture; uniform half4 _Texture_ST;
            uniform fixed _DiffIntensity;
            uniform fixed _Gloss;
            uniform fixed _EmissIntensity;

			uniform sampler2D _AreaTex;uniform float4 _AreaTex_ST;
			uniform fixed4 _ColorR;
			uniform fixed4 _ColorG;
			uniform fixed4 _ColorB;

            struct VertexInput {
                half4 vertex : POSITION;
                half3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
            };
            
			struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half2 dot : TEXCOORD1;
                half fogCoord : TEXCOORD2;
            };

            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv0 = v.texcoord0;

				half4 posWorld = mul(_Object2World, v.vertex);

                fixed3 normalDirection = UnityObjectToWorldNormal(v.normal);
				fixed3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);

				fixed3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - posWorld.xyz);
                fixed3 halfDir = normalize(viewDirection+lightDirection);

				half NdotL = max(0,dot( normalDirection, lightDirection ));
				half HNdotL = max(0,dot(halfDir,normalDirection));
				o.dot = half2(NdotL,HNdotL);

                if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
                return o;
            }

            fixed4 frag(VertexOutput i) : COLOR {
//////// textureClr:
				fixed3 areaClr = tex2D(_AreaTex, TRANSFORM_TEX(i.uv0, _AreaTex));

				fixed4 alterClr = _ColorR * areaClr.r + _ColorG * areaClr.g + _ColorB * areaClr.b;	//color change

				fixed temp = alterClr.r + alterClr.g + alterClr.b;	

				fixed4 texClr = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));

				if(temp > 0.000001f)
				{
					texClr *= alterClr;
				}

////// Specular:
				fixed3 lightColor = _LightColor0.rgb;
				half gloss = _Gloss;
                half specPow = exp2( gloss * 10.0+1.0);
				fixed3 specular = pow(i.dot.y,specPow) * _SpecColor * texClr;

/////// Diffuse:
                fixed3 diffuse = _DiffIntensity * texClr.rgb * lightColor * i.dot.x;

////// Emissive:
                fixed3 emissive = texClr.rgb*_EmissIntensity;

/// Final Color:
                fixed3 finalColor = diffuse + specular + emissive;
                fixed4 col = fixed4(finalColor,texClr.a);
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
					
                return col;
            }
            ENDCG
        }
    }
}