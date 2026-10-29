Shader "RoyalCourt/LandGround" {
	Properties {
		[NoScaleOffset] _BaseMap ("Grass Colour", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap ("Grass Normal", 2D) = "bump" {}
		[NoScaleOffset] _NoiseMap ("Land Noise (RGBA)", 2D) = "grey" {}
		_GrassTile ("Grass Tile (m)", Float) = 3
		_PatchTile ("Patch Tile (m)", Float) = 36
		_BumpScale ("Normal Strength", Range(0, 2)) = 0.6
		_DryTint ("Dry Tint", Vector) = (1.08,0.98,0.78,1)
		_GreenTint ("Green Tint", Vector) = (0.78,0.9,0.62,1)
		_DeepTint ("Deep Tint", Vector) = (0.62,0.72,0.5,1)
		_RimColor ("Rim Moss", Vector) = (0.3,0.37,0.14,1)
		_SoilColor ("Soil", Vector) = (0.36,0.3,0.2,1)
		_Brightness ("Brightness", Range(0, 2)) = 1
		_Wrap ("Wrap", Range(0, 1)) = 0.35
		_WallAO ("Wall Foot AO", Range(0, 1)) = 1
		_FlowerColor ("White Flower Carpet (vertex A density)", Vector) = (1,0.97,0.9,1)
		_FlowerScale ("Flower Grid (per m)", Float) = 26
		_TipLight ("Sunlit Blade Tips", Range(0, 1)) = 0.35
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