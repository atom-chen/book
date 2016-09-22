// Shader created with Shader Forge v1.13 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.13;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,nrsp:0,limd:3,spmd:0,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:True,dith:0,ufog:True,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:6985,x:34954,y:32588,varname:node_6985,prsc:2|diff-6212-OUT,spec-5572-OUT,gloss-5656-OUT,emission-8259-OUT,alpha-5882-A;n:type:ShaderForge.SFN_Tex2d,id:5882,x:33128,y:32426,varname:node_5882,prsc:2,tex:8e31b4252ecf7d949bae792d3060d3fe,ntxv:0,isnm:False|TEX-9554-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:9554,x:32887,y:32364,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_9554,glob:False,tex:8e31b4252ecf7d949bae792d3060d3fe,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ViewVector,id:3810,x:32810,y:32681,varname:node_3810,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:8090,x:32965,y:32804,prsc:2,pt:False;n:type:ShaderForge.SFN_Normalize,id:7840,x:32965,y:32681,varname:node_7840,prsc:2|IN-3810-OUT;n:type:ShaderForge.SFN_Dot,id:7950,x:33129,y:32726,varname:node_7950,prsc:2,dt:0|A-7840-OUT,B-8090-OUT;n:type:ShaderForge.SFN_Clamp01,id:3590,x:33294,y:32787,varname:node_3590,prsc:2|IN-7950-OUT;n:type:ShaderForge.SFN_Vector1,id:5526,x:33294,y:32711,varname:node_5526,prsc:2,v1:1;n:type:ShaderForge.SFN_Subtract,id:3280,x:33455,y:32744,varname:node_3280,prsc:2|A-5526-OUT,B-3590-OUT;n:type:ShaderForge.SFN_Power,id:3471,x:33729,y:32942,varname:node_3471,prsc:2|VAL-3280-OUT,EXP-3160-OUT;n:type:ShaderForge.SFN_Color,id:7192,x:33619,y:32782,ptovrint:False,ptlb:RimColor,ptin:_RimColor,varname:node_7192,prsc:2,glob:False,c1:0,c2:0.4406694,c3:0.8088235,c4:1;n:type:ShaderForge.SFN_Multiply,id:9077,x:33930,y:32925,varname:node_9077,prsc:2|A-705-OUT,B-3471-OUT;n:type:ShaderForge.SFN_Multiply,id:6212,x:33536,y:32296,varname:node_6212,prsc:2|A-8072-OUT,B-5882-RGB;n:type:ShaderForge.SFN_Slider,id:8072,x:33115,y:32288,ptovrint:False,ptlb:DiffIntensity,ptin:_DiffIntensity,varname:node_8072,prsc:2,min:0,cur:0.8632484,max:1;n:type:ShaderForge.SFN_Slider,id:3160,x:33319,y:32934,ptovrint:False,ptlb:RimPower,ptin:_RimPower,varname:node_3160,prsc:2,min:0.5,cur:4,max:8;n:type:ShaderForge.SFN_Color,id:3571,x:33986,y:32468,ptovrint:False,ptlb:SpecColor,ptin:_SpecColor,varname:node_3571,prsc:2,glob:False,c1:0.3278546,c2:0.05017301,c3:0.4264706,c4:1;n:type:ShaderForge.SFN_Slider,id:5656,x:33914,y:32219,ptovrint:False,ptlb:Gloss,ptin:_Gloss,varname:node_5656,prsc:2,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Add,id:705,x:33816,y:32782,varname:node_705,prsc:2|A-6212-OUT,B-7192-RGB;n:type:ShaderForge.SFN_Add,id:8259,x:34372,y:33014,varname:node_8259,prsc:2|A-8252-OUT,B-3267-OUT;n:type:ShaderForge.SFN_Multiply,id:3267,x:33865,y:33125,varname:node_3267,prsc:2|A-5882-RGB,B-6870-OUT;n:type:ShaderForge.SFN_Slider,id:6870,x:33274,y:33105,ptovrint:False,ptlb:EmissIntensity,ptin:_EmissIntensity,varname:node_6870,prsc:2,min:0,cur:0.6068386,max:1;n:type:ShaderForge.SFN_SwitchProperty,id:8252,x:34171,y:32890,ptovrint:False,ptlb:OpenRim,ptin:_OpenRim,varname:node_8252,prsc:2,on:False|A-5509-OUT,B-9077-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5572,x:34505,y:32624,ptovrint:False,ptlb:OpenSpec,ptin:_OpenSpec,varname:node_5572,prsc:2,on:True|A-2619-OUT,B-3700-OUT;n:type:ShaderForge.SFN_Vector3,id:2619,x:34195,y:32496,varname:node_2619,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_Vector3,id:5509,x:34001,y:32817,varname:node_5509,prsc:2,v1:0,v2:0,v3:0;n:type:ShaderForge.SFN_Multiply,id:3700,x:34235,y:32607,varname:node_3700,prsc:2|A-3571-RGB,B-5882-RGB;proporder:9554-8072-8252-7192-3160-5572-3571-5656-6870;pass:END;sub:END;*/

