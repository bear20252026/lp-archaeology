Shader "B612/Bark" {
	Properties {
		_BaseMap ("Albedo", 2D) = "white" {}
		_BaseColor ("Tint", Vector) = (1,1,1,1)
		[NoScaleOffset] [Normal] _BumpMap ("Normal", 2D) = "bump" {}
		_BumpScale ("Normal Strength", Range(0, 2)) = 1
		[NoScaleOffset] _MaskMap ("Mask (R metal, G AO, B height, A smoothness)", 2D) = "white" {}
		_OcclusionStrength ("AO Strength", Range(0, 1)) = 0.8
		_Smoothness ("Smoothness Multiplier", Range(0, 2)) = 1
		[Normal] _DetailNormalMap ("Detail Normal (Detail_Bark_Normal)", 2D) = "bump" {}
		_DetailNormalScale ("Detail Normal Strength", Range(0, 2)) = 0.6
		[Header(Wind (match the foliage material))] [Enum(Tree or Shrub, 0, None, 2)] _WindMode ("Wind Mode", Float) = 0
		_WindBend ("Crown Bend (m)", Range(0, 0.5)) = 0.06
		_WindBranch ("Branch Sway (m)", Range(0, 0.5)) = 0.05
		_WindFrequency ("Branch Frequency", Range(0.1, 4)) = 1.3
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