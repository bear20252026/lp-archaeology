Shader "RoyalCourt/LandFoliage" {
	Properties {
		_BaseMap ("Atlas (A = alpha)", 2D) = "white" {}
		_BaseColor ("Tint", Vector) = (1,1,1,1)
		_VariationColor ("Variation Tint (vertex A)", Vector) = (1.12,1.06,0.8,1)
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.45
		[Toggle] _AlphaToMask ("Alpha To Coverage", Float) = 1
		_ShellBlend ("Shell Normal Weight", Range(0, 1)) = 0.8
		_AOStrength ("Crown Occlusion (vertex B)", Range(0, 1)) = 0.75
		_Wrap ("Wrap", Range(0, 1)) = 0.45
		_Translucency ("Translucency", Range(0, 2)) = 0.6
		_TransColor ("Translucency Tint", Vector) = (1.2,1.1,0.55,1)
		_Specular ("Specular", Range(0, 1)) = 0.05
		_AmbientBoost ("Ambient", Range(0, 2)) = 1
		_WindStrength ("Wind (m)", Range(0, 0.3)) = 0.03
		_WindSpeed ("Wind Speed", Range(0, 4)) = 1.3
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 0
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