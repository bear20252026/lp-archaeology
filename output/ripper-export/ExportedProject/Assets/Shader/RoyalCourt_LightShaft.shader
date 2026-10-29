Shader "RoyalCourt/LightShaft" {
	Properties {
		_Color ("Colour", Vector) = (1,0.78,0.5,1)
		_Intensity ("Intensity", Float) = 0.12
		_FadeIn ("Fade-in length (m)", Float) = 0.5
		_Falloff ("Falloff distance (m)", Float) = 7
		_EdgePower ("Edge softness power", Float) = 1.6
		_SoftDepth ("Depth fade distance (m)", Float) = 0.6
		_NearFade ("Camera near fade (m)", Float) = 1.2
		_Streaks ("Streak contrast", Float) = 0.45
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