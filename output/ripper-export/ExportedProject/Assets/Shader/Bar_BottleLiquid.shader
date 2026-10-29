Shader "Bar/BottleLiquid" {
	Properties {
		_BaseColor ("Liquid", Vector) = (0.11,0.045,0.02,1)
		_TopColor ("Surface", Vector) = (0.16,0.07,0.03,1)
		_BubbleColor ("Bubbles", Vector) = (1,0.86,0.6,1)
		_Smoothness ("Smoothness", Range(0, 1)) = 0.85
		_BubbleScale ("Bubble cells per metre", Float) = 55
		_BubbleSpeed ("Bubble rise (m/s)", Float) = 0.2
		[HideInInspector] _FillPlane ("Level plane (normal, offset)", Vector) = (0,1,0,100)
		[HideInInspector] _Glug ("Drinking 0..1", Float) = 0
		[HideInInspector] _BubbleTime ("Bubble time", Float) = 0
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