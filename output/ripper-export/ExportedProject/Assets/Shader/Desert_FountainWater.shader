Shader "Desert/FountainWater" {
	Properties {
		_Centre ("Centre (world x, z)", Vector) = (0,0,0,0)
		_Rings ("Landing rings: x radius A, y radius B (m, < 0 = none), z band width (m), w foam", Vector) = (0,-1,0.12,0.6)
		_Ripple ("Ripples: x amplitude (slope), y wavelength (m), z speed (m/s), w decay (1/m)", Vector) = (0.18,0.11,0.35,3)
		_BodyColor ("Body Colour (linear)", Vector) = (0.06,0.14,0.13,1)
		_ShallowColor ("Shallow / Rim Colour (linear)", Vector) = (0.2,0.3,0.26,1)
		_FoamColor ("Foam Colour", Vector) = (0.92,0.95,0.96,1)
		[NoScaleOffset] [Normal] _DetailNormal ("Detail Normal", 2D) = "bump" {}
		_DetailTile ("Detail Tile (m)", Float) = 0.9
		_DetailStrength ("Detail Strength", Range(0, 1)) = 0.35
		_Reflection ("Reflection Strength", Range(0, 2)) = 1
		_Roughness ("Reflection Roughness", Range(0, 1)) = 0.06
		_Sun ("Sun Glint", Range(0, 20)) = 6
		_Radius ("Surface Radius (m, for the rim tint)", Float) = 1.8
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