Shader "B612/Sky" {
	Properties {
		[KeywordEnum(Panorama, Cards, Hdri, HdriMotion)] _Clouds ("Cloud Mode", Float) = 0
		[Header(HDRI Motion clouds)] [NoScaleOffset] _SkyCloudDay ("Day Clouds (premultiplied HDR, elevation 0..90)", 2D) = "black" {}
		[NoScaleOffset] _SkyCloudDayAlpha ("Day Cloud Coverage (R)", 2D) = "black" {}
		[NoScaleOffset] _SkyCloudDusk ("Dusk Clouds (premultiplied HDR, elevation 0..90)", 2D) = "black" {}
		[NoScaleOffset] _SkyCloudDuskAlpha ("Dusk Cloud Coverage (R)", 2D) = "black" {}
		[NoScaleOffset] _SkyCloudRingDay ("Day Cloud Horizon Ring (512x1, rgb premult, a coverage)", 2D) = "black" {}
		[NoScaleOffset] _SkyCloudRingDusk ("Dusk Cloud Horizon Ring (512x1)", 2D) = "black" {}
		_CloudHeight ("Cloud Plane Height (m)", Float) = 1500
		_CloudWindSpeed ("Cloud Wind Speed (m/s, along the global wind)", Float) = 7
		_CloudFlowPeriod ("Flow Period (s)", Float) = 40
		_CloudFlowFade ("Flow Crossfade (share of the period)", Range(0.05, 0.5)) = 0.25
		_CloudFlowNoise ("Flow Phase Noise Scale (m)", Float) = 4000
		_CloudDamp ("Drift Damping (x none below, y full above, deg)", Vector) = (1.5,7,0,0)
		_CloudHorizonFade ("Cloud Horizon Fade (x start, y full, deg)", Vector) = (0.3,3,0,0)
		_CloudHaze ("Cloud Haze Toward The Horizon", Range(0, 1)) = 0.25
		_DayCloudWarm ("Day Clouds At Dusk (rgb tint ^dusk, a brightness)", Vector) = (1.1,0.86,0.66,0.7)
		_SunFlatten ("Sun Disk Flattening At The Horizon", Range(0, 0.4)) = 0.22
		_CloudRelight ("Day Relight: brightness vs angle to the sun (x floor, y peak, z width deg, w de-yellow)", Vector) = (0.55,5.3,16,0.35)
		_CloudSilver ("Day Silver Lining (x strength, y width deg); z cloud-core luminance for the photo-sun repair", Vector) = (0.5,7,1,0)
		_CloudEvolution ("Evolution (x size m, y period s); edge softness of the rigid flow (z overhead, w near the horizon)", Vector) = (2600,140,1.8,3.2)
		_CloudViewGrad ("Cloud LOD From The View Ray (0 = off; > 0 = on, value = extra blur, 1 = none)", Float) = 0
		_PhotoCloudCut ("Photo Cloud Cut (x day layer, y dusk layer, z extra dusk cut at the horizon, w its fade elev deg; 0 = off)", Vector) = (0,0,0,12)
		[Header(High cirrus veil (procedural, Hdri Motion))] _Cirrus ("Cirrus (x opacity, 0 = off; y scale 1/m on the plane; z streak stretch; w drift)", Vector) = (0,0.0006,6,0.02)
		_CirrusShape ("Cirrus Shape (x cover from, y cover to, z sun forward, w sky brightness)", Vector) = (0.5,0.82,0.35,1.25)
		_CirrusTint ("Cirrus Tint (rgb)", Vector) = (1,1,1,0)
		[Header(Sun disk and rays)] _SunLimb ("Sun Disk (x limb darkening, y edge softness share, z bloom core, w bloom exponent)", Vector) = (0,0.15,0,900)
		_Rays ("Crepuscular Rays (x strength, y count, z sharpness, w reach deg)", Vector) = (0,34,3,28)
		_RaysColor ("Rays Colour (rgb, a max sun elevation deg)", Vector) = (1,0.72,0.45,12)
		_DuskSun ("Dusk Sun (x strength, y halo strength, z halo width deg, w max sun el deg; 0 = off)", Vector) = (0,1,5,3)
		_DuskSunColor ("Dusk Sun Disk (rgb HDR, after exposure)", Vector) = (2.2,1,0.3,0)
		_DuskHaloColor ("Dusk Halo (rgb HDR, after exposure)", Vector) = (1,0.42,0.14,0)
		[Header(Night sky day night loop)] _StarBrightness ("Star Brightness", Float) = 2
		_StarSize ("Star Radius (deg)", Float) = 0.03
		_StarDensity ("Star Density (x bright layer, y faint layer, z faint boost in the Milky Way)", Vector) = (0.1,0.07,3,0)
		_StarTwinkle ("Star Twinkle", Range(0, 1)) = 0.2
		_StarHorizon ("Star Fade Near The Horizon (deg)", Float) = 14
		_MilkyWay ("Milky Way (rgb colour, a half width)", Vector) = (0.012,0.015,0.022,0.13)
		_MilkyWayPole ("Milky Way Pole (star frame)", Vector) = (0.36,-0.52,0.77,0)
		_MoonColor ("Moon Disc (rgb radiance, a radius deg)", Vector) = (1,0.98,0.92,1.3)
		_MoonHalo ("Moon Halo (x tight, y tight exponent, z wide, w wide exponent)", Vector) = (0.1,700,0.03,16)
		_MoonHaloColor ("Moon Halo Colour (rgb), a moonlit cloud edges", Vector) = (0.55,0.66,0.9,0.6)
		[Header(HDRI sky)] [NoScaleOffset] _SkyHdriDay ("Day Sky (HDR equirect, elevation 0..90)", 2D) = "black" {}
		[NoScaleOffset] _SkyHdriDusk ("Dusk Sky (HDR equirect, elevation 0..90)", 2D) = "black" {}
		[NoScaleOffset] _SkyHdriRingDay ("Day Horizon Ring (512x1)", 2D) = "black" {}
		[NoScaleOffset] _SkyHdriRingDusk ("Dusk Horizon Ring (512x1)", 2D) = "black" {}
		_HdriLatMin ("Panorama Bottom Latitude (deg)", Float) = 0
		_HdriBlend ("Horizon Blend (x photo starts, y photo full, deg)", Vector) = (0.3,4.5,0,0)
		_HdriRingElevation ("Ring Elevation For Grading (deg)", Float) = 2.5
		_HdriDrift ("Sunset Yaw Drift (deg over the transition)", Float) = 6
		_HdriGroundBlend ("Ground Blend Below Horizon (deg)", Float) = 4
		_DayExposure ("Day Exposure", Float) = 2
		_DayTint ("Day Tint (rgb multiplier)", Vector) = (1,1,1,0)
		_DaySaturation ("Day Saturation", Range(0, 2.5)) = 1.2
		_DayHorizon ("Day Horizon Multiplier (rgb)", Vector) = (1,1,1,0)
		_DayHorizonRange ("Day Horizon Range (deg)", Float) = 20
		_DayZenith ("Day Zenith Multiplier (rgb)", Vector) = (1,1,1,0)
		_DayZenithStart ("Day Zenith Start (deg)", Float) = 30
		_DayYaw ("Day Yaw (deg, clockwise)", Float) = 0
		_DaySunDisk ("Day Sun Disk Scale", Float) = 1
		_DayHalo ("Day Halo Scale", Float) = 0.4
		_DayKnee ("Day Highlight Knee (x threshold, y range; y 0 = off)", Vector) = (2,0,0,0)
		_DaySunDim ("Day Circumsolar Dim (x strength, y exponent, z sun az, w sun el)", Vector) = (0,8,80,43)
		_DuskExposure ("Dusk Exposure", Float) = 0.5
		_DuskTint ("Dusk Tint (rgb multiplier)", Vector) = (1,1,1,0)
		_DuskSaturation ("Dusk Saturation", Range(0, 2.5)) = 1.1
		_DuskHorizon ("Dusk Horizon Multiplier (rgb)", Vector) = (1,1,1,0)
		_DuskHorizonRange ("Dusk Horizon Range (deg)", Float) = 15
		_DuskZenith ("Dusk Zenith Multiplier (rgb)", Vector) = (1,1,1,0)
		_DuskZenithStart ("Dusk Zenith Start (deg)", Float) = 20
		_DuskYaw ("Dusk Yaw (deg, clockwise)", Float) = 0
		_DuskSunDisk ("Dusk Sun Disk Scale", Float) = 0.3
		_DuskHalo ("Dusk Halo Scale", Float) = 0.6
		_DuskKnee ("Dusk Highlight Knee (x threshold, y range; y 0 = off)", Vector) = (1.2,1.5,0,0)
		_DuskSunDim ("Dusk Circumsolar Dim (x strength, y exponent, z sun az, w sun el)", Vector) = (0,8,177,1.5)
		[Header(Panorama clouds)] [NoScaleOffset] _CloudPanoDay ("Day Radiance (RGB, premultiplied HDR)", 2D) = "black" {}
		[NoScaleOffset] _CloudPanoDusk ("Dusk Radiance (RGB, premultiplied HDR)", 2D) = "black" {}
		[NoScaleOffset] _CloudPanoAlpha ("Coverage (R)", 2D) = "black" {}
		_CloudPanoLatMin ("Panorama Bottom Latitude (deg)", Float) = -4
		_CloudPanoDayScale ("Day Radiance Scale", Float) = 1
		_CloudPanoDuskScale ("Dusk Radiance Scale", Float) = 1
		_CloudDriftPeriod ("Drift Period (s, back-and-forth)", Float) = 900
		_SunGlowOverClouds ("Sun Glow In Front Of Clouds", Range(0, 1)) = 0.45
		[Header(Cards clouds legacy)] [NoScaleOffset] _CumulusPos ("Cumulus Atlas Six-Way +", 2D) = "black" {}
		[NoScaleOffset] _CumulusNeg ("Cumulus Atlas Six-Way -", 2D) = "black" {}
		[NoScaleOffset] _BandPos ("Band Atlas Six-Way +", 2D) = "black" {}
		[NoScaleOffset] _BandNeg ("Band Atlas Six-Way -", 2D) = "black" {}
		_CloudSoftness ("Cloud Edge Softness", Range(0.5, 2)) = 1
		_CloudContrast ("Cloud Light Contrast", Range(0.5, 2)) = 1.15
		_SunOcclusionByClouds ("Sun Dimmed Behind Clouds", Range(0, 1)) = 0.85
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