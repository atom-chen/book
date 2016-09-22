Shader "UYShader/UI/Mask"
{
   Properties
   {
      [PerRendererData]_MainTex("Sprite Texture", 2D) = "white" {}
      _MainTex_TRS("Main Texture TRS",Vector) = (0.5,0.5,0,1)
      _MaskTex("Mask Texture",2D) = "white" {}
      _Color("Tint", Color) = (1,1,1,1)

      _StencilComp("Stencil Comparison", Float) = 8
      _Stencil("Stencil ID", Float) = 0
      _StencilOp("Stencil Operation", Float) = 0
      _StencilWriteMask("Stencil Write Mask", Float) = 255
      _StencilReadMask("Stencil Read Mask", Float) = 255

      _ColorMask("Color Mask", Float) = 15

      [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0
   }

      SubShader
   {
      Tags
   {
      "Queue" = "Transparent"
      "IgnoreProjector" = "True"
      "RenderType" = "Transparent"
      "PreviewType" = "Plane"
      "CanUseSpriteAtlas" = "True"
   }

      Stencil
   {
      Ref[_Stencil]
      Comp[_StencilComp]
      Pass[_StencilOp]
      ReadMask[_StencilReadMask]
      WriteMask[_StencilWriteMask]
   }

      Cull Off
      Lighting Off
      ZWrite Off
      ZTest[unity_GUIZTestMode]
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask[_ColorMask]

   Pass
   {
      CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"
#include "UnityUI.cginc"

#pragma multi_compile __ UNITY_UI_ALPHACLIP

   struct appdata_t
   {
      float4 vertex   : POSITION;
      float4 color    : COLOR;
      float2 texcoord : TEXCOORD0;
   };

   struct v2f
   {
      float4 vertex   : SV_POSITION;
      fixed4 color : COLOR;
      half2 uvMain  : TEXCOORD0;
      float4 worldPosition : TEXCOORD1;
      half2 uvMask  : TEXCOORD2;
   };

   fixed4 _Color;
   fixed4 _TextureSampleAdd;
   float4 _ClipRect;
   half4 _MainTex_TRS;
   half4 _MaskTex_ST;

   v2f vert(appdata_t IN)
   {
      v2f OUT;
      OUT.worldPosition = IN.vertex;
      OUT.vertex = mul(UNITY_MATRIX_MVP, OUT.worldPosition);
      OUT.uvMain = IN.texcoord-float2(0.5,0.5);
      OUT.uvMain *= _MainTex_TRS.w;
      float2 v2SinCos;
      sincos(_MainTex_TRS.z, v2SinCos.x, v2SinCos.y);
      float2x2 matrixRot = {v2SinCos.y,-v2SinCos.x,v2SinCos.x,v2SinCos.y};
      OUT.uvMain = mul(matrixRot, OUT.uvMain);
      OUT.uvMain += _MainTex_TRS.xy;
      OUT.uvMask = IN.texcoord;
#ifdef UNITY_HALF_TEXEL_OFFSET
      OUT.vertex.xy += (_ScreenParams.zw - 1.0)*float2(-1,1);
#endif
      OUT.color = IN.color * _Color;
      return OUT;
   }

   sampler2D _MainTex;
   sampler2D _MaskTex;

   fixed4 frag(v2f IN) : SV_Target
   {
      half4 color = (tex2D(_MainTex, IN.uvMain) + _TextureSampleAdd) * IN.color;
      fixed inRect = (IN.uvMain.x >= 0 && IN.uvMain.x <= 1 && IN.uvMain.y >= 0 && IN.uvMain.y <= 1)-0.001;
      clip(inRect);
      half4 colorMask = tex2D(_MaskTex, IN.uvMask);
      color.a *= colorMask.a;
#ifdef UNITY_UI_ALPHACLIP
      clip(color.a - 0.001);
#endif
      return color;
   }
   ENDCG
   }
   }
}
