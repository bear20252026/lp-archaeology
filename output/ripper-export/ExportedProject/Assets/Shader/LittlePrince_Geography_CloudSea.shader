Shader "LittlePrince/Geography/CloudSea" {
	Properties {
		[NoScaleOffset] _NoiseTex ("Cloud noise (R swell, G puffs, B small puffs)", 2D) = "gray" {}
		_TileSize ("Noise tile size (m)", Float) = 400
		_TopY ("Slab top y (quad height)", Float) = -12
		_BaseY ("Slab base y", Float) = -48
		_Wind ("Unused (round 5: global _GeoCloudWind)", Vector) = (0.9,0,0.35,0)
		_Blanket ("Blanket level", Float) = 0.22
		_SwellAmp ("Swell amplitude", Float) = 0.1
		_PuffAmp ("Puff amplitude", Float) = 0.35
		_PuffSwell ("Puff growth with swell", Float) = 0.3
		_SmallAmp ("Small puff amplitude", Float) = 0.1
		_Albedo ("Cloud colour", Vector) = (1,1,1,1)
		_SunTint ("Sunlight tint", Vector) = (1,0.9,0.75,1)
		_SunStrength ("Sunlight strength", Float) = 0.55
		_AmbientTop ("Ambient (up-facing)", Vector) = (0.62,0.7,0.84,1)
		_AmbientBottom ("Ambient (down-facing / crevices)", Vector) = (0.4,0.43,0.53,1)
		_Wrap ("Wrap lighting", Range(0, 1)) = 0.5
		_ShadowDensity ("Self-shadow density", Float) = 0.12
		_CreaseDark ("Crease darkening", Range(0, 1)) = 0.4
		_ScatterColor ("Forward scatter colour", Vector) = (1,0.8,0.55,1)
		_ScatterPower ("Forward scatter tightness", Float) = 6
		_ScatterStrength ("Forward scatter strength", Float) = 0.35
		_FuzzHeight ("Soft fuzz height (m)", Float) = 2.5
		_FuzzStrength ("Soft fuzz strength", Float) = 0.06
		_HorizonColor ("Sky horizon", Vector) = (0.9,0.89,0.86,1)
		_SunHorizonColor ("Sky horizon toward the sun", Vector) = (1,0.82,0.58,1)
		_BelowColor ("Sky below horizon", Vector) = (0.93,0.89,0.84,1)
		_HorizonWarmth ("Horizon warmth concentration", Float) = 2.5
		_HazeDistance ("Haze distance (m)", Float) = 650
		_HazePower ("Haze curve", Float) = 1.3
		_FadeRadius ("Disc edge radius (m)", Float) = 1800
		_MaxMarch ("Max march length (m)", Float) = 1100
		_StepScale ("Step size / distance", Float) = 0.055
		_SoftDepth ("Soft intersection (m)", Float) = 5
		_LodScale ("Noise LOD per metre", Float) = 0.012
		_DetailScale ("Detail bump frequency (x tile)", Float) = 7
		_DetailStrength ("Detail bump strength", Float) = 5
		_DetailFade ("Detail fade distance (m)", Float) = 250
		_RimShade ("Silhouette shading (front-lit definition)", Range(0, 1)) = 0.3
		_GoldRim ("Golden rim on sun-facing edges", Float) = 0.6
		_GoldColor ("Golden rim colour", Vector) = (1,0.72,0.42,1)
		_NormalSoft ("Normal softening", Range(0, 1)) = 0.3
		_EdgeSkin ("Soft edge skin (m, grows with distance)", Float) = 3
		_MidHazeColor ("Aerial haze (mid distance)", Vector) = (0.74,0.78,0.88,1)
		_MidHazeDistance ("Aerial haze distance (m)", Float) = 450
		_MidHazeMax ("Aerial haze max", Range(0, 1)) = 0.45
		_ClearCentre ("Clearing centre (xz) / inner, outer radius", Vector) = (-1.5,2,70,220)
		_ClearDepth ("Clearing dip (normalised)", Float) = 0.25
		_CottonAmount ("Soft cotton shading (no relief)", Range(0, 0.6)) = 0
		_RimColor ("Silhouette shade colour", Vector) = (0.62,0.68,0.86,1)
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