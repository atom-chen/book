Shader "Particles/SweepL_R" {
    Properties {
        _Sweep ("Sweep", 2D) = "white" {}
		_MainTexture ("Texture", 2D) = "white" {}
        _TintColor ("Color", Color) = (0.5,0.5,0.5,1)
		_TimeEditor ("TimeEditor", Vector) = (1, 1, 1, 1)
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha One
            ZWrite Off
			Fog{Mode off}
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            uniform half4 _TimeEditor;
			uniform fixed4 _TintColor;
            uniform sampler2D _Sweep; 
			uniform half4 _Sweep_ST;

            uniform sampler2D _MainTexture; 
			uniform half4 _MainTexture_ST;

            struct VertexInput {
                half4 vertex : POSITION;
                half2 texcoord0 : TEXCOORD0;
            };

            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
            };

            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }

            fixed4 frag(VertexOutput i) : COLOR {
                half4 node_6668 = _Time + _TimeEditor;
                half2 node_9280 = (i.uv0+node_6668.g*float2(-0.5,0));

                fixed4 _Sweep_var = tex2D(_Sweep,TRANSFORM_TEX(node_9280, _Sweep));
                fixed3 emissive = (_Sweep_var.rgb*_TintColor.rgb);
                fixed3 finalColor = emissive;
                fixed4 _Texture_var = tex2D(_MainTexture,TRANSFORM_TEX(i.uv0, _MainTexture));
                fixed4 finalRGBA = fixed4(finalColor,_Texture_var.a);
                return finalRGBA;
            }
            ENDCG
        }
    }
    //FallBack "Diffuse"
}
