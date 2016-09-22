// Shader created with Shader Forge v1.16 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.16;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:3487,x:34621,y:32654,varname:node_3487,prsc:2|diff-9756-OUT,emission-2498-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:9542,x:33217,y:32410,ptovrint:False,ptlb:Splat0,ptin:_Splat0,varname:node_9542,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:8734,x:33217,y:32593,ptovrint:False,ptlb:Splat1,ptin:_Splat1,varname:_Splat1,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:4121,x:33217,y:32771,ptovrint:False,ptlb:Splat2,ptin:_Splat2,varname:_Splat2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:4245,x:33217,y:32952,ptovrint:False,ptlb:Splat3,ptin:_Splat3,varname:_Splat3,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:6441,x:33217,y:33136,ptovrint:False,ptlb:Control,ptin:_Control,varname:_Splat4,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:8100,x:33206,y:33328,ptovrint:False,ptlb:MainText,ptin:_MainText,varname:_Splat5,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:8203,x:33462,y:32397,varname:node_8203,prsc:2,ntxv:0,isnm:False|TEX-9542-TEX;n:type:ShaderForge.SFN_Tex2d,id:7977,x:33427,y:32753,varname:_node_2596_copy,prsc:2,ntxv:0,isnm:False|TEX-4121-TEX;n:type:ShaderForge.SFN_Tex2d,id:5484,x:33447,y:32934,varname:_node_2596_copy_copy,prsc:2,ntxv:0,isnm:False|TEX-4245-TEX;n:type:ShaderForge.SFN_Tex2d,id:4019,x:33422,y:33111,varname:_node_2596_copy_copy_copy,prsc:2,ntxv:0,isnm:False|TEX-6441-TEX;n:type:ShaderForge.SFN_Multiply,id:5195,x:33843,y:32404,varname:node_5195,prsc:2|A-8203-RGB,B-4019-R;n:type:ShaderForge.SFN_Multiply,id:9533,x:33843,y:32564,varname:node_9533,prsc:2|A-4805-RGB,B-4019-G;n:type:ShaderForge.SFN_Multiply,id:6056,x:33829,y:32733,varname:node_6056,prsc:2|A-7977-RGB,B-4019-B;n:type:ShaderForge.SFN_Multiply,id:2470,x:33829,y:32898,varname:node_2470,prsc:2|A-5484-RGB,B-4019-A;n:type:ShaderForge.SFN_Add,id:9756,x:34107,y:32569,varname:node_9756,prsc:2|A-5195-OUT,B-9533-OUT,C-6056-OUT,D-2470-OUT;n:type:ShaderForge.SFN_Tex2d,id:4805,x:33464,y:32568,varname:node_4805,prsc:2,ntxv:0,isnm:False|TEX-8734-TEX;n:type:ShaderForge.SFN_Color,id:9211,x:34055,y:32837,ptovrint:False,ptlb:Emission,ptin:_Emission,varname:node_9211,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:2498,x:34338,y:32794,varname:node_2498,prsc:2|A-9756-OUT,B-9211-RGB;proporder:9211-9542-8734-4121-4245-6441;pass:END;sub:END;*/

