Shader "StarObservatory/NightSky" {
	Properties {
		[Header(Panorama)] [Toggle(_PANORAMA_ON)] _UsePanorama ("Use Panorama (off = procedural fallback)", Float) = 0
		[NoScaleOffset] _Panorama ("Panorama (HDR equirect, centre column = north)", 2D) = "black" {}
		_PanoYaw ("Panorama Yaw (deg, clockwise from above)", Float) = 0
		_PanoLatRange ("Panorama Latitude Range (x bottom, y top, deg)", Vector) = (-90,90,0,0)
		_Exposure ("Exposure", Range(0, 8)) = 1
		_Tint ("Tint", Vector) = (1,1,1,1)
		_Saturation ("Saturation", Range(0, 2)) = 1
		_StarClamp ("Brightest Pixel (HDR, hue kept; tames the big bright stars)", Range(0.2, 50)) = 50
		[Header(Twinkle)] [NoScaleOffset] _TwinkleMask ("Twinkle Mask (R, same projection as the panorama)", 2D) = "black" {}
		_TwinkleAmount ("Twinkle Amount", Range(0, 1)) = 0.45
		_TwinkleSpeed ("Twinkle Speed", Range(0, 10)) = 2.2
		[Toggle] _TwinkleUsesGB ("Mask G = phase, B = amplitude (sky group mask)", Float) = 0
		[Header(Rotation)] _Rotation ("Rotation (deg)", Float) = 0
		_RotationSpeed ("Rotation Speed (deg per s of _SO_SkyTime)", Float) = 0.12
		_RotationAxis ("Rotation Axis (world)", Vector) = (0,1,0,0)
		[Header(Procedural fallback)] _ZenithColor ("Zenith", Vector) = (0.006,0.01,0.04,1)
		_HorizonColor ("Horizon", Vector) = (0.03,0.034,0.105,1)
		_NadirColor ("Below Horizon", Vector) = (0.01,0.01,0.036,1)
		_NebulaColorA ("Nebula A (violet)", Vector) = (0.34,0.14,0.62,1)
		_NebulaColorB ("Nebula B (blue)", Vector) = (0.1,0.28,0.72,1)
		_NebulaStrength ("Nebula Strength", Range(0, 2)) = 0.55
		_MilkyWayNormal ("Milky Way Plane Normal", Vector) = (0.42,0.62,-0.66,0)
		_MilkyWayWidth ("Milky Way Half Width", Range(0.03, 0.6)) = 0.2
		_MilkyWayStrength ("Milky Way Strength", Range(0, 3)) = 0.9
		_MilkyWayColor ("Milky Way Core", Vector) = (0.75,0.66,0.82,1)
		_StarDensity ("Star Density", Range(0, 1)) = 0.6
		_StarBrightness ("Star Brightness", Range(0, 40)) = 9
		_StarSize ("Star Size (px)", Range(0.3, 4)) = 1.25
		_ProceduralTwinkle ("Procedural Twinkle", Range(0, 1)) = 0.35
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