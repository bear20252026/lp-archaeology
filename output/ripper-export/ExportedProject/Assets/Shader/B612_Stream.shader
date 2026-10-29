Shader "B612/Stream" {
	Properties {
		[Header(Flow)] [NoScaleOffset] _FlowMap ("Flow Map (generated, RGBAHalf)", 2D) = "black" {}
		_FlowMapST ("Flow Map Transform (u scale, s scale, u offset, s offset)", Vector) = (1,0.06,0,0)
		[NoScaleOffset] _NoiseTex ("Phase Noise (Noise_Macro)", 2D) = "gray" {}
		_Cycle ("Flow Cycle (s)", Range(0.3, 3)) = 0.9
		_FlowSpeedScale ("Advection Speed Scale", Range(0, 2)) = 1
		[Header(Surface)] [NoScaleOffset] [Normal] _NormalA ("Normal A (Water_NormalA)", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _NormalB ("Normal B (Water_NormalB)", 2D) = "bump" {}
		_TileA ("Normal A Tile (m)", Float) = 0.9
		_TileB ("Normal B Tile (m)", Float) = 0.35
		_NormalStrength ("Normal Strength (x chop)", Range(0, 2)) = 0.9
		_Standing ("Standing Waves In Runs", Range(0, 1)) = 0.45
		[Header(Current lines and sparkle)] [NoScaleOffset] _StreakTex ("Streaks (Water_Flecks, B = lines along v)", 2D) = "gray" {}
		_StreakTile ("Streak Tile (m across, m along)", Vector) = (2.2,2.6,0,0)
		_Streaks ("Current Lines (normal ridges)", Range(0, 1)) = 0.5
		_FoamLines ("Foam Lines Trailing Downstream", Range(0, 1)) = 0.6
		_Sparkle ("Sun Sparkle On Fast Water", Range(0, 4)) = 1.5
		_Churn ("Whitewater Churn", Range(0, 1)) = 0.6
		[Header(Colour)] _ScatterColor ("In-scatter Colour", Vector) = (0.15,0.34,0.33,1)
		_ScatterDensity ("In-scatter Density (1/m)", Range(0, 10)) = 2.4
		_Absorption ("Absorption (1/m, rgb)", Vector) = (2,0.8,0.6,0)
		_DeepColor ("Deep Tint", Vector) = (0.05,0.13,0.13,1)
		_Refraction ("Refraction", Range(0, 0.15)) = 0.05
		[Header(Reflection)] _ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1.05
		_F0 ("Fresnel F0", Range(0, 0.2)) = 0.025
		_Roughness ("Surface Roughness", Range(0.01, 0.5)) = 0.06
		_SunSpecular ("Sun Glint", Range(0, 4)) = 1.4
		[Header(Foam and Whitewater)] [NoScaleOffset] _FoamTex ("Foam (Water_Foam)", 2D) = "black" {}
		_FoamTile ("Foam Tile (m)", Float) = 0.55
		_FoamColor ("Foam Colour", Vector) = (0.94,0.96,0.95,1)
		_FoamAmount ("Foam Amount", Range(0, 2)) = 1
		_FoamStones ("Foam Where Shallower Than (m)", Range(0, 0.2)) = 0.035
		_Whitewater ("Whitewater Opacity", Range(0, 1)) = 0.85
		_EdgeSoftness ("Edge Softness (m of depth)", Range(0.005, 0.2)) = 0.025
		[Header(Caustics)] [NoScaleOffset] _CausticsTex ("Caustics (Water_Caustics)", 2D) = "black" {}
		_CausticsTile ("Caustics Tile (m)", Float) = 0.8
		_CausticsStrength ("Caustics Strength", Range(0, 3)) = 0.9
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