Shader "Desert/Rock" {
	Properties {
		_BaseMap ("Base Colour", 2D) = "white" {}
		_BaseColor ("Tint", Vector) = (1,1,1,1)
		[NoScaleOffset] [Normal] _BumpMap ("Normal", 2D) = "bump" {}
		_BumpScale ("Normal Strength", Float) = 1
		[NoScaleOffset] _MaskMap ("Mask (R metal, G AO, A smooth)", 2D) = "white" {}
		_Smoothness ("Smoothness Scale", Range(0, 1)) = 0.35
		_Metallic ("Metallic Scale (Mask.R)", Range(0, 1)) = 0
		_OcclusionStrength ("AO Strength", Range(0, 1)) = 0.8
		[HDR] _EmissionColor ("Emission", Vector) = (0,0,0,1)
		[Header(Triplanar detail)] [NoScaleOffset] _DetailAlbedo ("Detail Albedo (luminance)", 2D) = "gray" {}
		[NoScaleOffset] [Normal] _DetailNormal ("Detail Normal", 2D) = "bump" {}
		_DetailTile ("Detail Tile (m)", Float) = 2.6
		_DetailAlbedoStrength ("Detail Albedo Strength", Range(0, 1.5)) = 0.7
		_DetailNormalStrength ("Detail Normal Strength", Range(0, 2)) = 0.9
		_DetailFade ("Detail Fade Distance (m)", Float) = 90
		[Header(Colour)] _Saturation ("Saturation", Range(0, 2)) = 0.9
		_Brightness ("Brightness", Range(0, 2)) = 1
		_WarmTint ("Warm Variation", Vector) = (1.06,0.95,0.86,1)
		_CoolTint ("Cool Variation", Vector) = (0.9,0.88,0.92,1)
		_MacroNoise ("Macro Noise", 2D) = "gray" {}
		_MacroScale ("Macro Scale (m)", Float) = 60
		_VariationAmount ("Variation Amount", Range(0, 1)) = 0.5
		[Header(Sand)] _SandColor ("Sand Colour", Vector) = (0.8,0.64,0.46,1)
		_SandTop ("Sand on Tops (normal.y threshold, softness)", Vector) = (0.72,0.12,0,0)
		_SandAmount ("Sand on Tops Amount", Range(0, 1)) = 0.6
		_SandSkirt ("Sand Skirt Height (m)", Float) = 0.45
		[Header(Vertex colour stone (ART masonry))] [Toggle(_VERTEX_STONE)] _VertexStone ("Vertex Colour: R stone random, G crevice AO, B sand", Float) = 0
		[Toggle(_VERTEX_BASE)] _VertexBase ("Vertex Colour = sRGB Base Colour (user rocks)", Float) = 0
		_StoneVariation ("Per-Stone Brightness Variation", Range(0, 0.5)) = 0.14
		_CreviceAO ("Crevice AO (vertex G)", Range(0, 1)) = 0.6
		_VertexSand ("Up-facing Sand (vertex B)", Range(0, 1)) = 0.6
		_BounceScale ("Ground Bounce", Range(0, 2)) = 1
		[Header(Far)] [Toggle(_FAR)] _Far ("Far Mountain", Float) = 0
		_Wrap ("Diffuse Wrap (far)", Range(0, 1)) = 0.35
		_FarFade ("Far: extra fade into the fog colour (by distance 300..1200 m)", Range(0, 1)) = 0
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 2
		[HideInInspector] _DesertCamFade ("Camera fade", Float) = 0
		[HideInInspector] _DesertCamFadeC ("Camera fade box centre (w = 1: box only)", Vector) = (0,0,0,0)
		[HideInInspector] _DesertCamFadeX ("Camera fade box X axis / half extent", Vector) = (0,0,0,0)
		[HideInInspector] _DesertCamFadeY ("Camera fade box Y axis / half extent", Vector) = (0,0,0,0)
		[HideInInspector] _DesertCamFadeZ ("Camera fade box Z axis / half extent", Vector) = (0,0,0,0)
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