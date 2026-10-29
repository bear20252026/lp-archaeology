Shader "B612/Waterfall" {
	Properties {
		[NoScaleOffset] _FoamTex ("Foam (Water_Foam, legacy)", 2D) = "white" {}
		[NoScaleOffset] _StreakTex ("Streaks (R streaks, G strands, B drops, A spray)", 2D) = "gray" {}
		_Color ("Water Colour", Vector) = (0.78,0.86,0.9,1)
		_Speed ("Legacy Fall Speed (m/s, no UV1)", Float) = 2.6
		_Tile ("Streak Tile (x across 1/u, y seconds of flight)", Vector) = (1.4,0.45,0,0)
		_Opacity ("Opacity", Range(0, 1)) = 0.85
		_Length ("Fall Length (m)", Float) = 12
		_BottomFade ("Bottom Fade (share of the length)", Range(0.05, 0.9)) = 0.3
		_SheetThickness ("Sheet Thickness At The Lip (m)", Float) = 0.0055
		_Zones ("Zone Drops (nappe end, strands start, spray start, m)", Vector) = (0.6,3,7,0)
		_WindDrift ("Wind Drift Acceleration (m/s2)", Float) = 0.4
		_Reflection ("Sheet Reflection", Range(0, 1)) = 0.5
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