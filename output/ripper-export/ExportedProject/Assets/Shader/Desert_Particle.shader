Shader "Desert/Particle" {
	Properties {
		[HDR] _Color ("Colour", Vector) = (1,1,1,1)
		_Intensity ("Intensity", Float) = 1
		_Softness ("Edge Softness (power)", Range(0.3, 6)) = 1.5
		_Flame ("Flame Tongue", Range(0, 1)) = 0
		_NoiseTex ("Noise (R)", 2D) = "gray" {}
		_NoiseAmount ("Noise Break-up", Range(0, 1)) = 0
		_NoiseScale ("Noise Scale", Float) = 1
		_SoftDistance ("Soft Particle Distance (m)", Float) = 0.4
		_NearFade ("Near Camera Fade (m)", Float) = 0.4
		[Toggle(_BILLBOARD)] _Billboard ("Billboard Quad (static)", Float) = 0
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src Blend", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst Blend", Float) = 1
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