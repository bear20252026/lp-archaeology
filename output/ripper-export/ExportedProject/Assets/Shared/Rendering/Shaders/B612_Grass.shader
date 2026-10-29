Shader "B612/Grass" {
	Properties {
		[Header(Colour Ramp (sRGB))] _ColorRoot ("Root", Vector) = (0.173,0.31,0.118,1)
		_ColorMid ("Mid", Vector) = (0.361,0.592,0.188,1)
		_ColorTip ("Tip", Vector) = (0.659,0.804,0.314,1)
		_MidPoint ("Mid Point", Range(0.1, 0.9)) = 0.45
		_ColorTrans ("Translucency", Vector) = (0.745,0.875,0.345,1)
		_TransAmount ("Translucency Amount", Range(0, 1)) = 0.34
		[Header(Patches and Variation)] _ColorLush ("Lush Patch (cool)", Vector) = (0.263,0.498,0.149,1)
		_ColorSunny ("Sunny Patch (yellow)", Vector) = (0.702,0.812,0.345,1)
		_ColorDry ("Dry / Straw", Vector) = (0.796,0.741,0.431,1)
		[NoScaleOffset] _MacroNoise ("Macro Noise (Noise_Macro)", 2D) = "gray" {}
		_MacroTiling ("Macro Tiling (1/m)", Float) = 0.018
		_LushAmount ("Lush Patch Amount", Range(0, 1)) = 0.5
		_SunnyAmount ("Sunny Patch Amount", Range(0, 1)) = 0.45
		_DryPatchAmount ("Warm Dry Patch Amount", Range(0, 1)) = 0.3
		_StrawAmount ("Straw Blades", Range(0, 1)) = 0.5
		_InstanceSunny ("Per-Instance Sunny", Range(0, 0.5)) = 0.18
		_InstanceBrightness ("Per-Instance Brightness", Range(0, 0.3)) = 0.1
		_InstanceHue ("Per-Instance Hue Jitter (toward Lush cool / Sunny warm)", Range(0, 1)) = 0
		_TipDesat ("Sunlit Tip Desaturation", Range(0, 1)) = 0
		_BladeVariation ("Per-Blade Brightness (G)", Range(0, 0.6)) = 0.3
		_VariationFade ("Blade Variation Fade Distance (m)", Float) = 30
		[Header(Flower Seas in the Distance)] _FlowerTips ("Flower Colour On Grass Tips", Range(0, 1.5)) = 1
		_FlowerTipStart ("Flower Tips From (m)", Float) = 9
		_FlowerTipEnd ("Flower Tips Full At (m)", Float) = 28
		[Header(Wind Waves)] _WaveBrightness ("Gust Brightening", Range(0, 1)) = 0.35
		_WaveSunny ("Gust Toward Sunny Tint", Range(0, 1)) = 0.5
		[Header(Lighting)] _Occlusion ("Clump Occlusion (vertex B)", Range(0, 1)) = 0.55
		_Wrap ("Diffuse Wrap", Range(0, 1)) = 0.5
		_NormalUp ("Normal Toward Up", Range(0, 1)) = 0
		_ShadowStrength ("Received Shadow Strength", Range(0, 1)) = 1
		_SpecStrength ("Specular", Range(0, 1)) = 0.1
		_Smoothness ("Smoothness", Range(0, 1)) = 0.4
		_AmbientBoost ("Ambient Multiplier", Range(0, 2)) = 1
		[Header(Wind)] _WindAmplitude ("Tip Displacement (m)", Range(0, 0.5)) = 0.08
		_InteractionStrength ("Player Push", Range(0, 1)) = 1
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