Shader "UYShader/Transparent" {
    Properties {
        _Texture ("Texture", 2D) = "white" {}
        _DiffIntensity ("DiffIntensity", Range(0, 1)) = 0.8632484
        [MaterialToggle] _OpenRim ("OpenRim", Float ) = 0
        _RimColor ("RimColor", Color) = (0,0.4406694,0.8088235,1)
        _RimPower ("RimPower", Range(0.5, 8)) = 4
        [MaterialToggle] _OpenSpec ("OpenSpec", Float ) = 0
        _SpecColor ("SpecColor", Color) = (0.3278546,0.05017301,0.4264706,1)
        _Gloss ("Gloss", Range(0, 1)) = 1
        _EmissIntensity ("EmissIntensity", Range(0, 1)) = 0.6068386
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            //#pragma multi_compile_fwdbase
            //#pragma multi_compile_fog
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _RimColor;
            uniform float _DiffIntensity;
            uniform float _RimPower;
            uniform float _Gloss;
            uniform float _EmissIntensity;
            uniform fixed _OpenRim;
            uniform fixed _OpenSpec;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float fogCoord : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(_Object2World, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                UnityGI gi = UnityGlobalIllumination (d, 1, gloss, normalDirection);
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 node_5882 = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                float3 specularColor = lerp( float3(0,0,0), (_SpecColor.rgb*node_5882.rgb), _OpenSpec );
                float specularMonochrome = max( max(specularColor.r, specularColor.g), specularColor.b);
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * unity_LightGammaCorrectionConsts_PIDiv4 );
                float3 directSpecular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float3 node_6212 = (_DiffIntensity*node_5882.rgb);
                float3 diffuseColor = node_6212;
                diffuseColor *= 1-specularMonochrome;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = (lerp( float3(0,0,0), ((node_6212+_RimColor.rgb)*pow((1.0-saturate(dot(normalize(viewDirection),i.normalDir))),_RimPower)), _OpenRim )+(node_5882.rgb*_EmissIntensity));
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                fixed4 col = fixed4(finalColor,node_5882.a);
				 
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
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            //#pragma multi_compile_fwdadd
            //#pragma multi_compile_fog
            #pragma exclude_renderers d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _RimColor;
            uniform float _DiffIntensity;
            uniform float _RimPower;
            uniform float _Gloss;
            uniform float _EmissIntensity;
            uniform fixed _OpenRim;
            uniform fixed _OpenSpec;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(_Object2World, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Vectors:
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                fixed3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                fixed3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = _Gloss;
                float specPow = exp2( gloss * 10.0+1.0);
////// Specular:
                float NdotL = max(0, dot( normalDirection, lightDirection ));
                float LdotH = max(0.0,dot(lightDirection, halfDirection));
                float4 node_5882 = tex2D(_Texture,TRANSFORM_TEX(i.uv0, _Texture));
                fixed3 specularColor = lerp( float3(0,0,0), (_SpecColor.rgb*node_5882.rgb), _OpenSpec );
                fixed specularMonochrome = max( max(specularColor.r, specularColor.g), specularColor.b);
                float NdotV = max(0.0,dot( normalDirection, viewDirection ));
                float NdotH = max(0.0,dot( normalDirection, halfDirection ));
                float VdotH = max(0.0,dot( viewDirection, halfDirection ));
                float visTerm = SmithBeckmannVisibilityTerm( NdotL, NdotV, 1.0-gloss );
                float normTerm = max(0.0, NDFBlinnPhongNormalizedTerm(NdotH, RoughnessToSpecPower(1.0-gloss)));
                float specularPBL = max(0, (NdotL*visTerm*normTerm) * unity_LightGammaCorrectionConsts_PIDiv4 );
                float3 directSpecular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),specPow)*specularPBL*lightColor*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float3 directDiffuse = ((1 +(fd90 - 1)*pow((1.00001-NdotL), 5)) * (1 + (fd90 - 1)*pow((1.00001-NdotV), 5)) * NdotL) * attenColor;
                float3 node_6212 = (_DiffIntensity*node_5882.rgb);
                float3 diffuseColor = node_6212;
                diffuseColor *= 1-specularMonochrome;
                fixed3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                fixed3 finalColor = diffuse + specular;
                return fixed4(finalColor * node_5882.a,0);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}