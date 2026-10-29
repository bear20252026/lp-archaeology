Shader "LittlePrince/Vanity/PlanarMirror" {
	Properties {
		_ReflectionTex ("Live reflection", 2D) = "black" {}
		_Tint ("Silver tint", Vector) = (0.92,0.96,0.96,1)
		_ReflectionStrength ("Silver reflectivity", Range(0, 1)) = 0.96
		_EdgePatina ("Aged silver edge", Range(0, 0.25)) = 0.025
		[HideInInspector] _ReflectionValid ("Reflection valid", Float) = 0
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