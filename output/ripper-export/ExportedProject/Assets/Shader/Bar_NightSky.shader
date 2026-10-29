Shader "Bar/NightSky" {
	Properties {
		[Header(Night palette (linear))] _ZenithColor ("Zenith", Vector) = (0.007,0.018,0.1,1)
		_UpperColor ("Upper sky (about 30 deg)", Vector) = (0.014,0.028,0.12,1)
		_HorizonColor ("Horizon", Vector) = (0.045,0.058,0.165,1)
		_HazeColor ("Horizon haze (rgb), strength (a)", Vector) = (0.06,0.068,0.16,0.85)
		_HazeBand ("Haze band half width (deg; twice that below the horizon)", Float) = 5.5
		_BelowColor ("Deep blue far below", Vector) = (0.03,0.042,0.13,1)
		_BelowFalloff ("Below: depth of the fade (deg)", Float) = 55
		_GlowColor ("Afterglow (rgb), a height (deg)", Vector) = (0.13,0.05,0.06,9)
		_GlowAzimuth ("Afterglow azimuth (deg, from +Z to +X), spread exponent", Vector) = (-80,1.8,0,0)
		[Header(Photo clouds)] _HeroCloud ("Independent upper cloud prototype", Float) = 0
		[NoScaleOffset] _HeroCache ("Upper cloud density and lighting", 3D) = "black" {}
		_UseHeroCache ("Use matching upper cloud cache", Float) = 0
		_HeroCacheLightDirection ("Upper cache moon direction", Vector) = (0,1,0,0)
		[NoScaleOffset] _SkyPhoto ("Photo sky (HDR equirect, elevation 0..90)", 2D) = "black" {}
		[NoScaleOffset] _SkyPhotoAlpha ("Photo cloud coverage (R)", 2D) = "black" {}
		_PhotoYaw ("Photo yaw (deg): x", Vector) = (-45,150,0,0)
		_PhotoNorm ("Photo grade (x blur mip of the normaliser, y contrast)", Vector) = (7.5,1.6,1,0.6)
		_PhotoSun ("Photo sun (x az, y el, z dim strength, w dim exponent) in photo space", Vector) = (80,43,0.7,120)
		_CloudColor ("Cloud tint (rgb, x the sky's luminance), a greyness", Vector) = (0.8,0.86,1,0.55)
		_CloudGain ("Clouds (x brightness, y highlight knee, w afterglow rim)", Vector) = (1.3,3,1.2,3)
		_CloudRim ("Moonlit rims (rgb, x the cloud colour), a from brightness k", Vector) = (0.06,0.07,0.1,1.1)
		_GapDim ("Clear gaps between the clouds (x darkening, y below the horizon)", Vector) = (0.15,0.1,0,0)
		_Drift ("Upper cloud drift (deg/s)", Float) = 0.04
		[NoScaleOffset] _SeaNoise ("Cloud sea density noise", 3D) = "white" {}
		[NoScaleOffset] _SeaDetail ("Cloud cellular shape and erosion", 3D) = "white" {}
		[NoScaleOffset] _SeaVolume ("Cloud group density", 3D) = "black" {}
		[NoScaleOffset] _SeaLight ("Cloud broad extinction cache", 3D) = "white" {}
		_SeaLightDirection ("Cached moonward lighting direction", Vector) = (0,1,0,0)
		_CloudReviewTime ("Fixed review time (-1 for live)", Float) = -1
		_SeaJitterFrame ("Temporal sample frame (-1 for still inspection)", Float) = -1
		_UseSeaLight ("Use matching extinction cache", Float) = 0
		_SeaSteps ("Cloud sea integration samples", Range(64, 512)) = 512
		_UpperCloudForm ("Upper clouds (density, core shade, extra banks, vertical scale)", Vector) = (2.45,0.82,0.95,0.8)
		[Header(Moon)] _MoonDirection ("Moon direction (disc)", Vector) = (0.545,0.29,0.78,0)
		_MoonRadius ("Moon angular radius (deg)", Range(0.3, 6)) = 2.5
		_MoonColor ("Moon disc (linear)", Vector) = (2.2,2.25,2.35,1)
		_MoonHaloColor ("Moon halo (tight)", Vector) = (0.14,0.16,0.26,1)
		_MoonGlowColor ("Moon glow (broad sky scatter)", Vector) = (0.02,0.028,0.07,1)
		_MoonClear ("Clouds thinned round the moon (x amount, y radius in moon radii)", Vector) = (0.85,4,0,0)
		_MoonTex ("Moon texture (disc fills UV 0..1)", 2D) = "white" {}
		[Toggle] _UseMoonTex ("Use moon texture", Float) = 0
		[Header(Stars)] _StarDensity ("Star density", Range(0, 1)) = 0.45
		_StarBrightness ("Star brightness", Range(0, 12)) = 1.6
		_CloudsOn ("Photo clouds (1 on, 0 palette only)", Float) = 1
		_Exposure ("Exposure", Float) = 1
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