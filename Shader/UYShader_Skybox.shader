// Simplified Skybox shader. Differences from regular Skybox one:
// - no tint color

Shader "UYShader/Skybox" {
Properties {
	_MainTex ("Texture", 2D) = "white" {}
}

SubShader {
	Tags { "RenderType"="Opaque" "Queue"="Geometry+1" }

	Cull Off ZWrite Off
	Pass {
		SetTexture [_MainTex]  { combine texture }
	}
}
}
