
Shader "AUYShader/Scene/TCLM/AlphaTest" 
{
	Properties 
	{
        _MainTex ("Texture", 2D) = "white" {}
        _Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader 
    {
    	Tags {"RenderType"="Opaque" "IgnoreProjector"="True"}
        Pass 
        {
            Tags 
            {
                "LightMode"="Vertex"
            }
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform sampler2D _MainTex;
            fixed _Cutoff;

            struct VertexInput {
                half4 vertex : POSITION;
                half2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half fogCoord : TEXCOORD1;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	o.uv0 = v.texcoord0;
            	if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
            	return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
                fixed4 col = tex2D(_MainTex, i.uv0);
                clip(col.a - _Cutoff); 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
                return col;
            }

            ENDCG
        }
        
        Pass
        {
            Tags 
            {
                "LightMode"="VertexLMRGBM"
            }
        	CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform sampler2D _MainTex;
            half4 _MainTex_ST;
            fixed _Cutoff;

            // uniform sampler2D unity_Lightmap;
            // half4 unity_LightmapST;
            
            struct VertexInput {
                half4 vertex : POSITION;
                half2 texcoord0 : TEXCOORD0;
                half2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half2 uv1 : TEXCOORD1;
                half fogCoord : TEXCOORD2;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	o.uv0.xy = v.texcoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.uv1.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
            	return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
            	fixed4 clr = tex2D(_MainTex, i.uv0);
            	clip(clr.a - _Cutoff);
                half4 lightmap = UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uv1);
                fixed3 lightClr = lightmap.rgb * lightmap.a*2;
                fixed4 col = fixed4(clr*lightClr*4, 1);
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
                return col;
            }

            ENDCG
        }
        Pass
        {
            Tags 
            {
                "LightMode"="VertexLM"
            }
        	CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            #include "UnityCG.cginc"
            
            uniform sampler2D _MainTex;
            half4 _MainTex_ST;
            fixed _Cutoff;
            
            // uniform sampler2D unity_Lightmap;
            // half4 unity_LightmapST;
            
            struct VertexInput {
                half4 vertex : POSITION;
                half2 texcoord0 : TEXCOORD0;
                half2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half2 uv1 : TEXCOORD1;
                half fogCoord : TEXCOORD2;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	o.uv0.xy = v.texcoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                o.uv1.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
            	return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
                fixed4 clr = tex2D(_MainTex, i.uv0);
            	clip(clr.a - _Cutoff);
                half4 lightmap = UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uv1);
                fixed3 lightClr = lightmap.rgb * lightmap.a*2;
                fixed4 col = fixed4(clr*lightClr*4, 1);
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
                return col;
            }

            ENDCG
        }
    }
}