Shader "T4MInstead/ShaderModel2/Diffuse/T4M 4 Textures" {
    Properties {
        _Emission ("Emission", Color) = (0,0,0,1)
        _Splat0 ("Splat0", 2D) = "white" {}
        _Splat1 ("Splat1", 2D) = "white" {}
        _Splat2 ("Splat2", 2D) = "white" {}
        _Splat3 ("Splat3", 2D) = "white" {}
        _Control ("Control", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        LOD 250
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
             
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _Splat0; uniform float4 _Splat0_ST;
            uniform sampler2D _Splat1; uniform float4 _Splat1_ST;
            uniform sampler2D _Splat2; uniform float4 _Splat2_ST;
            uniform sampler2D _Splat3; uniform float4 _Splat3_ST;
            uniform sampler2D _Control; uniform float4 _Control_ST;
            uniform fixed4 _Emission;

            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
				float fogCoord : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD8;
                #endif
				
            };
            VertexOutput vert (VertexInput v) 
			{
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
				#endif
				#ifdef DYNAMICLIGHTMAP_ON
					o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				o.posWorld = mul(_Object2World, v.vertex);
				fixed3 lightColor = _LightColor0.rgb;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				//计算雾效坐标
				if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;

				TRANSFER_VERTEX_TO_FRAGMENT(o)
				return o;
			}
			fixed4 frag(VertexOutput i) : COLOR 
			{
				i.normalDir = normalize(i.normalDir);
	/// Vectors:
				fixed3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
				fixed3 normalDirection = i.normalDir;
				fixed3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				fixed3 lightColor = _LightColor0.rgb;
	// Lighting:
				float attenuation = LIGHT_ATTENUATION(i);
				fixed3 attenColor = attenuation * _LightColor0.xyz;
	/// GI Data:
				UnityLight light;
				#ifdef LIGHTMAP_OFF
					light.color = lightColor;
					light.dir = lightDirection;
					light.ndotl = LambertTerm (normalDirection, light.dir);
				#else
					light.color = fixed3(0.f, 0.f, 0.f);
					light.ndotl = 0.0f;
					light.dir = fixed3(0.f, 0.f, 0.f);
				#endif
				UnityGIInput d;
				d.light = light;
				d.worldPos = i.posWorld.xyz;
				d.worldViewDir = viewDirection;
				d.atten = attenuation;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					d.ambient = 0;
					d.lightmapUV = i.ambientOrLightmapUV;
				#else
					d.ambient = i.ambientOrLightmapUV;
				#endif
				UnityGI gi = UnityGlobalIllumination (d, 1, 0, normalDirection);
				lightDirection = gi.light.dir;
				lightColor = gi.light.color;
	/// Diffuse:
				half NdotL = max(0.0,dot( normalDirection, lightDirection ));
				fixed3 directDiffuse = max( 0.0, NdotL) * attenColor;
				fixed3 indirectDiffuse = fixed3(0,0,0);
				indirectDiffuse += gi.indirect.diffuse;
				fixed4 node_8203 = tex2D(_Splat0,TRANSFORM_TEX(i.uv0, _Splat0));
				fixed4 _node_2596_copy_copy_copy = tex2D(_Control,TRANSFORM_TEX(i.uv0, _Control));
				fixed4 node_4805 = tex2D(_Splat1,TRANSFORM_TEX(i.uv0, _Splat1));
				fixed4 _node_2596_copy = tex2D(_Splat2,TRANSFORM_TEX(i.uv0, _Splat2));
				fixed4 _node_2596_copy_copy = tex2D(_Splat3,TRANSFORM_TEX(i.uv0, _Splat3));
				fixed3 node_9756 = ((node_8203.rgb*_node_2596_copy_copy_copy.r)+(node_4805.rgb*_node_2596_copy_copy_copy.g)+(_node_2596_copy.rgb*_node_2596_copy_copy_copy.b)+(_node_2596_copy_copy.rgb*_node_2596_copy_copy_copy.a));
				fixed3 diffuseColor = node_9756;
				fixed3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
	// Emissive:
				fixed3 emissive = (node_9756*_Emission.rgb);
	// Final Color:
				fixed3 finalColor = diffuse + emissive;
				fixed4 col = fixed4(finalColor,1);
            
				//应用雾的颜色
			 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
				return col;
			}
        ENDCG
    }
    Pass {
        Name "FORWARD_DELTA"
        Tags {
            "LightMode"="ForwardAdd"
        }
        Blend One One
        
        
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #define UNITY_PASS_FORWARDADD
        #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
        #include "UnityCG.cginc"
        #include "AutoLight.cginc"
        #include "Lighting.cginc"
        #include "UnityPBSLighting.cginc"
        #include "UnityStandardBRDF.cginc"
        #pragma multi_compile_fwdadd_fullshadows
        #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
        #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
        #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
        #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
        #pragma target 3.0
        uniform sampler2D _Splat0; uniform float4 _Splat0_ST;
        uniform sampler2D _Splat1; uniform float4 _Splat1_ST;
        uniform sampler2D _Splat2; uniform float4 _Splat2_ST;
        uniform sampler2D _Splat3; uniform float4 _Splat3_ST;
        uniform sampler2D _Control; uniform float4 _Control_ST;
        uniform float4 _Emission;

        struct VertexInput {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 tangent : TANGENT;
            float2 texcoord0 : TEXCOORD0;
            float2 texcoord1 : TEXCOORD1;
            float2 texcoord2 : TEXCOORD2;
        };
        struct VertexOutput {
            float4 pos : SV_POSITION;
            float2 uv0 : TEXCOORD0;
            float2 uv1 : TEXCOORD1;
            float2 uv2 : TEXCOORD2;
            float4 posWorld : TEXCOORD3;
            float3 normalDir : TEXCOORD4;
            LIGHTING_COORDS(5,6)
        };
        VertexOutput vert (VertexInput v) {
            VertexOutput o = (VertexOutput)0;
            o.uv0 = v.texcoord0;
            o.uv1 = v.texcoord1;
            o.uv2 = v.texcoord2;
            o.normalDir = UnityObjectToWorldNormal(v.normal);
            o.posWorld = mul(_Object2World, v.vertex);
            fixed3 lightColor = _LightColor0.rgb;
            o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
            TRANSFER_VERTEX_TO_FRAGMENT(o)
            return o;
        }
        fixed4 frag(VertexOutput i) : COLOR {
            i.normalDir = normalize(i.normalDir);
/// Vectors:
            fixed3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
            fixed3 normalDirection = i.normalDir;
            fixed3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
            fixed3 lightColor = _LightColor0.rgb;
// Lighting:
            half attenuation = LIGHT_ATTENUATION(i);
            fixed3 attenColor = attenuation * _LightColor0.xyz;
/// Diffuse:
            half NdotL = max(0.0,dot( normalDirection, lightDirection ));
            fixed3 directDiffuse = max( 0.0, NdotL) * attenColor;
            fixed4 node_8203 = tex2D(_Splat0,TRANSFORM_TEX(i.uv0, _Splat0));
            fixed4 _node_2596_copy_copy_copy = tex2D(_Control,TRANSFORM_TEX(i.uv0, _Control));
            fixed4 node_4805 = tex2D(_Splat1,TRANSFORM_TEX(i.uv0, _Splat1));
            fixed4 _node_2596_copy = tex2D(_Splat2,TRANSFORM_TEX(i.uv0, _Splat2));
            fixed4 _node_2596_copy_copy = tex2D(_Splat3,TRANSFORM_TEX(i.uv0, _Splat3));
            fixed3 node_9756 = ((node_8203.rgb*_node_2596_copy_copy_copy.r)+(node_4805.rgb*_node_2596_copy_copy_copy.g)+(_node_2596_copy.rgb*_node_2596_copy_copy_copy.b)+(_node_2596_copy_copy.rgb*_node_2596_copy_copy_copy.a));
            fixed3 diffuseColor = node_9756;
            fixed3 diffuse = directDiffuse * diffuseColor;
// Final Color:
            fixed3 finalColor = diffuse;
            return fixed4(finalColor * 1,0);
        }
        ENDCG
    }
    Pass {
        Name "Meta"
        Tags {
            "LightMode"="Meta"
        }
        Cull Off
        
        CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #define UNITY_PASS_META 1
        #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
        #include "UnityCG.cginc"
        #include "Lighting.cginc"
        #include "UnityPBSLighting.cginc"
        #include "UnityStandardBRDF.cginc"
        #include "UnityMetaPass.cginc"
        #pragma fragmentoption ARB_precision_hint_fastest
        #pragma multi_compile_shadowcaster
        #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
        #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
        #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
        #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
        #pragma target 3.0
        uniform sampler2D _Splat0; uniform float4 _Splat0_ST;
        uniform sampler2D _Splat1; uniform float4 _Splat1_ST;
        uniform sampler2D _Splat2; uniform float4 _Splat2_ST;
        uniform sampler2D _Splat3; uniform float4 _Splat3_ST;
        uniform sampler2D _Control; uniform float4 _Control_ST;
        uniform float4 _Emission;
        struct VertexInput {
            float4 vertex : POSITION;
            float2 texcoord0 : TEXCOORD0;
            float2 texcoord1 : TEXCOORD1;
            float2 texcoord2 : TEXCOORD2;
        };
        struct VertexOutput {
            float4 pos : SV_POSITION;
            float2 uv0 : TEXCOORD0;
            float2 uv1 : TEXCOORD1;
            float2 uv2 : TEXCOORD2;
            float4 posWorld : TEXCOORD3;
        };
        VertexOutput vert (VertexInput v) {
            VertexOutput o = (VertexOutput)0;
            o.uv0 = v.texcoord0;
            o.uv1 = v.texcoord1;
            o.uv2 = v.texcoord2;
            o.posWorld = mul(_Object2World, v.vertex);
            o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
            return o;
        }
        fixed4 frag(VertexOutput i) : SV_Target {
/// Vectors:
            UnityMetaInput o;
            UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
            
            fixed4 node_8203 = tex2D(_Splat0,TRANSFORM_TEX(i.uv0, _Splat0));
            fixed4 _node_2596_copy_copy_copy = tex2D(_Control,TRANSFORM_TEX(i.uv0, _Control));
            fixed4 node_4805 = tex2D(_Splat1,TRANSFORM_TEX(i.uv0, _Splat1));
            fixed4 _node_2596_copy = tex2D(_Splat2,TRANSFORM_TEX(i.uv0, _Splat2));
            fixed4 _node_2596_copy_copy = tex2D(_Splat3,TRANSFORM_TEX(i.uv0, _Splat3));
            fixed3 node_9756 = ((node_8203.rgb*_node_2596_copy_copy_copy.r)+(node_4805.rgb*_node_2596_copy_copy_copy.g)+(_node_2596_copy.rgb*_node_2596_copy_copy_copy.b)+(_node_2596_copy_copy.rgb*_node_2596_copy_copy_copy.a));
            o.Emission = (node_9756*_Emission.rgb);
            
            fixed3 diffColor = node_9756;
            o.Albedo = diffColor;
            
            return UnityMetaFragment( o );
        }
        ENDCG
    }
}
FallBack "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}
