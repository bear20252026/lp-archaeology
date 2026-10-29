Shader "B612/SandBoil" {
	Properties {
		[NoScaleOffset] _SandTex ("Sand (SandBoil_Sand, sRGB)", 2D) = "white" {}
		[NoScaleOffset] [Normal] _SandNormal ("Sand Normal (SandBoil_Normal)", 2D) = "bump" {}
		_Tile ("Sand Tile (m)", Float) = 0.22
		_Tint ("Sand Tint", Vector) = (0.95,0.92,0.84,1)
		_Vent ("Vent (world xz, w = throat radius)", Vector) = (0,0,0,0.11)
		_ConeRadius ("Cone Radius (m)", Float) = 0.32
		_Churn ("Churn In The Throat", Range(0, 0.1)) = 0.035
		_ChurnSpeed ("Churn Speed", Float) = 2.2
		_Lifted ("Lifted Sand Haze", Range(0, 1)) = 0.35
		_NormalStrength ("Normal Strength", Range(0, 2)) = 0.8
		_WaterTint ("Under-water Tint (the shallow pool over the cone)", Vector) = (1,1,1,1)
		_ThroatDark ("Throat Darkness", Range(0, 1)) = 0.45
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