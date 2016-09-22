Shader "UYShader/Specular_Color" 
{
	Properties 
	{
        _Texture ("Texture", 2D) = "white" {}
        _DiffIntensity ("DiffIntensity", Range(0, 1)) = 0.6
        _SpecColor ("SpecColor", Color) = (1,1,1,1)
        _Gloss ("Gloss", Range(0, 1)) = 0.248
        _EmissIntensity ("EmissIntensity", Range(0, 1)) = 0.6
		
		_AreaTex("AreaTex", 2D) = "black"{}
		_ColorR("ColorR", Color) = (1,1,1,1)
		_ColorG("ColorG", Color) = (1,1,1,1)
		_ColorB("ColorB", Color) = (1,1,1,1)
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
            
            uniform fixed _EmissIntensity;
			fixed _Cutoff;
			
			uniform sampler2D _AreaTex;uniform half4 _AreaTex_ST;
			uniform fixed4 _ColorR;
			uniform fixed4 _ColorG;
			uniform fixed4 _ColorB;
            
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
////////////Vectors:
				fixed3 areaClr = tex2D(_AreaTex, TRANSFORM_TEX(i.uv0, _AreaTex));
				//color change
				fixed4 alterClr = _ColorR * areaClr.r + _ColorG * areaClr.g + _ColorB * areaClr.b;
				
				fixed temp = alterClr.r + alterClr.g + alterClr.b;		
				fixed4 texClr = tex2D(_Texture, i.uv0);
				
				if(temp > 0.000001f)
				{
					texClr *= alterClr;
				}

///////////SPecular:
				half specPow = exp2(_Gloss * 10 + 1);
				fixed4 specularClr = texClr * _SpecColor;
				fixed4 specular = pow(i.dot.y,specPow)*specularClr;

////////////DIFF:
                fixed4 diffuse = texClr * _DiffIntensity * i.dot.x * _LightColor0;

/////////Emission:
				fixed4 emission = texClr * _EmissIntensity;
				
                fixed4 col = diffuse + specular + emission;
				 
				col.rgb = lerp(unity_FogColor.rgb,col.rgb,saturate(i.fogCoord));
				col.a = _Cutoff;
                return col;
            }

            ENDCG
        }
    }
}