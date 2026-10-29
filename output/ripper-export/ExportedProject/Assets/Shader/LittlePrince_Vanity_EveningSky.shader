Shader "LittlePrince/Vanity/EveningSky" {
	Properties {
		_Top ("Zenith", Vector) = (0.14,0.34,0.63,1)
		_Horizon ("Horizon", Vector) = (0.95,0.58,0.28,1)
		_SunDirection ("Direction toward sun", Vector) = (-0.8,0.16,0.56,0)
		_WarmFloor ("Minimum sunset warmth away from the sun", Range(0, 1)) = 0
		_CloudPos ("Cloud light atlas", 2D) = "black" {}
		_CloudNeg ("Cloud shade atlas", 2D) = "black" {}
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