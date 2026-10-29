Shader "RoyalCourt/LandRock" {
	Properties {
		[NoScaleOffset] _MaskMap ("Detail Mask (R height, G pores, B mottling, A speckle)", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _NormalMap ("Detail Normal", 2D) = "bump" {}
		[NoScaleOffset] _NoiseMap ("Land Noise (RGBA)", 2D) = "grey" {}
		[Toggle(_BAKED_MAP)] _UseBaked ("Baked Object-Space Normal + AO (uv0)", Float) = 0
		[NoScaleOffset] _BakedMap ("Baked (RGB OS normal, A AO)", 2D) = "white" {}
		_BakedAO ("Baked AO Strength", Range(0, 1)) = 0.85
		_Tiling ("Detail Tiling (per m)", Float) = 0.45
		_NormalStrength ("Detail Normal Strength", Range(0, 2)) = 0.7
		_LargeTiling ("Mottling Tiling (per m)", Float) = 0.07
		_ColorLight ("Stone Light", Vector) = (0.93,0.82,0.74,1)
		_ColorMid ("Stone Mid", Vector) = (0.82,0.67,0.62,1)
		_ColorDark ("Stone Crevice (warm)", Vector) = (0.52,0.36,0.33,1)
		_MossColor ("Moss", Vector) = (0.3,0.36,0.16,1)
		_MossColor2 ("Moss Dry", Vector) = (0.45,0.46,0.24,1)
		_MossAmount ("Moss (vertex G)", Range(0, 2)) = 1
		_MossUp ("Moss On Up-Facing", Range(0, 1)) = 0.1
		_AOStrength ("Vertex AO", Range(0, 1)) = 0.9
		_CreaseDark ("Crease Darkening", Range(0, 1)) = 0.35
		_Wrap ("Wrap", Range(0, 1)) = 0.25
		_Specular ("Specular", Range(0, 1)) = 0.04
		_Gloss ("Gloss", Range(2, 64)) = 12
		_BounceColor ("Cloud Bounce (from below)", Vector) = (0.3,0.17,0.16,1)
		_DepthTint ("Lower Tint", Vector) = (0.97,0.88,0.92,1)
		[Header(Lawn layer on rock tops)] [NoScaleOffset] _GrassMap ("Grass Colour (same as ground)", 2D) = "white" {}
		_GrassAmount ("Grass Amount", Range(0, 1)) = 0
		_GrassUp ("Grass Min Up (normal y)", Range(0, 1)) = 0.55
		_GrassTile ("Grass Tile (m)", Float) = 3.6
		_PatchTile ("Patch Tile (m)", Float) = 36
		_DryTint ("Dry Tint", Vector) = (0.94,0.88,0.74,1)
		_GreenTint ("Green Tint", Vector) = (0.76,0.82,0.64,1)
		_DeepTint ("Deep Tint", Vector) = (0.64,0.7,0.54,1)
		_GrassBrightness ("Grass Brightness", Range(0, 2)) = 0.86
		_SoilColor ("Soil Band", Vector) = (0.34,0.27,0.19,1)
		_GrassInnerZ ("Grass only where object z < (rim modules: outer lobes stay rock)", Float) = 1000
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