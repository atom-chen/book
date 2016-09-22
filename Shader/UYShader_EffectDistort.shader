Shader "UYShader/Distort/effectdistortblend" {
   Properties{
      _NoiseTex("Noise Texture (RG)", 2D) = "white" {}
      _MainTex("Alpha (A)", 2D) = "white" {}
      _HeatTime("Heat Time", range(0,1.5)) = 1
      _HeatForce("Heat Force", range(0,0.1)) = 0.1
   }

      Category{
         Tags { "Queue" = "Transparent+1" "RenderType" = "Transparent" }
         Blend SrcAlpha OneMinusSrcAlpha
         AlphaTest Greater .01
         Cull Off Lighting Off ZWrite Off


         SubShader {
            GrabPass {
               Name "BASE"
               Tags { "LightMode" = "Always" }
            }

            Pass {
               Name "BASE"
               Tags { "LightMode" = "Always" }

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
                  half4 uvgrab : TEXCOORD0;
                  half2 uvmain : TEXCOORD1;
               };

               fixed _HeatForce;
               fixed _HeatTime;
               half4 _MainTex_ST;
               half4 _NoiseTex_ST;
               sampler2D _NoiseTex;
               sampler2D _MainTex;

               v2f vert(appdata_t v)
               {
                  v2f o;
                  o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                  #if UNITY_UV_STARTS_AT_TOP
                     fixed scale = -1.0;
                  #else
                     fixed scale = 1.0;
                  #endif
                  o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y*scale) + o.vertex.w) * 0.5;
                  o.uvgrab.zw = o.vertex.zw;
                  o.uvmain = TRANSFORM_TEX(v.texcoord, _MainTex);
                  return o;
               }

               sampler2D _GrabTexture;

               fixed4 frag(v2f i) : COLOR
               {

                  //noise effect
                  fixed4 offsetColor1 = tex2D(_NoiseTex, i.uvmain + _Time.xz*_HeatTime);
                  fixed4 offsetColor2 = tex2D(_NoiseTex, i.uvmain - _Time.yx*_HeatTime);
                  i.uvgrab.x += ((offsetColor1.r + offsetColor2.r) - 1) * _HeatForce;
                  i.uvgrab.y += ((offsetColor1.g + offsetColor2.g) - 1) * _HeatForce;


                  fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
                  //Skybox's alpha is zero, don't know why.
                  col.a = 1.0f;
                  fixed4 tint = tex2D(_MainTex, i.uvmain);

                  return col*tint;
               }
               ENDCG
            }
         }
      }
}