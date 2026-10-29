Shader "StarObservatory/StoneLit" {
	Properties {
		_BaseMap ("Base Colour", 2D) = "white" {}
		_BaseColor ("Tint", Vector) = (1,1,1,1)
		[Normal] _BumpMap ("Normal (OpenGL)", 2D) = "bump" {}
		_BumpScale ("Normal Strength", Range(0, 3)) = 1
		[Toggle(_METALLICSPECGLOSSMAP)] _UseMetallicMap ("Use Metallic/Smoothness Map", Float) = 0
		_MetallicGlossMap ("Metallic (R) Smoothness (A)", 2D) = "white" {}
		_Metallic ("Metallic (no map)", Range(0, 1)) = 0
		_Smoothness ("Smoothness (x map alpha)", Range(0, 1)) = 0.35
		_OcclusionMap ("Occlusion (G)", 2D) = "white" {}
		_OcclusionStrength ("Occlusion Strength", Range(0, 1)) = 1
		[Header(Parallax occlusion)] [Toggle(_POM)] _UsePOM ("Parallax Occlusion Mapping", Float) = 0
		_ParallaxMap ("Height (R, 1 = top)", 2D) = "white" {}
		_HeightDepth ("Height Depth (m)", Range(0, 0.15)) = 0.035
		_POMSteps ("Steps (x min at normal view, y max at grazing)", Vector) = (6,24,0,0)
		_POMFade ("Fade (x start, y end, m)", Vector) = (12,22,0,0)
		[Header(Macro variation)] _MacroScale ("Macro Noise Size (m)", Float) = 3.5
		_MacroDark ("Macro Dark Tint", Vector) = (0.86,0.84,0.86,1)
		_MacroLight ("Macro Light Tint", Vector) = (1.08,1.05,1,1)
		_MacroBreakup ("Albedo Re-sample Breakup", Range(0, 1)) = 0.25
		_MacroBreakupScale ("Breakup Scale (x base tiling)", Range(0.05, 1)) = 0.23
		_VertexColorStrength ("Vertex Colour Darkening (R: slab 0.8-1, grout 0.5)", Range(0, 1)) = 0
		[Header(Metal wear (iron))] _MetallicScale ("Metallic x (map or value)", Range(0, 1)) = 1
		_RimColor ("Worn Edge Rim (rgb, HDR-ish; a = power)", Vector) = (0,0,0,4)
		_StreakColor ("Rust Streak Colour", Vector) = (0.55,0.3,0.16,1)
		_StreakStrength ("Rust Streaks (world-space, downward)", Range(0, 1)) = 0
		_StreakScale ("Streak Width (m)", Range(0.02, 1)) = 0.12
		_UnderColor ("Underside Patina (albedo x)", Vector) = (0.55,0.42,0.34,1)
		_UnderStrength ("Underside Patina (mesh normal -Y)", Range(0, 1)) = 0
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