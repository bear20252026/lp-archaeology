Shader "B612/Steam" {
	Properties {
		[NoScaleOffset] _SixWayPos ("Six-Way + (Steam_Sheet_SixWayPos)", 2D) = "black" {}
		[NoScaleOffset] _SixWayNeg ("Six-Way - (Steam_Sheet_SixWayNeg)", 2D) = "black" {}
		_Tint ("Tint", Vector) = (1,1,1,1)
		_Opacity ("Opacity", Range(0, 2)) = 0.8
		_SunStrength ("Sun Light", Range(0, 3)) = 1.1
		_AmbientStrength ("Sky Light", Range(0, 3)) = 1
		_Transmission ("Back-light Boost", Range(0, 3)) = 1
		_Contrast ("Light Contrast", Range(0.5, 2)) = 1
		_SoftDistance ("Soft Particle Distance (m)", Range(0.01, 3)) = 0.8
		_NearFade ("Near Camera Fade (m)", Range(0, 5)) = 1.5
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