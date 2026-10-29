Shader "B612/Glow" {
	Properties {
		[HDR] _GlowColor ("Glow Colour (HDR)", Vector) = (1.2,0.35,0.08,1)
		_Falloff ("Radial Falloff", Range(0.5, 8)) = 2.2
		_FlickerAmount ("Flicker Amount", Range(0, 1)) = 0.18
		_FlickerSpeed ("Flicker Speed", Range(0, 4)) = 0.7
		_FlickerSeed ("Flicker Seed", Float) = 0
		_SoftDistance ("Soft Distance (m)", Range(0.01, 3)) = 0.6
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