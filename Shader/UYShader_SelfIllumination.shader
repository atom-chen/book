Shader "UYShader/SelfIllumination" 
{
	Properties 
	{
		_EmissColor ("Emiss Color (RGB)", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
	}
	SubShader 
	{ 
		Tags { "QUEUE"="Geometry" "IGNOREPROJECTOR"="true" }
		Pass {
		Tags { "QUEUE"="Geometry" "IGNOREPROJECTOR"="true" }
		Material 
		{
			Ambient (1,1,1,1)
			Diffuse (1,1,1,1)
		}
			SetTexture [_MainTex] { ConstantColor [_EmissColor] combine constant * texture }
			SetTexture [_MainTex] { combine previous + texture }
			SetTexture [_MainTex] { ConstantColor [_EmissColor] combine previous * constant }
		}
	}
}