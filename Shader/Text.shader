// Shader created with Shader Forge v1.13 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.13;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,nrsp:0,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,rprd:False,enco:False,rmgx:True,rpth:0,hqsc:True,hqlp:False,tesm:0,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:False,dith:0,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0,f2p0:False;n:type:ShaderForge.SFN_Final,id:962,x:33216,y:32722,varname:node_962,prsc:2|alpha-8776-OUT;n:type:ShaderForge.SFN_ValueProperty,id:8776,x:32315,y:32964,ptovrint:False,ptlb:alpha,ptin:_alpha,varname:node_8776,prsc:2,glob:False,v1:1;proporder:8776;pass:END;sub:END;*/

Shader "UYShader/Text" {
    Properties {
        _alpha ("alpha", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass 
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform fixed _alpha;
			

            struct VertexInput {
                half4 vertex : POSITION;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half fogCoord : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				 else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
/////// Vectors:
////// Lighting:
                fixed3 finalColor = 0;
                fixed4 col = fixed4(finalColor,_alpha);
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));	
                return col;
            }
            ENDCG
        }
    }
    //FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
