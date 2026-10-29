Shader "B612/Water" {
	Properties {
		[Header(Surface)] [NoScaleOffset] [Normal] _NormalA ("Normal A (Water_NormalA, broad swell)", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _NormalB ("Normal B (Water_NormalB, ripples)", 2D) = "bump" {}
		_TileA ("Normal A Tile (m)", Float) = 4
		_TileB ("Normal B Tile (m)", Float) = 1.2
		_NormalStrengthA ("Normal A Strength", Range(0, 2)) = 0.7
		_NormalStrengthB ("Normal B Strength", Range(0, 2)) = 0.45
		_RibbonWidth ("Ribbon Width For UV u (m)", Float) = 3
		_FlowSpeed ("Flow Speed Multiplier", Float) = 1
		_DefaultFlow ("Flow (m/s) if the mesh has no UV1", Float) = 0.35
		[Header(Colour)] _ScatterColor ("In-scatter Colour", Vector) = (0.13,0.3,0.27,1)
		_ScatterDensity ("In-scatter Density (1/m)", Range(0, 10)) = 2.2
		_Absorption ("Absorption (1/m, rgb)", Vector) = (2.2,0.85,0.65,0)
		_DeepColor ("Deep Tint", Vector) = (0.05,0.13,0.13,1)
		_Refraction ("Refraction", Range(0, 0.15)) = 0.04
		[Header(Reflection)] _ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
		_F0 ("Fresnel F0", Range(0, 0.2)) = 0.025
		_Roughness ("Surface Roughness", Range(0.01, 0.5)) = 0.07
		_SunSpecular ("Sun Glint", Range(0, 4)) = 1.2
		[Header(Foam and Edges)] [NoScaleOffset] _FoamTex ("Foam (Water_Foam)", 2D) = "black" {}
		_FoamTile ("Foam Tile (m)", Float) = 2
		_FoamColor ("Foam Colour", Vector) = (0.93,0.95,0.93,1)
		_FoamDepth ("Foam Where Shallower Than (m)", Range(0, 0.5)) = 0.1
		_FoamEdge ("Foam Near Bank Within (m)", Range(0, 1.5)) = 0.22
		_FoamAmount ("Foam Amount", Range(0, 1)) = 0.35
		_EdgeSoftness ("Edge Softness (m of depth)", Range(0.01, 0.5)) = 0.06
		[Header(Caustics)] [NoScaleOffset] _CausticsTex ("Caustics (Water_Caustics)", 2D) = "black" {}
		_CausticsTile ("Caustics Tile (m)", Float) = 1.5
		_CausticsStrength ("Caustics Strength", Range(0, 3)) = 0.8
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