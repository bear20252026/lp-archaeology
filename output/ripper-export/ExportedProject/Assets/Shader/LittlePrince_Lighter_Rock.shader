Shader "LittlePrince/Lighter/Rock" {
	Properties {
		[NoScaleOffset] _BaseMap ("Boulder base colour (crevice shading)", 2D) = "white" {}
		[NoScaleOffset] [Normal] _BumpMap ("Boulder normal", 2D) = "bump" {}
		[NoScaleOffset] _StoneMap ("Rock", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _StoneNormal ("Rock normal", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _DetailNormal ("Rock grain normal", 2D) = "bump" {}
		_StoneTint ("Rock tint A", Vector) = (1.36,1.37,1.56,1)
		_StoneTintB ("Rock tint B", Vector) = (1.3,1.34,1.56,1)
		_StoneScales ("Rock (tile 1/m, weathering 1/m, normal, desaturate)", Vector) = (1,0.11,1,0.85)
		_Cracks ("Cracks (freq 1/m, width, share, darkness)", Vector) = (0.32,0.008,0.3,0.3)
		_Detail ("Grain (normal tile 1/m, normal strength, patch contrast, patch scale 1/m)", Vector) = (3.3,0.5,0.25,0.6)
		_Boulder ("Boulder (x crevice mix, y crevice reference lum, z own normal, w rock normal mix)", Vector) = (0.65,0.36,1,0.45)
		_Smoothness ("Smoothness", Range(0, 1)) = 0.16
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