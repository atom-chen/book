Shader "UYShader/Lightting_Color" {
    Properties {
        _Texture ("Base (RGB)", 2D) = "white" {}
        _Color ("Main Color", Color) = (1,1,1,1)
        _RimColor ("Rim Color", Color) = (1, 1, 1, 1)
		_RimWidth ("Rim Width", Range(0, 1)) = 0.7
		_AlphaFactor("AlphaFactor",Range(0, 1)) = 1

		_AreaTex("AreaTex", 2D) = "black"{}
		_ColorR("ColorR", Color) = (1,1,1,1)
		_ColorG("ColorG", Color) = (1,1,1,1)
		_ColorB("ColorB", Color) = (1,1,1,1)
    }
    SubShader {
        Pass {
       		Lighting Off
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                struct appdata {
                    half4 vertex : POSITION;
                    half3 normal : NORMAL;
                    half2 texcoord : TEXCOORD0;
                };

                struct v2f {
                    half4 pos : SV_POSITION;
                    half2 uv : TEXCOORD0;
                    fixed3 color : COLOR;
                };

                uniform float4 _Texture_ST;
                uniform fixed4 _RimColor;
                fixed _RimWidth;
				fixed _AlphaFactor;

                v2f vert (appdata_base v) {
                    v2f o;
                    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

                    fixed3 viewDir = normalize(ObjSpaceViewDir(v.vertex));
                    half dotProduct = 1 - dot(v.normal, viewDir);
                   
                    o.color = smoothstep(1 - _RimWidth, 1.0, dotProduct);
                    o.color *= _RimColor;
                    o.uv = v.texcoord.xy;
                    return o;
                }

                uniform sampler2D _Texture;
                uniform fixed4 _Color;

				uniform sampler2D _AreaTex;
				uniform half4 _AreaTex_ST;
				uniform fixed4 _ColorR;
				uniform fixed4 _ColorG;
				uniform fixed4 _ColorB;

                fixed4 frag(v2f i) : COLOR {
					//变色处理
					fixed3 areaClr = tex2D(_AreaTex, TRANSFORM_TEX(i.uv, _AreaTex));
					fixed4 alterClr = _ColorR * areaClr.r + _ColorG * areaClr.g + _ColorB * areaClr.b;

					fixed temp = alterClr.r + alterClr.g + alterClr.b;
                    fixed4 texcol = tex2D(_Texture, i.uv);

					if(temp > 0.000001f)
					{
						texcol *= alterClr;
					}

                    texcol *= _Color;
                    texcol.rgb += i.color * _AlphaFactor;
                    return texcol;
                }
            ENDCG
        }
    }
}