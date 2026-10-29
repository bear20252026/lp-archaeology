Shader "LittlePrince/Lighter/Spray" {
	Properties {
		[NoScaleOffset] _MainTex ("Spray (RGB shading, A coverage)", 2D) = "white" {}
		_Color ("Colour", Vector) = (1,0.99,0.97,1)
		_Light ("Light (x sun, y sky, z glow toward the sun, w glow exponent)", Vector) = (0.85,1.35,1.6,5)
		_Fade ("Fade (x soft depth m, y waterline fade m, z camera near m, w waterline height m)", Vector) = (0.3,0.3,1.2,-0.1)
		[Enum(Spray,0,Mist,1,Droplet,2)] _Kind ("Kind", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;
			float4 _MainTex_ST;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Vertex_Stage_Output
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.uv = (input.uv.xy * _MainTex_ST.xy) + _MainTex_ST.zw;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			Texture2D<float4> _MainTex;
			SamplerState sampler_MainTex;
			float4 _Color;

			struct Fragment_Stage_Input
			{
				float2 uv : TEXCOORD0;
			};

			float4 frag(Fragment_Stage_Input input) : SV_TARGET
			{
				return _MainTex.Sample(sampler_MainTex, input.uv.xy) * _Color;
			}

			ENDHLSL
		}
	}
}