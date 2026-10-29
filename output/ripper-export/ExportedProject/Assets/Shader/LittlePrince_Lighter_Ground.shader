Shader "LittlePrince/Lighter/Ground" {
	Properties {
		[NoScaleOffset] _StoneMap ("Rock", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _StoneNormal ("Rock normal", 2D) = "bump" {}
		[NoScaleOffset] [Normal] _DetailNormal ("Rock grain normal", 2D) = "bump" {}
		[NoScaleOffset] _GritMap ("Grit and soil", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _GritNormal ("Grit normal", 2D) = "bump" {}
		[NoScaleOffset] _TurfMap ("Turf", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _TurfNormal ("Turf normal", 2D) = "bump" {}
		_TurfTint ("Turf tint", Vector) = (1,1,1,1)
		_Turf ("Turf (tile 1/m, cover, patch freq 1/m, rock share)", Vector) = (0.7,1,0.45,0.35)
		_StoneTint ("Rock tint A", Vector) = (1.36,1.37,1.56,1)
		_StoneTintB ("Rock tint B", Vector) = (1.3,1.34,1.56,1)
		_StoneScales ("Rock (tile 1/m, weathering 1/m, normal, desaturate)", Vector) = (1,0.11,1,0.85)
		_Cracks ("Cracks (freq 1/m, width, share, darkness)", Vector) = (0.32,0.008,0.3,0.3)
		_Detail ("Grain (normal tile 1/m, normal strength, patch contrast, patch scale 1/m)", Vector) = (3.3,0.5,0.25,0.6)
		_Plates ("Crust slabs (size m, crack half width m, rim bevel m, rim slope)", Vector) = (1,0.007,0.03,1)
		_PlateLook ("Crust look (plate tilt, tone variation, crack darkness, crack warp)", Vector) = (0.08,0.12,0.7,0.6)
		_Crust ("Crust breakage (mask freq 1/m, small piece m, raised slab share, step slope)", Vector) = (0.22,0.24,0.28,3)
		_Flakes ("Crust flakes (size m, tilt, tone variation, chipped edge share)", Vector) = (0.07,0.22,0.1,0.65)
		_Pebbles ("Pebbles (cell m, share on plates, grit cell m, grit share in cracks)", Vector) = (0.14,0.1,0.035,0.45)
		_SoilTint ("Foot soil tint", Vector) = (0.5,0.47,0.45,1)
		_PathTint ("Path tint", Vector) = (1.12,1.12,1.16,1)
		_Shape ("Shape (x foot darken, y lip lighten, z path grit, w grit tile 1/m)", Vector) = (0.3,0.14,0.4,1.4)
		_Surface ("Surface (x rock smoothness, y path smoothness, z rim darken, w path verge darken)", Vector) = (0.16,0.24,0.08,0)
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