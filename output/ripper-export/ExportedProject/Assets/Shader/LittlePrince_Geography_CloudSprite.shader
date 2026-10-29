Shader "LittlePrince/Geography/CloudSprite" {
	Properties {
		[NoScaleOffset] _FrontTex ("Front (sun behind viewer)", 2D) = "white" {}
		[NoScaleOffset] _SideTex ("Side (sun from the right)", 2D) = "white" {}
		[NoScaleOffset] _BackTex ("Back (sun behind the cloud)", 2D) = "white" {}
		_Tint ("Tint", Vector) = (1,1,1,1)
		_Exposure ("Exposure", Float) = 1.25
		_BackExposure ("Back atlas exposure", Float) = 1
		_SoftDepth ("Soft depth (m)", Float) = 25
		_HazeColor ("Aerial haze", Vector) = (0.7,0.76,0.88,1)
		_HazeDistance ("Haze distance (m)", Float) = 1400
		_HazeMax ("Haze max", Range(0, 1)) = 0.5
		_HorizonColor ("Sky horizon", Vector) = (0.93,0.9,0.85,1)
		_SunHorizonColor ("Sky horizon toward the sun", Vector) = (1,0.8,0.56,1)
		_BelowColor ("Sky below horizon", Vector) = (0.94,0.9,0.85,1)
		_HorizonWarmth ("Horizon warmth", Float) = 2.5
		_FarDistance ("Horizon-band distance (m)", Float) = 2600
		_SoftTone ("Soft cloud tone (contrast reduction)", Vector) = (0.88,0.89,0.93,1)
		_Soften ("Soften toward the soft tone", Range(0, 1)) = 0.3
		_Distort ("Outline wobble (fraction of the sprite)", Range(0, 0.1)) = 0.03
		_Erode ("Fringe erosion", Range(0, 1)) = 0.35
		_FadeSeconds ("Forming / dissolving time (s)", Float) = 24
		_ShadeTint ("Shaded-side tint (cool)", Vector) = (0.88,0.94,1.08,1)
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