Shader "Bar/BottleGlass" {
	Properties {
		_BaseColor ("Glass colour", Vector) = (0.13,0.28,0.1,1)
		_AlphaCenter ("Alpha facing the camera", Range(0, 1)) = 0.3
		_AlphaEdge ("Alpha at the silhouette", Range(0, 1)) = 0.95
		_FresnelPower ("Fresnel power", Range(0.5, 8)) = 2
		_EdgeDarken ("Darker toward the edges", Range(0, 1)) = 0.5
		_Smoothness ("Smoothness", Range(0, 1)) = 0.95
		_Absorb ("Tint of what is behind", Range(0, 1)) = 0.6
		_Transmit ("Light let through (0 dark, 1 clear)", Range(0, 1)) = 0.55
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