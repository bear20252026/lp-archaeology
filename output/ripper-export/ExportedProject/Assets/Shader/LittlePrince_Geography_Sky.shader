Shader "LittlePrince/Geography/Sky" {
	Properties {
		_ZenithColor ("Zenith", Vector) = (0.3,0.5,0.82,1)
		_HorizonColor ("Horizon", Vector) = (0.9,0.89,0.86,1)
		_SunHorizonColor ("Horizon toward the sun", Vector) = (1,0.82,0.58,1)
		_BelowColor ("Below horizon (far cloud-sea haze)", Vector) = (0.93,0.89,0.84,1)
		_HorizonSharpness ("Gradient sharpness", Float) = 3.2
		_HorizonWarmth ("Horizon warmth concentration", Float) = 2.5
		_SunDir ("Direction toward the sun", Vector) = (0.5,0.5,-0.7,0)
		_SunColor ("Sun disk colour", Vector) = (1,0.92,0.75,1)
		_SunDiskCos ("Sun disk cos", Float) = 0.99965
		_SunDiskIntensity ("Sun disk intensity", Float) = 30
		_GlowColor ("Sun glow colour", Vector) = (1,0.78,0.5,1)
		_GlowPower ("Sun glow tightness", Float) = 5
		_GlowStrength ("Sun glow strength", Float) = 0.45
		_HaloPower ("Sun halo tightness", Float) = 60
		_HaloStrength ("Sun halo strength", Float) = 0.8
		[NoScaleOffset] _CloudTex ("Cloud radiance (premultiplied)", 2D) = "black" {}
		[NoScaleOffset] _CloudAlpha ("Cloud coverage", 2D) = "black" {}
		_CloudYaw ("Cloud yaw (deg)", Float) = 60
		_CloudTint ("Cloud tint", Vector) = (1,0.95,0.88,1)
		_CloudExposure ("Cloud exposure", Float) = 1
		_CloudFill ("Cloud shadow fill", Vector) = (0.08,0.08,0.1,1)
		_CloudOpacity ("Cloud opacity", Range(0, 1)) = 1
		_CloudHorizonFade ("Cloud horizon fade (deg: x start, y full)", Vector) = (0.5,7,0,0)
		_CloudHaze ("Low cloud haze", Range(0, 1)) = 0.45
		_CloudSunGlow ("Cloud glow toward the sun", Float) = 1.2
		_CloudCut ("Cloud coverage cut (smaller, thinner clouds)", Range(0, 0.9)) = 0
		_CloudSunThin ("Cloud thinning toward the sun", Range(0, 1)) = 0.45
		_Exposure ("Exposure", Float) = 1
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