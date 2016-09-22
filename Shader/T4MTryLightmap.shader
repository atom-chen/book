
Shader "T4MInstead/ShaderModel2/Diffuse/T4M 4 Textures_LightMap"
{
	Properties 
	{
        _Splat0 ("Splat0", 2D) = "white" {}
        _Splat1 ("Splat1", 2D) = "white" {}
        _Splat2 ("Splat2", 2D) = "white" {}
        _Splat3 ("Splat3", 2D) = "white" {}
        _Control ("Control", 2D) = "white" {}
    }
    SubShader
    {
    	Tags 
    	{
            "RenderType"="Opaque"
        }
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
            
            uniform sampler2D _Splat0; uniform float4 _Splat0_ST;
            uniform sampler2D _Splat1; uniform float4 _Splat1_ST;
            uniform sampler2D _Splat2; uniform float4 _Splat2_ST;
            uniform sampler2D _Splat3; uniform float4 _Splat3_ST;
            uniform sampler2D _Control;  uniform float4 _Control_ST;
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float fogCoord : TEXCOORD1;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	//o.uv0.xy = v.texcoord0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
            	o.uv0 = v.texcoord0;
				
				//计算雾效坐标
				if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
            	
				return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
                fixed4 clr0 = tex2D(_Splat0,TRANSFORM_TEX(i.uv0, _Splat0));
            	fixed4 clr1 = tex2D(_Splat1,TRANSFORM_TEX(i.uv0, _Splat1));
            	fixed4 clr2 = tex2D(_Splat2,TRANSFORM_TEX(i.uv0, _Splat2));
            	fixed4 clr3 = tex2D(_Splat3,TRANSFORM_TEX(i.uv0, _Splat3));
            	fixed4 control = tex2D(_Control,TRANSFORM_TEX(i.uv0, _Control));
            	fixed3 result = (clr0.rgb * control.r) + (clr1.rgb * control.g) + (clr2.rgb * control.b) + (clr3.rgb * control.a);
            	
                fixed4 col = fixed4(result, 1);
          
				//应用雾的颜色
				 
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
            
            uniform sampler2D _Splat0; uniform float4 _Splat0_ST;
            uniform sampler2D _Splat1; uniform float4 _Splat1_ST;
            uniform sampler2D _Splat2; uniform float4 _Splat2_ST;
            uniform sampler2D _Splat3; uniform float4 _Splat3_ST;
            uniform sampler2D _Control;  uniform float4 _Control_ST;
           
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float fogCoord : TEXCOORD2;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	//o.uv0.xy = v.texcoord0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
            	o.uv0 = v.texcoord0;
                o.uv1.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                //计算雾效坐标			
				if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
            	return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
                fixed4 clr0 = tex2D(_Splat0,TRANSFORM_TEX(i.uv0, _Splat0));
            	fixed4 clr1 = tex2D(_Splat1,TRANSFORM_TEX(i.uv0, _Splat1));
            	fixed4 clr2 = tex2D(_Splat2,TRANSFORM_TEX(i.uv0, _Splat2));
            	fixed4 clr3 = tex2D(_Splat3,TRANSFORM_TEX(i.uv0, _Splat3));
            	fixed4 control = tex2D(_Control,TRANSFORM_TEX(i.uv0, _Control));
            	fixed3 result = (clr0.rgb * control.r) + (clr1.rgb * control.g) + (clr2.rgb * control.b) + (clr3.rgb * control.a);
            	
                half4 lightmap = UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uv1);
                fixed3 lightClr = lightmap.rgb * lightmap.a*2;
                fixed4 col = fixed4(result*lightClr*4, 1);
                //应用雾的颜色
				 
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
            #include "UnityCG.cginc"
            
            uniform sampler2D _Splat0; uniform float4 _Splat0_ST;
            uniform sampler2D _Splat1; uniform float4 _Splat1_ST;
            uniform sampler2D _Splat2; uniform float4 _Splat2_ST;
            uniform sampler2D _Splat3; uniform float4 _Splat3_ST;
            uniform sampler2D _Control;  uniform float4 _Control_ST;
           
            
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float fogCoord : TEXCOORD2;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	//o.uv0.xy = v.texcoord0.xy * _Splat0_ST.xy + _Splat0_ST.zw;
            	o.uv0 = v.texcoord0;
                o.uv1.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
            	return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
                fixed4 clr0 = tex2D(_Splat0,TRANSFORM_TEX(i.uv0, _Splat0));
            	fixed4 clr1 = tex2D(_Splat1,TRANSFORM_TEX(i.uv0, _Splat1));
            	fixed4 clr2 = tex2D(_Splat2,TRANSFORM_TEX(i.uv0, _Splat2));
            	fixed4 clr3 = tex2D(_Splat3,TRANSFORM_TEX(i.uv0, _Splat3));
            	fixed4 control = tex2D(_Control,TRANSFORM_TEX(i.uv0, _Control));
            	fixed3 result = (clr0.rgb * control.r) + (clr1.rgb * control.g) + (clr2.rgb * control.b) + (clr3.rgb * control.a);
            	
                half4 lightmap = UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uv1);
                fixed3 lightClr = lightmap.rgb * lightmap.a*2;
                fixed4 col = fixed4(result*lightClr*4, 1);
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));	
                return col;
            }

            ENDCG
        }
        
    }
}