Shader "Desert/Sand" {
	Properties {
		[Header(Sand colour)] _SandA ("Sand Warm", Vector) = (0.82,0.63,0.41,1)
		_SandB ("Sand Pale", Vector) = (0.87,0.71,0.5,1)
		_SandC ("Sand Ochre", Vector) = (0.79,0.57,0.36,1)
		_CrestLight ("Crest Lightening", Range(0, 1)) = 0.25
		_MacroNoise ("Macro Noise", 2D) = "gray" {}
		_MacroScale ("Macro Scales (m): x large, y mid, z small", Vector) = (190,48,9,0)
		_MacroStrength ("Macro Strength (x large, y mid, z small)", Vector) = (0.8,0.4,0.14,0)
		[Header(User sand (desert_landscape.blend))] _UserBase ("User Sand Base Colour (12 m)", 2D) = "white" {}
		[NoScaleOffset] _UserRough ("User Sand Roughness", 2D) = "white" {}
		[NoScaleOffset] [Normal] _UserRipple ("User Ripple Normal (4 m)", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _UserCompacted ("User Compacted Normal (trails)", 2D) = "bump" {}
		[NoScaleOffset] _SedimentTint ("Sediment Tint (linear)", 2D) = "gray" {}
		_SedimentRect ("Sediment Rect (x0, z0, 1/sx, 1/sz)", Vector) = (-1024,-1000,0.00048828125,0.00048828125)
		_UserFrame ("User Frame (origin x, z, yaw deg)", Vector) = (-62,-55,30,0)
		_SedimentFrame ("Frame of the sediment tint map (origin x, z, yaw deg)", Vector) = (-62,-55,30,0)
		_UserTiles ("Tiles: base, ripple, compacted (m)", Vector) = (12,4,2.2,0)
		_UserRippleStrength ("Ripple Strength", Float) = 1.1
		_UserWarp ("Ripple Warp (amplitude m, period m)", Vector) = (0.25,6,0,0)
		_UserTintMix ("Sediment Tint Mix", Range(0, 1)) = 0.15
		_UserSpecular ("Specular (IOR level)", Range(0, 1)) = 0.26
		_UserBrightness ("Albedo Scale", Range(0.5, 1.5)) = 1
		[Header(Ripples on dunes)] [NoScaleOffset] [Normal] _RippleNormal ("Ripple Normal (aerial_beach_01)", 2D) = "bump" {}
		_RippleTile ("Ripple Tile Near / Mid (m)", Vector) = (5,42,0,0)
		_RippleStrength ("Ripple Strength Near / Mid", Vector) = (0.32,0.16,0,0)
		_RippleFade ("Ripple Fade Distance Near / Mid (m)", Vector) = (16,110,0,0)
		_RippleSlope ("Ripple Fade by Slope (start, end, keep)", Vector) = (0.22,0.45,0,0)
		_WindAzimuth ("Wind Toward Azimuth (deg)", Float) = 70
		[Header(Ground masks)] [NoScaleOffset] _GroundMask ("Ground Mask (R trail, G hardpan, B damp, A rock)", 2D) = "black" {}
		[NoScaleOffset] _GroundMask2 ("Ground Mask 2 (R dune, G firm, B green margin, A wheat field)", 2D) = "black" {}
		_FieldColor ("Wheat Field Ground (far read)", Vector) = (0.78,0.55,0.22,1)
		_GroundMaskRect ("Ground Mask Rect (x0, z0, 1/sx, 1/sz)", Vector) = (0,0,0.001,0.001)
		_TrailColor ("Trail (compacted) Tint", Vector) = (0.93,0.9,0.88,1)
		_RoadSat ("Trail: share of the sand colour kept (1 = all; the rest is its luminance)", Range(0, 1.5)) = 1
		_RoadGrain ("Trail: fine-gravel grain (gravelly_sand luminance)", Range(0, 1)) = 0
		[NoScaleOffset] [Normal] _TrailNormal ("Trail / Firm Normal (dense_sand)", 2D) = "bump" {}
		_TrailTile ("Trail Tile (m)", Float) = 1.8
		[NoScaleOffset] _GravelAlbedo ("Hardpan Albedo (gravelly_sand)", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _GravelNormal ("Hardpan Normal (gravelly_sand)", 2D) = "bump" {}
		_GravelTile ("Hardpan Tile (m)", Float) = 2.5
		_GravelTint ("Hardpan Tint", Vector) = (0.95,0.9,0.86,1)
		_FirmColor ("Firm Floor Tint", Vector) = (0.97,0.95,0.93,1)
		_DampColor ("Damp Sand", Vector) = (0.5,0.38,0.28,1)
		_GreenColor ("Green Margin Tint", Vector) = (0.62,0.6,0.42,1)
		_RockColor ("Rock-body Tint", Vector) = (0.8,0.66,0.52,1)
		[NoScaleOffset] _RockDetailAlbedo ("Cliff Detail Albedo (cliff_side)", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _RockDetailNormal ("Cliff Detail Normal (cliff_side)", 2D) = "bump" {}
		_RockTile ("Cliff Detail Tile (m)", Float) = 3.5
		[Header(Valley ground cover)] [NoScaleOffset] _GroundMask3 ("Ground Mask 3 (R lush, G meadow, B dry, A bank)", 2D) = "black" {}
		[NoScaleOffset] _GrassAlbedo ("Grass Ground Albedo", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _GrassNormal ("Grass Ground Normal", 2D) = "bump" {}
		_GrassTile ("Grass Ground Tile (m)", Float) = 3.2
		_GrassLuma ("Grass Albedo Mean Luma (linear)", Float) = 0.078
		_LushColor ("Lush Green", Vector) = (0.42,0.56,0.2,1)
		_MeadowColor ("Meadow Golden-green", Vector) = (0.76,0.66,0.3,1)
		_DryColor ("Dry Straw", Vector) = (0.84,0.72,0.48,1)
		_BankColor ("Wet Bank", Vector) = (0.34,0.4,0.16,1)
		_CoverFar ("Cover colour: detail fade distance (m)", Float) = 120
		_SteepRock ("Any Steep Face Is Rock (valley 1, dunes 0)", Range(0, 1)) = 0
		_RoseInA ("Ground Mask A = rose beds (two-scene desert) instead of rock body", Range(0, 1)) = 0
		_RoseFieldColor ("Rose Beds From Afar", Vector) = (0.55,0.05,0.06,1)
		_RoseBedColor ("Rose Bed Ground Near (soil / leaf litter; a = amount)", Vector) = (0.4,0.32,0.22,0)
		[Header(Rose garden)] [NoScaleOffset] _GardenMask ("Garden Mask (R soil, G gravel path, B green, A petals)", 2D) = "black" {}
		_GardenRect ("Garden Rect (x0, z0, 1/sx, 1/sz)", Vector) = (0,0,0,0)
		[NoScaleOffset] _SoilAlbedo ("Bed Soil Albedo", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _SoilNormal ("Bed Soil Normal", 2D) = "bump" {}
		_SoilTile ("Soil Tile (m)", Float) = 1.6
		[NoScaleOffset] _PathAlbedo ("Path Gravel Albedo", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _PathNormal ("Path Gravel Normal", 2D) = "bump" {}
		_PathTile ("Path Tile (m)", Float) = 1.3
		_PetalColor ("Petal Colour", Vector) = (0.62,0.06,0.07,1)
		[Header(Estate gravel and station paving (round 3b))] [NoScaleOffset] _EstateMask ("Estate Mask (R estate gravel floor, G stone paving, B estate bed ground)", 2D) = "black" {}
		_EstateRect ("Estate Mask Rect (x0, z0, 1/sx, 1/sz)", Vector) = (0,0,0,0)
		_EstateColor ("Estate Gravel (linear albedo)", Vector) = (0.52,0.42,0.33,1)
		_EstateGrain ("Estate Gravel Grain", Range(0, 1)) = 0.6
		_PavingColor ("Paving Stone (linear albedo)", Vector) = (0.55,0.48,0.4,1)
		_PavingSize ("Paving: stone length, row width, joint width (m), yaw (deg)", Vector) = (0.9,0.6,0.025,0)
		[Header(Lighting)] _Wrap ("Diffuse Wrap", Range(0, 1)) = 0.15
		_ShadowTint ("Shadow Tint (sky fill)", Vector) = (1,1,1,1)
		_AmbientScale ("Ambient Scale", Range(0, 3)) = 1
		_Sparkle ("Sun Glints", Range(0, 20)) = 1.2
		_SparkleDensity ("Glint Cells per m", Float) = 70
		_SparkleFade ("Glint Fade Distance (m)", Float) = 14
		_SlopeDarken ("Slip-face Darkening", Range(0, 1)) = 0.06
		[Toggle(_FAR_GROUND)] _FarGround ("Far Ground Ring (mesh)", Float) = 0
		[HideInInspector] _MainTex ("BaseMap (RGB)", 2D) = "grey" {}
		[HideInInspector] _BaseColor ("Main Color", Vector) = (1,1,1,1)
		[HideInInspector] _TerrainHolesTexture ("Holes Map (RGB)", 2D) = "white" {}
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