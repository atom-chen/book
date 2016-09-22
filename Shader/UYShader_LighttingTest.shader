Shader "UYShader/Lightting_Test(美术验证模型数据是否正确)" {
    Properties {
        _Texture ("Base (RGB)", 2D) = "white" {}
        _Color ("Main Color", Color) = (1,1,1,1)
        _RimColor ("Rim Color", Color) = (1, 1, 1, 1)
		_RimWidth ("Rim Width", Range(0, 1)) = 0.7
		_AlphaFactor("AlphaFactor",Range(0, 1)) = 1
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

                uniform half4 _Texture_ST;
                uniform fixed4 _RimColor;
                fixed _RimWidth;
				fixed _AlphaFactor;

                v2f vert (appdata_base v) {
                    v2f o;
                    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
					
					half4 posWorld = mul(_Object2World, v.vertex);
					fixed3 norDir = UnityObjectToWorldNormal(v.normal);
					fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - posWorld.xyz);
                    fixed dotProduct = 1 - max(0,dot(norDir, viewDir));

                    o.color = smoothstep(1 - _RimWidth, 1.0, dotProduct);
                    //o.color *= _RimColor;
					o.color = norDir;

                    o.uv = v.texcoord.xy;
                    return o;
                }

                uniform sampler2D _Texture;
                uniform fixed4 _Color;

                fixed4 frag(v2f i) : COLOR {
                    fixed4 texcol = tex2D(_Texture, i.uv);
                    texcol *= _Color;
                    texcol.rgb += i.color * _AlphaFactor;
                    //return texcol;
					return fixed4(i.color,1);
                }
            ENDCG
        }
    }
}