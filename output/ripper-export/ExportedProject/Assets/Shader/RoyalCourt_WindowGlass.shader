Shader "RoyalCourt/WindowGlass" {
	Properties {
		[HDR] _GlowColor ("Exterior glow, lower (HDR)", Vector) = (2.1,1.25,0.5,1)
		[HDR] _GlowColorTop ("Exterior glow, upper (HDR)", Vector) = (2.6,1.7,0.78,1)
		_GlowHeight ("Glow gradient height (m)", Float) = 3.6
		_ExteriorAlpha ("Exterior opacity", Range(0, 1)) = 0.9
		_InteriorTint ("Interior tint", Vector) = (1,0.95,0.86,1)
		_InteriorAlpha ("Interior opacity", Range(0, 1)) = 0.07
		_LeadColor ("Lead came colour", Vector) = (0.07,0.06,0.05,1)
		_LeadAlphaInterior ("Lead opacity from inside", Range(0, 1)) = 0.75
		_Quarry ("Quarry size (m): x, y", Vector) = (0.22,0.34,0,0)
		_LeadWidth ("Lead width (m)", Range(0.002, 0.05)) = 0.011
		_Variation ("Pane brightness variation", Range(0, 1)) = 0.35
		_UVScale ("UV to metres", Float) = 2
		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend ("Src blend", Float) = 5
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend ("Dst blend", Float) = 10
		[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
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