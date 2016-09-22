Shader "UYShader/Distort/effectdistortaddUVAnim"
{
   Properties{
      _TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
      _NoiseTex("Distort Texture (RG)", 2D) = "white" {}
      _MainTex("Alpha (A)", 2D) = "white" {}
      _MaskTex("Mask Texture",2D) = "white" {}
      _HeatTime("Heat Time", range(-1,1)) = 0
      _ForceX("Strength X", range(0,1)) = 0.1
      _ForceY("Strength Y", range(0,1)) = 0.1
      _UOffsetSpeed("U Speed",range(-4,4)) = 0
      _VOffsetSpeed("V Speed",range(-4,4)) = 0
   }

      Category
      {
         Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
         Blend SrcAlpha One
         Cull Off Lighting Off ZWrite Off Fog { Color(0,0,0,0) }
      SubShader 
      {
         Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #include "UnityCG.cginc"

            struct appdata_t {
               half4 vertex : POSITION;
               fixed4 color : COLOR;
               half2 texcoord: TEXCOORD0;
            };

            struct v2f {
               half4 vertex : POSITION;
               fixed4 color : COLOR;
               half4 uvmain : TEXCOORD1;
               half4 uvDistort : TEXCOORD2;
            };

            fixed4 _TintColor;
            fixed _ForceX;
            fixed _ForceY;
            fixed _HeatTime;
            half4 _MainTex_ST;
            half4 _NoiseTex_ST;
            sampler2D _NoiseTex;
            sampler2D _MainTex;
            sampler2D _MaskTex;
            half  _UOffsetSpeed;
            half  _VOffsetSpeed;

            v2f vert(appdata_t v)
            {
               v2f o;
               o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
               o.color = v.color;
               o.uvmain.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
               o.uvmain.zw = v.texcoord;
               o.uvDistort = o.uvmain.xyxy;
               o.uvmain.xy += _Time.y*float2(_UOffsetSpeed, _VOffsetSpeed);
               o.uvDistort += _Time.xzyx*_HeatTime;
               return o;
            }

            fixed4 frag(v2f i) : COLOR
            {
               //noise effect
               fixed4 offsetColor1 = tex2D(_NoiseTex, i.uvDistort.xy);
               fixed4 offsetColor2 = tex2D(_NoiseTex, i.uvDistort.zw);
               float2 uvDistorted = ((offsetColor1.r + offsetColor2.r) - 1)*float2(_ForceX, _ForceY);
               i.uvmain.xy += uvDistorted;
               fixed4 colorRet = 2.0f * i.color * _TintColor * tex2D(_MainTex, i.uvmain.xy);
               fixed4 colorMask = tex2D(_MaskTex, i.uvmain.zw);
               colorRet.a *= colorMask.a;
               return colorRet;
            }
            ENDCG
         }
      }
   }
}