Shader "LittlePrince/Lighter/Ocean" {
	Properties {
		[Header(Swell Gerstner x dirX y dirZ z steepness w wavelength m)] _WaveA ("Wave A", Vector) = (1,0.35,0.07,14)
		_WaveB ("Wave B", Vector) = (0.8,0.7,0.06,8.5)
		_WaveC ("Wave C", Vector) = (1,-0.3,0.06,5)
		[Header(Wind sea 12 short waves fanned round the wind)] _WindSea ("Wind Sea (x heading deg game azimuth, y spread deg, z steepness, w longest m)", Vector) = (70,75,0.085,7)
		_WindSeaShort ("Wind Sea Shortest (m)", Float) = 0.5
		_WaveFade ("Swell Fade (x start, y end, in wavelengths from the camera)", Vector) = (12,30,0,0)
		[Header(Chop)] [NoScaleOffset] [Normal] _NormalA ("Normal A (Water_NormalA)", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _NormalB ("Normal B (Water_NormalB)", 2D) = "bump" {}
		_Chop ("Chop (x tile A m, y tile B m, z strength A, w strength B)", Vector) = (2.6,0.85,0.9,0.7)
		_ChopFade ("Chop Fade (x start m, y end m, z far strength)", Vector) = (25,400,0.3,0)
		[Header(Colour)] _DeepColor ("Deep Colour", Vector) = (0.008,0.05,0.085,1)
		_ShallowColor ("Shallow Colour (reefs, white water)", Vector) = (0.05,0.32,0.33,1)
		_CrestColor ("Crest Light Colour (sun through the waves)", Vector) = (0.12,0.5,0.42,1)
		_CrestLight ("Crest Light (x strength, y view-to-sun exponent)", Vector) = (0.9,3,0,0)
		_Absorption ("Absorption (1/m, rgb)", Vector) = (1.6,0.7,0.55,0)
		_Refraction ("Refraction", Range(0, 0.15)) = 0.05
		[Header(Reflection)] _F0 ("Fresnel F0", Range(0, 0.2)) = 0.02
		_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 0.7
		_ReflectionTint ("Reflection Tint", Vector) = (1.05,0.95,0.88,1)
		_Roughness ("Roughness (x near, y far, z far distance m)", Vector) = (0.1,0.24,900,0)
		_SunSpecular ("Sun Path", Range(0, 6)) = 3
		_Glitter ("Glitter (x strength, y roughness, z chop bend, w reach m)", Vector) = (5,0.11,4,300)
		_LampGlint ("Lamp On The Sea (x roughness, y strength, z falloff 1/m2, w foam light)", Vector) = (0.3,2.5,0.0015,0.06)
		[Header(Foam)] [NoScaleOffset] _FoamTex ("Foam (Water_Foam)", 2D) = "black" {}
		_FoamColor ("Foam Colour", Vector) = (0.97,0.96,0.94,1)
		_FoamTile ("Foam Tile (m)", Float) = 2.2
		[NoScaleOffset] _ShoreTex ("Shore Field (R distance m, G bed depth m)", 2D) = "black" {}
		_ShoreRect ("Shore Field Rect (x minX, y minZ, z 1/width, w 1/depth)", Vector) = (-24,-26,0.0208,0.0192)
		_Shore ("Shore Foam (x reach m, y band spacing m, z band speed, w amount)", Vector) = (0.95,1.5,0.45,1.6)
		_Surf ("Reef Surf (x depth from m, y depth to m, z amount, w aerated tint)", Vector) = (0.2,1.1,0.9,0.7)
		_CrestFoam ("Whitecaps (x threshold, y softness, z amount)", Vector) = (0.18,0.12,0.9,0)
		[Header(Distance)] _FogScale ("Fog On The Sea", Range(0, 1)) = 0.6
		[Enum(Off,0,Reflection,1,Fresnel,2,Body,3,Normal,4,Shore,5,Foam,6)] _DebugView ("Debug View", Float) = 0
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