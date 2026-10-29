Shader "Bar/GroundStone" {
	Properties {
		[Header(Stone library atlas)] _BaseMap ("Atlas colour (uv0)", 2D) = "white" {}
		_BaseColor ("Colour multiplier", Vector) = (1,1,1,1)
		[NoScaleOffset] [Normal] _BumpMap ("Atlas normal", 2D) = "bump" {}
		[NoScaleOffset] _MaskMap ("Atlas mask (G AO, B tint weight, A smoothness)", 2D) = "white" {}
		_VertexTint ("Vertex tint strength", Range(0, 1)) = 1
		[Toggle] _VertexColorSRGB ("Vertex colour is sRGB (Blender FBX)", Float) = 1
		_Smoothness ("Smoothness multiplier", Range(0, 2)) = 1
		_VertexSmoothness ("Vertex A smoothness scale", Float) = 1.6
		[Toggle] _VertexAlphaSmoothness ("Smoothness uses vertex A", Float) = 1
		_SmoothnessMax ("Smoothness cap", Range(0, 1)) = 0.55
		_MaskTintWeight ("Mask B = tint weight (0: always full tint)", Range(0, 1)) = 1
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2
		_OcclusionStrength ("AO strength (mask G)", Range(0, 1)) = 1
		[Header(Style grade (photographic 1 0 white 1))] _Saturation ("Saturation", Range(0, 2)) = 0.8
		_Contrast ("Contrast (about linear 0.18)", Range(-1, 1)) = -0.12
		_WarmTint ("Warm tint (linear rgb multiplier)", Vector) = (1,0.9,0.74,1)
		_Brightness ("Brightness", Range(0, 2)) = 0.8
		_NormalStrength ("Detail (normal strength)", Range(0, 2)) = 0.9
		[Header(Foot grit (uv1 Detail and uv2 Foot))] [NoScaleOffset] _GritMap ("Grit colour (Rocks022)", 2D) = "grey" {}
		_GritTiling ("Grit tiling per Detail unit (0.2 m / 0.5 m)", Float) = 0.4
		_GritTint ("Grit tint (linear rgb multiplier)", Vector) = (0.72,0.72,0.72,1)
		_GritStrength ("Grit strength", Range(0, 1)) = 1
		_GritFootScale ("Foot scale", Float) = 1.7
		_GritFootOffset ("Foot offset", Float) = -1.62
		_GritSoftness ("Threshold softness", Range(0.01, 0.5)) = 0.12
		_GritSmoothnessCut ("Smoothness loss under grit", Range(0, 1)) = 0.85
		_GritNormalFlatten ("Flatten stone normal under grit", Range(0, 1)) = 0.5
		[Header(Damp band)] _DampStart ("Band start (Foot)", Range(0, 1)) = 0.35
		_DampEnd ("Band full (Foot)", Range(0, 1)) = 0.85
		_DampDarken ("Darkest brightness", Range(0, 1)) = 0.55
		_DampStrength ("Strength", Range(0, 2)) = 1
		_DampNoiseScale ("Noise scale (per Detail unit)", Float) = 3
		_DampNoiseAmount ("Noise amount in the band", Range(0, 1)) = 1
		_DampBreakup ("Breakup (0 continuous .. 1 sparse)", Range(0, 1)) = 0.55
		_DampBreakupScale ("Breakup scale (per Detail unit)", Float) = 1.5
		_DampBreakupSoftness ("Breakup edge softness", Range(0.01, 0.5)) = 0.15
		_DampSmoothnessCut ("Smoothness loss in the band", Range(0, 1)) = 0.3
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
	Fallback "Hidden/Universal Render Pipeline/FallbackError"
}