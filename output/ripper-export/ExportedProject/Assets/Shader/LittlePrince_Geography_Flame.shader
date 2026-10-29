Shader "LittlePrince/Geography/Flame" {
	Properties {
		_CoreColor ("Core colour", Vector) = (1,0.93,0.74,1)
		_EdgeColor ("Edge colour", Vector) = (1,0.46,0.12,1)
		_BaseColor ("Wick-base colour", Vector) = (0.3,0.36,1,1)
		_Intensity ("HDR intensity", Float) = 7
		_Mode ("0 flame, 1 glow", Float) = 0
		_RefHeight ("Reference height (m)", Float) = 0.11
		_SoftDepth ("Depth fade distance (m)", Float) = 0.04
		_Sway ("Tip sway", Float) = 0.08
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