Shader "RoyalCourt/PlanarReflectionOverlay" {
	Properties {
		_Tint ("Tint", Vector) = (1,1,1,1)
		_Strength ("Strength", Range(0, 1.5)) = 1
		_F0 ("Reflectance at normal incidence", Range(0, 1)) = 0.06
		_FresnelPower ("Fresnel power", Range(1, 8)) = 4
		_MaxAlpha ("Max blend", Range(0, 1)) = 0.8
		_Blur ("Blur (mip)", Range(0, 4)) = 1.2
		_DistortMap ("Distortion normal", 2D) = "bump" {}
		_DistortTiling ("Distortion tiling (m)", Float) = 2
		_Distort ("Distortion", Range(0, 0.05)) = 0.008
		_Compress ("Highlight compression", Range(0, 2)) = 0.35
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