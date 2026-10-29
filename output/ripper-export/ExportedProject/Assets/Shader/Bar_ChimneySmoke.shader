Shader "Bar/ChimneySmoke" {
	Properties {
		[NoScaleOffset] _Noise3D ("Noise 3D (R billows, G detail; tileable)", 3D) = "white" {}
		_PlumeShape ("Shape (x base radius m, y spread per m, z visible height m, w dilution power)", Vector) = (0.15,0.14,8,0.8)
		_PlumeFlow ("Flow (x rise m/s, y bend m^-0.5, z boil speed, w sway)", Vector) = (1.1,0.22,0.06,0.3)
		_NoiseScale ("Noise (x billow size m, y detail size m, z billow erosion low / high, w detail erosion)", Vector) = (1.2,0.35,0.45,0.55)
		_ErosionTop ("Billow Erosion At The Top", Range(0, 1)) = 0.8
		_Density ("Core Extinction (1/m)", Float) = 2.2
		_Albedo ("Albedo (rgb)", Vector) = (0.7,0.67,0.78,0)
		_Lighting ("Lighting (x sun, y ambient, z forward g, w multiple-scatter floor)", Vector) = (1,1,0.55,0.3)
		_Steps ("Ray Steps", Range(8, 64)) = 32
		_VentPos ("Vent (xyz world, w seed)", Vector) = (0,0,0,0)
		_PlumeWind ("Wind (xy unit dir in xz, z bend scale, w unused)", Vector) = (0.7071,0.7071,1,0)
		_PlumeGlow ("Vent Glow (rgb HDR, a height m)", Vector) = (0,0,0,1.8)
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