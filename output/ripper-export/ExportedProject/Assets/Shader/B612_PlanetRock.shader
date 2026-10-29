Shader "B612/PlanetRock" {
	Properties {
		[NoScaleOffset] _RockMap ("Rock Albedo (tileable)", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _DetailNormal ("Detail Normal (tileable)", 2D) = "bump" {}
		[NoScaleOffset] _MacroNoise ("Macro Noise", 2D) = "grey" {}
		_Tiling ("Triplanar Tile (m)", Float) = 3
		_DetailTiling ("Detail Normal Tile (m)", Float) = 1.6
		_DetailStrength ("Detail Normal Strength", Range(0, 2)) = 0.9
		_RockTint ("Rock Tint", Vector) = (0.62,0.6,0.56,1)
		_RockTintB ("Rock Tint B (macro variation)", Vector) = (0.5,0.47,0.42,1)
		_Strata ("Strata Bands (x strength, y spacing m)", Vector) = (0.12,0.55,0,0)
		_MossColor ("Moss", Vector) = (0.28,0.36,0.14,1)
		_MossAmount ("Moss Amount", Range(0, 1)) = 0.7
		_MossTopY ("Moss Fades Below World y", Float) = -2.5
		_UnderColor ("Underside Tint", Vector) = (0.42,0.42,0.46,1)
		_UnderY ("Underside Starts Below World y (x start, y full)", Vector) = (-3,-14,0,0)
		_Smoothness ("Smoothness", Range(0, 1)) = 0.12
		[Header(Rim v2 (planet cliff))] _GrassColor ("Grass Cap (vertex colour B: the lip shoulder)", Vector) = (0.3,0.42,0.13,1)
		_GrassColorB ("Grass Cap Variation", Vector) = (0.42,0.46,0.18,1)
		_LichenColor ("Warm Lichen", Vector) = (0.78,0.66,0.4,1)
		_Lichen ("Lichen Amount", Range(0, 1)) = 0
		_MossUp ("Moss On Up-Facing Rock At Any Height", Range(0, 1)) = 0
		_CloudMist ("Cloud Mist Where The Cloud Tops Hug The Rock (x strength, y height m)", Vector) = (0,5,0,0)
		_AOStrength ("Vertex AO Strength", Range(0, 1)) = 0.8
		[Header(Far bodies (planetoids))] _SkyFill ("Sky Fill (lifts the shaded side, far bodies)", Range(0, 2)) = 0
		_RimLight ("Rim Light (x strength, y power; backlit edge glow)", Vector) = (0,3,0,0)
		[Header(Distance haze (far bodies))] _HazeDensity ("Haze Density (1/m, 0 = off)", Float) = 0
		_HazeStart ("Haze Start (m)", Float) = 60
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