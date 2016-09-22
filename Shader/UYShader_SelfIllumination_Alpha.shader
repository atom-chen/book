Shader "UYShader/SelfIllumination_Alpha/AlphaBlend"
{
   Properties
   {
        _Texture("Texture", 2D) = "white" {}
        _EmissIntensity("EmissIntensity", Range(0, 2)) = 0.6
        _Alpha("Alpha", Range(0,1)) = 1.0
   }
      SubShader
        {
            Tags
            {
                  "RenderType" = "Opaque" "Queue" = "Transparent-1"
            }
            Pass
            {
                  Tags
                  {
                       "LightMode" = "ForwardBase"
                  }
                  Cull Back
                  Blend SrcAlpha OneMinusSrcAlpha

                  CGPROGRAM

                  #pragma vertex vert
                  #pragma fragment frag
                  #include "UnityCG.cginc"


                  uniform sampler2D _Texture;
                  uniform fixed _EmissIntensity;
                  uniform fixed _Alpha;

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
                      half fogCoord : TEXCOORD2;
                  };

                  VertexOutput vert(VertexInput v)
                  {
                     VertexOutput o;
                     o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                     o.uv0 = v.texcoord0;
                     if (unity_FogParams.w == 0)
                        o.fogCoord = 1.0f;
                      else
                        o.fogCoord = o.pos.z * unity_FogParams.z + unity_FogParams.w;
                        return o;
                  }

                  fixed4 frag(VertexOutput i) : SV_Target
                  {
                     fixed4 texColor = tex2D(_Texture, i.uv0);
                     texColor.rgb *= _EmissIntensity;
                     texColor.a = _Alpha;
                     texColor.rgb = lerp(unity_FogColor.rgb, texColor.rgb, saturate(i.fogCoord));
                     return texColor;
                  }
                  ENDCG
             }
        }
}