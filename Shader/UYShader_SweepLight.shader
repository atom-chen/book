// Shader created with Shader Forge v1.18 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge     
Shader "UYShader/Particles/SweepLight" 
{
    Properties 
    {
        _Texture ("Texture", 2D) = "white" {}
        _node_3346 ("node_3346", 2D) = "white" {}
        _node_228 ("node_228", Color) = (1,0,0,1)
		_TimeEditor ("TimeEditor", Vector) = (1, 1, 1, 1)
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
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform fixed4 _LightColor0;
            uniform half4 _TimeEditor;

            uniform sampler2D _Texture; 
			uniform half4 _Texture_ST;

            uniform sampler2D _node_3346; 
			uniform half4 _node_3346_ST;
            uniform fixed4 _node_228;

            struct VertexInput {
                half4 vertex : POSITION;
                half3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half4 posWorld : TEXCOORD1;
                half3 normalDir : TEXCOORD2;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }

            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                half3 normalDirection = i.normalDir;
                fixed3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 lightColor = _LightColor0.rgb;

/////// Diffuse:
                half NdotL = max(0.0,dot( normalDirection, lightDirection ));
                fixed3 directDiffuse = max( 0.0, NdotL) * lightColor;
                half3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                fixed4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                fixed3 diffuseColor = _Texture_var.rgb;
                fixed3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                half4 node_7711 = _Time + _TimeEditor;
                half2 node_2277 = (i.uv0+node_7711.g*float2(0.5,0));
                half4 _node_3346_var = tex2D(_node_3346,TRANSFORM_TEX(node_2277, _node_3346));
                fixed3 emissive = saturate(min(_node_3346_var.rgb,_node_228.rgb));
/// Final Color:
                fixed3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,_Texture_var.a);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            
            uniform fixed4 _LightColor0;
            uniform half4 _TimeEditor;
            uniform sampler2D _Texture; 
			uniform half4 _Texture_ST;
            uniform sampler2D _node_3346; 
			uniform half4 _node_3346_ST;
            uniform fixed4 _node_228;
			
            struct VertexInput {
                half4 vertex : POSITION;
                half3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half4 posWorld : TEXCOORD1;
                half3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                fixed3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                fixed3 attenColor = attenuation * lightColor;
/////// Diffuse:
                half NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half3 directDiffuse = max( 0.0, NdotL) * attenColor;
                fixed4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                fixed3 diffuseColor = _Texture_var.rgb;
                fixed3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                fixed4 finalRGBA = fixed4(diffuse * _Texture_var.a,0);
                return finalRGBA;
            }
            ENDCG
        }
    }
}