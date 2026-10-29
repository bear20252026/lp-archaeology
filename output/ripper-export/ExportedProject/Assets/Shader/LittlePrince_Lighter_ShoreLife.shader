Shader "LittlePrince/Lighter/ShoreLife" {
	Properties {
		_ColorRoot ("Root Colour", Vector) = (0.11,0.07,0.03,1)
		_ColorTip ("Tip Colour", Vector) = (0.5,0.36,0.11,1)
		_Variation ("Per-piece Variation", Range(0, 0.6)) = 0.25
		_Occlusion ("Occlusion Strength", Range(0, 1)) = 0.6
		_Smoothness ("Smoothness (wet)", Range(0, 1)) = 0.55
		_TransColor ("Translucency Colour", Vector) = (1,0.62,0.22,1)
		_Translucency ("Translucency", Range(0, 3)) = 1.2
		_Sway ("Sway (x amplitude m, y speed, z phase scale)", Vector) = (0.05,1.1,0.7,0)
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