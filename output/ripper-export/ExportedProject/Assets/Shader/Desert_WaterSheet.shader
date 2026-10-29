Shader "Desert/WaterSheet" {
	Properties {
		_Tint ("Water Tint (linear)", Vector) = (0.55,0.7,0.68,1)
		_Foam ("Aerated Colour", Vector) = (0.95,0.97,0.98,1)
		_Columns ("Streak Columns (around)", Float) = 48
		_Rows ("Streak Length Scale", Float) = 3
		_Speed ("Scroll Speed (uv / s)", Float) = 1.6
		_Alpha ("Alpha: x glassy start, y streak peak, z streak floor, w overall", Vector) = (0.42,0.9,0.12,1)
		_Break ("Break-up: x start, y full (uv.y)", Vector) = (0.12,0.65,0,0)
		_Aerate ("Aeration: x start, y full (uv.y), z amount", Vector) = (0.2,1,0.65,0)
		_Reflection ("Reflection Strength", Range(0, 2)) = 0.8
		_Sun ("Sun Glint", Range(0, 10)) = 2.5
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