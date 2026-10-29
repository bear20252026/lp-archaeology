Shader "LittlePrince/Geography/Distant" {
	Properties {
		_BaseMap ("Base map", 2D) = "white" {}
		_BaseColor ("Base colour", Vector) = (1,1,1,1)
		[Normal] _BumpMap ("Normal map", 2D) = "bump" {}
		_BumpScale ("Normal scale", Float) = 1
		_Cutoff ("Alpha cutoff (0 = off)", Range(0, 1)) = 0
		_Lit ("Lit (0 = unlit)", Range(0, 1)) = 1
		_Wrap ("Wrap", Range(0, 1)) = 0.4
		_Translucency ("Translucency (light through thin foliage)", Range(0, 1)) = 0
		_SunStrength ("Sun strength", Float) = 0.35
		_Ambient ("Ambient", Vector) = (0.55,0.62,0.76,1)
		_UnlitBrightness ("Unlit brightness", Float) = 1
		_HazeColor ("Aerial haze (blue)", Vector) = (0.62,0.7,0.84,1)
		_HazeDistance ("Haze distance (m)", Float) = 900
		_HazeMax ("Haze max", Range(0, 1)) = 0.8
		_HorizonColor ("Sky horizon", Vector) = (0.93,0.9,0.85,1)
		_SunHorizonColor ("Sky horizon toward the sun", Vector) = (1,0.8,0.56,1)
		_BelowColor ("Sky below horizon", Vector) = (0.94,0.9,0.85,1)
		_HorizonWarmth ("Horizon warmth", Float) = 2.5
		_FarDistance ("Horizon-band distance (m)", Float) = 4000
		_HazeWarm ("Aerial haze toward the sun", Vector) = (0.95,0.82,0.66,1)
		_CloudTop ("Cloud-sea top y", Float) = -60
		_CloudFogRange ("Height fog above the cloud top (m)", Float) = 35
		_CloudColor ("Cloud colour (height fog)", Vector) = (0.93,0.93,0.94,1)
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2
		[Toggle] _AlphaToMask ("Alpha to coverage (clipped foliage)", Float) = 0
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