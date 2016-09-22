Shader "UYShader/ScrollingUVs" {
   Properties{
      _MainTex("Texture", 2D) = "white" {}
   _ScrollXSpeed("X Scroll Speed", Range(0,4)) = 0
      _ScrollYSpeed("Y Scroll Speed", Range(0,4)) = 1
   }
      SubShader{
      Pass
   {
      Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
      ZWrite Off
      Alphatest Greater 0
      Blend SrcAlpha One

      CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

      sampler2D _MainTex;
   half _ScrollXSpeed;
   half _ScrollYSpeed;

   struct VertexInput
   {
      half4 vertex : POSITION;
      half2 texcoord0 : TEXCOORD0;
      fixed4 color : COLOR;
   };

   struct VertexOutput
   {
      half4 pos  : SV_POSITION;
      float2 uv0 : TEXCOORD0;
      half fogCoord : TEXCOORD1;
      fixed alpha : TEXCOORD2;
   };


   VertexOutput vert(VertexInput v)
   {
      VertexOutput o;
      o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

      o.alpha = v.color.a;
      float2 uvScroll = float2(_ScrollXSpeed, _ScrollYSpeed)*_Time.y;
      o.uv0 = v.texcoord0 + uvScroll;
      if (unity_FogParams.w == 0)
         o.fogCoord = 1.0f;
      else
         o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
      return o;
   }

   fixed4 frag(VertexOutput i) : COLOR
   {
      fixed4 c = tex2D(_MainTex,i.uv0);
      c.a *= i.alpha;
      return c;
   }

      ENDCG
   }
   }
}
