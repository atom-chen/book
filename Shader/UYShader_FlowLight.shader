Shader "UYShader/FlowLight/FlowLight" {
	Properties {
		//主贴图
		_Texture ("Texture", 2D) = "white" {}
		
		//流光贴图
		_FlowTex ("FlowTexture", 2D) = "black" {}
		
		//流光UV速度
		_uvaddspeedx ("speedx", float) = 1	
		_uvaddspeedy ("speedy", float) = 1

		//变色属性
		_AreaTex("AreaTex", 2D) = "white"{}
		_ColorR("ColorR", Color) = (1,1,1,1)
		_ColorG("ColorG", Color) = (1,1,1,1)
		_ColorB("ColorB", Color) = (1,1,1,1)
		_ChangeFlag ("ChangeColor", Range(0,1)) = 0
		_AlphaFactor("AlphaFactor",Range(0, 1)) = 1
	}
	SubShader {
		Pass 
        {
			Tags { "RenderType"="Opaque"}
			LOD 200
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _Texture;
			sampler2D _FlowTex;
			half _uvaddspeedx;
			half _uvaddspeedy;

			///是否变色标志位[0:不变色，1:变色]
			fixed _ChangeFlag;

			fixed _AlphaFactor;

			uniform sampler2D _AreaTex;
			uniform fixed4 _AreaTex_ST;
			uniform fixed4 _ColorR;
			uniform fixed4 _ColorG;
			uniform fixed4 _ColorB;

			struct VertexInput 
			{
				half4 vertex : POSITION;
				half4 normal : NORMAL;
				half2 texcoord0 : TEXCOORD0;
			};
			struct VertexOutput 
			{
				half4 pos : SV_POSITION;
				half2 uv0 : TEXCOORD0;
				half fogCoord : TEXCOORD1;
				fixed3 color : COLOR;
			};


			VertexOutput vert(VertexInput v) 
			{
				VertexOutput o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

				fixed3 viewDir = normalize(ObjSpaceViewDir(v.vertex));
				half dotProduct = 1 - dot(v.normal, viewDir);
				o.color = smoothstep(0, 1.0, dotProduct);

				o.uv0 = v.texcoord0;
				if(unity_FogParams.w == 0)
					o.fogCoord =1.0f;
				else
					o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
				return o;
			}

		
			fixed4 frag(VertexOutput i) : COLOR 
			{
				float2 uv = i.uv0;
				fixed4 alterClr = fixed4(1,1,1,1);

				if(_ChangeFlag > 0)
				{
					fixed3 areaClr = tex2D(_AreaTex, TRANSFORM_TEX(uv, _AreaTex));
					alterClr = _ColorR * areaClr.r + _ColorG * areaClr.g + _ColorB * areaClr.b;
				}
				
				fixed4 texClr = tex2D(_Texture, uv) * alterClr;

				uv.x /=2;
				uv.x += _Time.y * _uvaddspeedx;
				uv.y += _Time.y * _uvaddspeedy;


				fixed flow = tex2D(_FlowTex, uv).r;
				fixed4 col = texClr;

				col.rgb = texClr.rgb +  fixed3(flow,flow,flow) + i.color*_AlphaFactor;
				return col;
			}
			ENDCG
		}
	} 
}
