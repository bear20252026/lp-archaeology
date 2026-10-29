Shader "Desert/UserSky" {
	Properties {
		[NoScaleOffset] _SkyTex ("Sky Panorama (equirect, full sphere)", 2D) = "black" {}
		_UOffset ("Panorama U Offset (source u - target u)", Float) = 0
		_Exposure ("Exposure", Float) = 1.2
		_Saturation ("Saturation", Range(0, 2)) = 1.15
		_HorizonLift ("Horizon line (deg) and softness", Vector) = (0,2,0,0)
		_VMap ("Vertical map: v at horizon, elevation power", Vector) = (0.5,0.35,0,0)
		_FogMix ("Their depth fog over the sky (max amount)", Range(0, 1)) = 0.35
		_ZenithTint ("Upper sky multiplier (from 0.5° to 22°)", Vector) = (0.88,1.04,1.22,1)
		_BelowColor ("Below Horizon", Vector) = (0.62,0.62,0.72,1)
		[Header(Sun)] _SunDiskColor ("Sun Disc (HDR)", Vector) = (24,18,10,1)
		_SunDiskSize ("Sun Disc Radius (deg)", Float) = 0.9
		_SunHaloColor ("Sun Halo (HDR)", Vector) = (1.2,0.8,0.45,1)
		_SunHaloPower ("Sun Halo Power", Float) = 400
		_SunGlowColor ("Sun Wide Glow (HDR)", Vector) = (0.35,0.22,0.1,1)
		_SunGlowPower ("Sun Wide Glow Power", Float) = 24
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				return float4(1.0, 1.0, 1.0, 1.0); // RGBA
			}

			ENDHLSL
		}
	}
}