Shader "B612/CloudLayer" {
	Properties {
		[NoScaleOffset] _WeatherTex ("Weather (r coverage, g swell, b puffiness, a cell dome)", 2D) = "grey" {}
		[NoScaleOffset] _BaseNoise ("Base Noise 3D (r Perlin-Worley, gba Worley fBm)", 3D) = "grey" {}
		[NoScaleOffset] _DetailNoise ("Detail Noise 3D (rgb Worley fBm, a twist)", 3D) = "grey" {}
		[NoScaleOffset] _BlueNoise ("Blue Noise (R8, point, repeat)", 2D) = "grey" {}
		[Header(Layer shape)] _Layer ("Layer (x mean top y, y cap height m, z body ramp m, w swell amplitude m)", Vector) = (-28,12,4,4)
		_Weather ("Weather (x tile m, y wind m/s, z coverage bias, w coverage contrast)", Vector) = (2048,2.5,0.15,1)
		_Shape ("Shape (x base noise tile m, y detail tile m, z erosion, w density 1/m)", Vector) = (32,12,0.45,1.4)
		_ShapeB ("Shape B (x cell dome relief m, y thinning start smooth, z thinning start heaped, w crown carve m)", Vector) = (2,0.25,0,0)
		_HeapCarve ("Heaped Crown Carve Scale", Range(1, 3)) = 1
		_Breakup ("Open cloud lanes (x strength, y coverage clear, z coverage full, w body depth m)", Vector) = (0,0.4,0.68,10)
		_LaneMist ("Thin lower wisps in open lanes", Range(0, 0.1)) = 0
		_Airiness ("Broken banks (x broad coverage blend, y thin-edge density, z start m, w full m)", Vector) = (0.6,0.5,70,280)
		_BankLayout ("Broad banks (x scale, yz tile offset, w coverage centre)", Vector) = (0.35,0.471,0.173,0.54)
		_BaseYScale ("Base Shape Vertical Scale", Range(1, 2)) = 1
		_Structure ("Structure (x organic body blend, y shape warp m, z detailed sun shadow, w cap profile exponent)", Vector) = (0,0,0,0.65)
		_Motion ("Motion (x boil m/s, y detail speed x, z unused, w unused)", Vector) = (0.12,1.6,0,0)
		_Calm ("Calm Zone (xy planet centre xz, z inner radius m, w outer radius m)", Vector) = (0,0,32,80)
		_CalmShape ("Calm Shape (x top drop m, y puffiness x, z coverage floor, w cap height x)", Vector) = (3,0.85,0.5,0.85)
		_Flatten ("Far Flattening (x from m, y full at m, z cap height x, w swell / dome x) round the planet", Vector) = (350,1400,0.45,0.4)
		[Header(March)] _March ("March (x max steps, y min step m, z step per m, w max distance m)", Vector) = (96,0.35,0.007,2400)
		_MarchB ("March B (x far LOD from m, y detail within m, z empty step x, w opacity cutoff)", Vector) = (750,650,2.2,0.02)
		_LightMarch ("Light March (x steps near, y first step m, z growth, w density x)", Vector) = (6,0.8,1.9,1)
		_LightFar ("Light March Far (x steps far, y reuse light below transmittance, z in-cloud step growth, w growth max)", Vector) = (3,0.3,0.12,3)
		[Header(Planet shadow and horizon)] _PlanetShadow ("Planet Shadow Ellipsoid (x centre y, y radius xz, z radius y, w softness)", Vector) = (-6,26,15,0.12)
		_PlanetShadowB ("Planet Shadow (x strength)", Vector) = (0.75,0,0,0)
		_Band ("Horizon Band (x top deg, y power, z max alpha, w far deck line deg)", Vector) = (2.2,1.5,1,-0.85)
		_SunDisk ("Sun Disk At The Horizon (x scale, y deck line softness deg)", Vector) = (0.45,0.25,0,0)
		_DuskSun ("Dusk Sun (x strength, y halo strength, z halo width deg, w max sun el deg)", Vector) = (1,1,5,3)
		_DuskSunColor ("Dusk Sun Disk (HDR, exposed)", Vector) = (1.45,0.5,0.13,1)
		_DuskHaloColor ("Dusk Halo (HDR, exposed)", Vector) = (1,0.42,0.14,1)
		[Header(Temporal)] _Temporal ("Temporal (x history weight, y variance clip gamma, z depth reject, w history cubic blend)", Vector) = (0.9,1.25,0.12,0)
		[Enum(Off,0,Opacity,1,Steps,2,Distance,3,LightOD,4,Composite,5)] _DebugView ("Debug View", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)] _CompositeZTest ("Composite Depth Test (LessEqual: scenery hides the clouds)", Float) = 4
		[Header(Look defaults (overridden per frame by B612CloudLayer))] _LkSun ("Sun (x scale, y whiten, z albedo, w ambient scale)", Vector) = (1,0.5,0.95,1)
		_LkPhase ("Phase (x g forward, y g back, z forward weight, w clamp)", Vector) = (0.8,-0.25,0.6,10)
		_LkMS ("Multiple Scattering (x a, y b, z c, w powder)", Vector) = (0.5,0.45,0.6,0.5)
		_LkAmb ("Ambient (x trough sky visibility min, y bounce, z up occlusion, w bottom cool)", Vector) = (0.35,0.35,0.6,0.8)
		_LkHaze ("Haze (x density 1/m, y start m, z horizon fog from deg, w in-scatter)", Vector) = (0.0006,80,-2.6,0.35)
		_LkHaze2 ("Haze B (x in-scatter g, y low sun boost, z unused, w unused)", Vector) = (0.72,1,0,0)
		_LkGrade ("Dusk Grade (x strength)", Vector) = (0,0,0,0)
		_LkGold ("Dusk: toward the sun", Vector) = (1,0.74,0.42,1)
		_LkRose ("Dusk: lit broadside", Vector) = (1,0.6,0.62,1)
		_LkLav ("Dusk: shade", Vector) = (0.74,0.7,0.95,1)
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