Shader "UYShader/BloodUI" 
{
	Properties 
	{
        _Texture ("Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)

		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255

		_ColorMask ("Color Mask", Float) = 15
    }
    SubShader 
    {
    	Tags 
    	{
            "RenderType"="Opaque" 
			"IgnoreProjector"="True" 
			"Queue"="Transparent-1"
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
        }
		Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp] 
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
		}

		Cull Off
		Lighting Off
		ZWrite Off
		ZTest [unity_GUIZTestMode]
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

        Pass 
        {
			Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            uniform sampler2D _Texture;
			fixed4 _Color;

            struct VertexInput 
            {
                half4 vertex : POSITION;
                fixed4 color : COLOR;
                half2 texcoord0 : TEXCOORD0;
            };

            struct VertexOutput {
                half4 pos : SV_POSITION;
				fixed4 color : COLOR;
                half2 uv0 : TEXCOORD0;
            };

            VertexOutput vert(VertexInput v) 
            {
            	VertexOutput o;
            	o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
            	o.uv0 = v.texcoord0;
				o.color = v.color * _Color;
            	return o;
            }

            fixed4 frag(VertexOutput i) : SV_Target 
            {
				fixed4 texClr = tex2D(_Texture, i.uv0) * i.color;
				clip (texClr.a - 0.01);
                return texClr;
            }

            ENDCG
        }
    }
}