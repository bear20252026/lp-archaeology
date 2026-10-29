Shader "B612/CloudPuff" {
	Properties {
		[NoScaleOffset] _CumulusPos ("Cumulus Six-Way + (rgb +x +y +z, a coverage)", 2D) = "black" {}
		[NoScaleOffset] _CumulusNeg ("Cumulus Six-Way -", 2D) = "black" {}
		_Cell ("Atlas Cell (0..3, +4 = mirror)", Float) = 0
		_Opacity ("Opacity", Range(0, 1)) = 0.9
		_Softness ("Coverage Exponent", Range(0.3, 3)) = 1.2
		_Contrast ("Light Contrast", Range(0.3, 3)) = 1
		_SunScale ("Sun Scale", Float) = 0.9
		_AmbientScale ("Ambient Scale", Float) = 1.1
		_Silver ("Backlit Silver Lining", Float) = 0.6
		_DepthFade ("Depth Fade (m)", Float) = 6
		_NearFade ("Near Fade (x hidden, y full, m)", Vector) = (6,18,0,0)
		_HazeDensity ("Haze Density (1/m)", Float) = 0.0015
		_HazeStart ("Haze Start (m)", Float) = 40
		_BottomFade ("Bottom Fade (share of the card height)", Range(0, 0.6)) = 0
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