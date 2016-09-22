Shader "UYShader/Specular_RimLight" 
{
	Properties 
	{
        _Texture ("Texture", 2D) = "white" {}
        _DiffIntensity ("DiffIntensity", Range(0, 1)) = 0.6
        _RimColor ("RimColor", Color) = (0.5968559,0.8088235,0,1)
        _RimPower ("RimPower", Range(0.5, 8)) = 5.48
        _SpecColor ("SpecColor", Color) = (1,1,1,1)
        _Gloss ("Gloss", Range(0, 1)) = 0.248
        _EmissIntensity ("EmissIntensity", Range(0, 1)) = 0.6
		_Cutoff ("Alpha cutoff", Range(0,1)) = 1.0
    }
    SubShader 
    {
    	Tags 
    	{
            "RenderType"="Opaque" "Queue"="Transparent-1"
        }
        Pass 
        {
            Tags 
            {
                "LightMode"="ForwardBase"
            }
			Cull Back
			Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform fixed4 _LightColor0;
            
            uniform sampler2D _Texture;
            uniform fixed _DiffIntensity;
            
            uniform fixed4 _SpecColor;
            uniform fixed _Gloss;
            
            uniform fixed4 _RimColor;
            uniform half _RimPower;
			fixed _Cutoff;
            
            uniform fixed _EmissIntensity;
            
            struct VertexInput 
            {
                half4 vertex : POSITION;
                half4 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                half4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half2 dot : TEXCOORD1;
				half fogCoord : TEXCOORD2;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
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

            fixed4 frag(VertexOutput i) : SV_Target 
            {
///////////SPecular:
				fixed4 texClr = tex2D(_Texture, i.uv0);
				half specPow = exp2(_Gloss * 10 + 1);
				fixed4 specularClr = texClr * _SpecColor;
				fixed4 specular = pow(i.dot.y,specPow)*specularClr;
////////////DIFF:
				fixed4 diffClr = texClr * _DiffIntensity;
                fixed4 diffuse = diffClr * _LightColor0 * i.dot.x;
//////////Rim:
				fixed4 RimColor = (diffClr+_RimColor)*pow(1.0-i.dot.x,_RimPower);

/////////Emission:
				fixed4 emission = texClr * _EmissIntensity;
				
				
                fixed4 col = diffuse + specular + RimColor + emission;
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
               	return fixed4(col.rgb,_Cutoff);
            }

            ENDCG
        }
    }
}