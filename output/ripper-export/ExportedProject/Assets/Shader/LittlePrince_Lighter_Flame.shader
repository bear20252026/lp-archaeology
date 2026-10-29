Shader "LittlePrince/Lighter/Flame" {
	Properties {
		_Size ("Flame (x width m, y height m)", Vector) = (0.042,0.105,0,0)
		[HDR] _Core ("Core (HDR)", Vector) = (3,2.3,1,1)
		[HDR] _Mid ("Body (HDR)", Vector) = (2.5,1.15,0.2,1)
		[HDR] _Edge ("Edge (HDR)", Vector) = (1.3,0.3,0.03,1)
		[HDR] _Wick ("At the wick (HDR)", Vector) = (0.25,0.4,1,1)
		_Level ("Caught (0..1)", Range(0, 1.2)) = 1
		_Motion ("Motion (x speed, y sway, z ripple, w seed)", Vector) = (1,0.22,0.11,0)
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