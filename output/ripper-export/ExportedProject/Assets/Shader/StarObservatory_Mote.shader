Shader "StarObservatory/Mote" {
	Properties {
		[HDR] _Color ("Colour (HDR)", Vector) = (1.2,0.85,0.55,1)
		_Softness ("Dot Softness", Range(0.5, 6)) = 2.2
		_SoftDistance ("Soft Particle Distance (m)", Range(0.01, 1)) = 0.15
		_NearFade ("Near Camera Fade (x start, y full, m)", Vector) = (0.25,0.9,0,0)
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
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

			float4 _Color;

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				return _Color; // RGBA
			}

			ENDHLSL
		}
	}
}