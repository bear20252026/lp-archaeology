Shader "Desert/Footprint" {
	Properties {
		_Depth ("Depth (m)", Float) = 0.022
		_Relief ("Relief Strength", Range(0, 3)) = 1
		_Darken ("Compaction Darkening", Range(0, 0.5)) = 0.14
		_Rim ("Rim Height (x depth)", Range(0, 1)) = 0.35
		_Ambient ("Ambient vs Sun (flat ground)", Range(0.05, 3)) = 0.75
		_PrintSize ("Print Size (m): width, length", Vector) = (0.1,0.2,0,0)
		_Fade ("Distance Fade Start / End (m)", Vector) = (40,75,0,0)
		_ShadeDarken ("Extra darkening in shade (sky-occluded hollow)", Range(0, 0.6)) = 0.3
		_ShadeRim ("Rim lift in shade", Range(0, 0.3)) = 0.07
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