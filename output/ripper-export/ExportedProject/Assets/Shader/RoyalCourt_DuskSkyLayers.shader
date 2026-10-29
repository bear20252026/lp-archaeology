Shader "RoyalCourt/DuskSkyLayers" {
	Properties {
		_MainTex ("Sky panorama", 2D) = "grey" {}
		_Tint ("Tint", Vector) = (0.5,0.5,0.5,1)
		_Exposure ("Exposure", Range(0, 8)) = 1
		_Rotation ("Rotation", Range(0, 360)) = 0
		[Header(Night side)] _NightTint ("High Sky Tint (anti-sun)", Vector) = (0.62,0.62,1.15,1)
		_NightStrength ("High Sky Tint Strength", Range(0, 1)) = 0.6
		_StarScale ("Star Grid", Float) = 160
		_StarBrightness ("Stars", Range(0, 8)) = 2.2
		_StarColor ("Star Colour", Vector) = (1,0.95,0.88,1)
		_MilkyWay ("Milky Way", Range(0, 2)) = 0.55
		_MilkyWayColor ("Milky Way Colour", Vector) = (0.55,0.48,0.95,1)
		_MilkyWayAxis ("Milky Way Pole (world)", Vector) = (0.35,0.55,-0.75,0)
		[Header(Sun side)] _GlowColor ("Sunset Glow", Vector) = (1,0.55,0.26,1)
		_GlowStrength ("Glow Strength", Range(0, 4)) = 0.9
		_GlowHeight ("Glow Elevation (sin)", Range(-0.2, 0.5)) = 0.05
		[Header(Distant mountains and castle)] _MountainColor ("Mountain Haze", Vector) = (0.5,0.4,0.6,1)
		_MountainLit ("Mountain Sunward Rim", Vector) = (0.95,0.6,0.5,1)
		_MountainOpacity ("Mountain Opacity", Range(0, 1)) = 0.6
		_MountainHeight ("Mountain Height (sin elev)", Range(0, 0.2)) = 0.075
		_CastleAzimuth ("Castle Azimuth (deg from +z, + = right)", Range(-180, 180)) = -26
		_CastleOpacity ("Castle Opacity", Range(0, 1)) = 0.4
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.uv = (input.uv.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;

			struct Fragment_Stage_Input
			{
				float2 uv : TEXCOORD0;
			};

			float4 frag(Fragment_Stage_Input input) : SV_TARGET
			{
				return _MainTex.Sample(sampler_MainTex, input.uv.xy);
			}

			ENDHLSL
		}
	}
}