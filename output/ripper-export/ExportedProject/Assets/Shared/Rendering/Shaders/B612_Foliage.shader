Shader "B612/Foliage" {
	Properties {
		_BaseMap ("Albedo (A = alpha)", 2D) = "white" {}
		_BaseColor ("Tint", Vector) = (1,1,1,1)
		[Toggle(_ALPHATEST_ON)] _AlphaClip ("Alpha Clip", Float) = 1
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
		[Toggle] _AlphaToMask ("Alpha To Coverage (MSAA)", Float) = 1
		[NoScaleOffset] [Normal] _BumpMap ("Normal", 2D) = "bump" {}
		_BumpScale ("Normal Strength", Range(0, 2)) = 0.6
		[NoScaleOffset] _MaskMap ("Mask (R metal, G AO, B translucency, A smoothness)", 2D) = "white" {}
		[Header(Shading)] _ShellBlend ("Shell Normal Weight", Range(0, 1)) = 0.8
		_OcclusionStrength ("Mask AO Strength", Range(0, 1)) = 1
		_CrownOcclusion ("Crown Occlusion (vertex B)", Range(0, 1)) = 0.55
		_BackfaceTint ("Back Face Tint", Vector) = (1.06,1.1,0.8,1)
		_Wrap ("Diffuse Wrap", Range(0, 1)) = 0.3
		_Terminator ("Terminator Sharpness", Range(0, 1)) = 0.6
		_InnerLight ("Direct Light Inside Crown", Range(0, 1)) = 0.5
		_EdgeGlow ("Backlit Edge Glow", Range(0, 2)) = 0.6
		_ShadowStrength ("Received Shadow Strength", Range(0, 1)) = 0.85
		[HDR] _TransColor ("Translucency Tint (x albedo)", Vector) = (1.25,1.2,0.55,1)
		_TransStrength ("Translucency", Range(0, 2)) = 0.6
		_TransPower ("Translucency Focus", Range(1, 16)) = 4
		_SpecStrength ("Specular", Range(0, 1)) = 0.2
		_AmbientBoost ("Ambient Multiplier", Range(0, 2)) = 1
		_HueVariation ("Per-Plant Hue Variation", Range(0, 0.1)) = 0.025
		_BrightnessVariation ("Per-Plant Brightness Variation", Range(0, 0.4)) = 0.12
		_ClusterVariation ("Per-Cluster Hue / Value (vertex G)", Range(0, 1)) = 0.35
		_Saturation ("Saturation (1 = as authored)", Range(0, 1.5)) = 1
		_EdgeOnFade ("Fade Cards Seen Edge-On", Range(0, 1)) = 0
		[Header(Wind)] [Enum(Tree or Shrub, 0, Ground Plant, 1, None, 2)] _WindMode ("Wind Mode", Float) = 0
		_WindBend ("Tree: Crown Bend (m)", Range(0, 0.5)) = 0.06
		_WindBranch ("Tree: Branch Sway (m)", Range(0, 0.5)) = 0.05
		_WindFlutter ("Leaf Flutter (m)", Range(0, 0.1)) = 0.012
		_WindFrequency ("Tree: Branch Frequency", Range(0.1, 4)) = 1.3
		_PlantWind ("Plant: Tip Displacement (m)", Range(0, 0.5)) = 0.05
		_InteractionStrength ("Plant: Player Push", Range(0, 1)) = 1
		[Header(Far Haze for far tree belts. Density 0 is off)] _HazeDensity ("Haze Density (1/m)", Float) = 0
		_HazeStart ("Haze Start (m)", Float) = 40
		_HazeFalloff ("Haze Falloff Power", Range(0.5, 2.5)) = 1.3
		_MistHeight ("Mist Top Height (world y)", Float) = 8
		_MistDensity ("Mist Density (1/m)", Float) = 0.004
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull", Float) = 0
		[Enum(Off, 0, Shell Normal, 1, Final Normal, 2, Vertex Colour, 3, Mask, 4, Diffuse Only, 5)] _DebugView ("Debug View", Float) = 0
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