Shader "B612/Pond" {
	Properties {
		[Header(Surface)] [NoScaleOffset] [Normal] _NormalA ("Normal (Water_NormalA, broad swell)", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _NormalB ("Normal (Water_NormalB, catspaw)", 2D) = "bump" {}
		_TileA ("Swell Tile (m)", Float) = 6
		_TileB ("Catspaw Tile (m)", Float) = 2.2
		_NormalStrengthA ("Swell Strength", Range(0, 1)) = 0.12
		_NormalStrengthB ("Catspaw Strength", Range(0, 1)) = 0.05
		_Drift ("Wind Drift (m/s)", Float) = 0.02
		[Header(Spring Vent and Boil)] _SpringCenter ("Vent (world xz)", Vector) = (0,0,0,0)
		_BoilRadius ("Boil Radius At The Surface (m)", Float) = 0.24
		_BoilDome ("Boil Dome Height (x dome sigma; 0.06 = 8.6 mm, 2.5x the physical 3.5 mm)", Range(0, 0.3)) = 0.06
		_BoilChurn ("Boil Churn", Range(0, 0.5)) = 0.16
		_BoilPulse ("Boil Pulse (Hz)", Float) = 0.8
		[Header(Ring Waves)] _RingWavelength ("Wavelength (m)", Float) = 0.12
		_RingPhaseSpeed ("Phase Speed c (m/s)", Float) = 0.44
		_RingGroupSpeed ("Group Speed cg (m/s)", Float) = 0.23
		_RingRate ("Packets per Second", Float) = 0.9
		_RingStrength ("Ring Slope", Range(0, 0.5)) = 0.12
		_RingRadius ("Rings Fade Out By (m)", Float) = 1.3
		[Header(Drift Toward The Notch)] _VentImage ("Vent Image (world xz)", Vector) = (0,0,0,0)
		_Outlet ("Overflow Notch (world xz)", Vector) = (0,0,0,0)
		_FlowK ("Source Strength Q / 2 pi h (m2/s)", Float) = 0.0061
		_DriftBoost ("Drift Readability Boost", Range(1, 6)) = 2.5
		[NoScaleOffset] _FleckTex ("Flecks (R flecks, G fine bubbles, B streaks)", 2D) = "black" {}
		_FleckTile ("Fleck Tile (m)", Float) = 0.9
		_FleckAmount ("Fleck Amount", Range(0, 1)) = 0.55
		_Tongue ("Tongue Streaks", Range(0, 0.4)) = 0.12
		_OutletTurb ("Draw-down Turbulence Near The Outlet (review 2026-10-01)", Range(0, 0.4)) = 0
		[Header(Colour)] _ScatterColor ("In-scatter Colour", Vector) = (0.16,0.34,0.33,1)
		_ScatterDensity ("In-scatter Density (1/m)", Range(0, 10)) = 1
		_Absorption ("Absorption (1/m, rgb)", Vector) = (1.5,0.55,0.42,0)
		_DeepColor ("Deep Tint", Vector) = (0.05,0.14,0.15,1)
		_Refraction ("Refraction", Range(0, 0.15)) = 0.03
		[Header(Reflection)] _ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
		_F0 ("Fresnel F0", Range(0, 0.2)) = 0.03
		_Roughness ("Surface Roughness", Range(0.01, 0.5)) = 0.035
		_SunSpecular ("Sun Glint", Range(0, 4)) = 1.4
		_EdgeSoftness ("Edge Softness (m of depth)", Range(0.01, 0.5)) = 0.05
		[Header(Caustics)] [NoScaleOffset] _CausticsTex ("Caustics (Water_Caustics)", 2D) = "black" {}
		_CausticsTile ("Caustics Tile (m)", Float) = 1.3
		_CausticsStrength ("Caustics Strength", Range(0, 3)) = 0.7
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