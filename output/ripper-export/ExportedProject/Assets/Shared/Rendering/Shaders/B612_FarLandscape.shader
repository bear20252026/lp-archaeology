Shader "B612/FarLandscape" {
	Properties {
		_BaseColor ("Base Colour", Vector) = (0.42,0.55,0.27,1)
		_WarmColor ("Warm Variation", Vector) = (0.62,0.62,0.3,1)
		_CoolColor ("Cool Variation", Vector) = (0.3,0.48,0.3,1)
		[NoScaleOffset] _MacroNoise ("Macro Noise (Noise_Macro)", 2D) = "gray" {}
		_MacroTiling ("Macro Tiling (1/m)", Float) = 0.004
		_Variation ("Colour Variation", Range(0, 1)) = 0.6
		_Wrap ("Diffuse Wrap", Range(0, 1)) = 0.6
		_NormalSoften ("Normal Softening (toward up)", Range(0, 1)) = 0.45
		_AmbientBoost ("Ambient", Range(0, 2)) = 1
		_CloudShadows ("Cloud Shadows (x preset strength)", Range(0, 1)) = 1
		[Header(Aerial Perspective)] _HazeDensity ("Haze Density (1/m)", Float) = 0.0035
		_HazeStart ("Haze Start (m)", Float) = 40
		_HazeFalloff ("Haze Falloff Power (1 exp, 2 exp2)", Range(0.5, 2.5)) = 1.3
		_MistHeight ("Mist Top Height (world y)", Float) = 8
		_MistDensity ("Mist Density (1/m)", Float) = 0.004
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