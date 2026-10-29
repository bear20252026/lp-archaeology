Shader "StarObservatory/Glass" {
	Properties {
		[Header(Glass)] _Tint ("Body Tint (rgb) and Base Opacity (a)", Vector) = (0.8,0.88,1,0.04)
		_Roughness ("Roughness (perceptual)", Range(0.01, 1)) = 0.06
		_F0 ("Reflectance at Normal Incidence", Range(0, 0.2)) = 0.04
		_FresnelMax ("Fresnel Maximum", Range(0.05, 1)) = 0.6
		_ReflectionStrength ("Reflection Strength", Range(0, 3)) = 1
		_SpecularStrength ("Additional Light Highlight Strength (lantern glints)", Range(0, 40)) = 6
		_MainSpecular ("Main Light (moon) Highlight Strength", Range(0, 10)) = 0.25
		_SpecularClamp ("Highlight Clamp (HDR)", Range(0.5, 20)) = 3
		_BodyLighting ("Body Lighting (diffuse on tint / dust)", Range(0, 2)) = 1
		_Sheen ("Cool Sheen (rgb, added; a = opacity)", Vector) = (0.01,0.014,0.022,0.02)
		[Header(Seen from outside)] _OutsideReflection ("Reflection x (viewer outside)", Range(0, 1)) = 0.35
		_OutsideSmudge ("Smudge / Dust x (viewer outside)", Range(0, 1)) = 0.35
		_InsideReflectMin ("Min Reflection (viewer inside: lit room mirrored at night)", Range(0, 0.5)) = 0
		[NoScaleOffset] _InteriorCube ("Interior Reflection Cubemap (baked interior probe)", Cube) = "black" {}
		_InteriorCubeBlend ("Room-side Reflection From The Interior Cube", Range(0, 1)) = 0
		_InteriorCubeMinMip ("Interior Cube Min Mip (blurs lamp dots)", Range(0, 6)) = 2.5
		_EnvClamp ("Reflection Clamp (max channel)", Range(0.2, 8)) = 1.2
		_InsideSpecClamp ("Highlight Cap Per Light, Viewer Inside (HDR)", Range(0.05, 20)) = 20
		_InsideSpecRough ("Highlight Min Roughness, Viewer Inside (soft glow, not a dot)", Range(0, 1)) = 0
		_InsideSpecular ("Lamp Highlights x (viewer inside)", Range(0, 1)) = 1
		_BuildingCentre ("Building Centre (world; decides which side the viewer is on)", Vector) = (0,2,0,0)
		[Header(Interior glow)] [HDR] _InteriorGlow ("Interior Glow Seen From Outside (HDR, added)", Vector) = (0,0,0,1)
		_GlowHeight ("Glow Height Range (x full at, y gone at; world y)", Vector) = (3.3,5.6,0,0)
		_GlowOpacity ("Glow Haze Opacity (viewer outside)", Range(0, 1)) = 0
		[Header(Pane edges and grain)] _EdgeWidth ("Pane Edge Width (UV0, 0 = off)", Range(0, 0.1)) = 0.018
		_EdgeStrength ("Pane Edge Reflection / Opacity", Range(0, 1)) = 0.45
		_GrainDensity ("Dust Grain Cells per UV", Range(10, 600)) = 220
		_GrainAmount ("Dust Grain Opacity", Range(0, 1)) = 0.25
		[Header(Smudge and dust)] _SmudgeMap ("Smudge (R) Dust (G) mask", 2D) = "black" {}
		_SmudgeRoughness ("Smudge Roughness", Range(0, 1)) = 0.25
		_SmudgeOpacity ("Smudge Opacity", Range(0, 1)) = 0.03
		_DustColor ("Dust Colour", Vector) = (0.62,0.58,0.52,1)
		_DustOpacity ("Dust Opacity", Range(0, 1)) = 0.15
		[Header(Stained glass)] [Toggle(_STAINED)] _Stained ("Stained Glass (backlit)", Float) = 0
		_BaseMap ("Stained Colour (rgb) and Coverage (a)", 2D) = "white" {}
		_BaseColor ("Stained Colour Tint", Vector) = (1,1,1,1)
		[NoScaleOffset] _EmissionMap ("Transmission Colour (rgb, black lead cames)", 2D) = "white" {}
		_UseTransmissionMap ("Use Transmission Map", Float) = 0
		_BaseBacklight ("Base Colour Share of the Backlight (with a transmission map)", Range(0, 2)) = 0.6
		_StainedOpacity ("Stained Opacity", Range(0, 1)) = 0.9
		[HDR] _BacklightOutside ("Backlight Seen From Outside", Vector) = (0.3,0.34,0.55,1)
		[HDR] _BacklightInside ("Backlight Seen From Inside", Vector) = (0.04,0.05,0.12,1)
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