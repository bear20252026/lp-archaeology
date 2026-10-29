Shader "Bar/IslandGround" {
	Properties {
		[Header(Masks (world rectangles x0 x1 z0 z1))] [NoScaleOffset] _ZonesMap ("Zones (R paving, G grass, B dirt gravel, A moss)", 2D) = "black" {}
		_ZoneRect ("Zone rect", Vector) = (-9.795,16.30875,-9.47875,15.04625)
		[NoScaleOffset] _PavingMap ("Paving mask (R moss, G shade, B gravel)", 2D) = "black" {}
		_PavingRect ("Paving rect", Vector) = (-5.2,12.25,-7.4,8.25)
		[Header(Layers (world tile size in metres))] [NoScaleOffset] _DirtMap ("Dirt colour", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _DirtNormal ("Dirt normal", 2D) = "bump" {}
		[NoScaleOffset] _DirtMask ("Dirt mask (G AO, A smoothness)", 2D) = "white" {}
		_DirtTile ("Dirt tile", Float) = 1.3
		[NoScaleOffset] _DirtGravelMap ("Dirt gravel colour", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _DirtGravelNormal ("Dirt gravel normal", 2D) = "bump" {}
		[NoScaleOffset] _DirtGravelMask ("Dirt gravel mask", 2D) = "white" {}
		_DirtGravelTile ("Dirt gravel tile", Float) = 1
		[NoScaleOffset] _GrassMap ("Grass colour", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _GrassNormal ("Grass normal", 2D) = "bump" {}
		[NoScaleOffset] _GrassMask ("Grass mask", 2D) = "white" {}
		_GrassTile ("Grass tile", Float) = 2
		[NoScaleOffset] _MossMap ("Moss colour (scan)", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _MossNormal ("Moss normal", 2D) = "bump" {}
		_MossTile ("Moss tile", Float) = 1.55
		_ZoneMossStrength ("Zone moss strength", Range(0, 1)) = 0.8
		_SmoothMoss ("Moss smoothness", Range(0, 1)) = 0.06
		[Header(Joint bed under the cobbles)] [NoScaleOffset] _SandMap ("Joint sand colour", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _SandNormal ("Joint sand normal", 2D) = "bump" {}
		_SandTile ("Joint sand tile", Float) = 1
		[NoScaleOffset] _GravelMap ("Gravel colour (scan)", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _GravelNormal ("Gravel normal", 2D) = "bump" {}
		_GravelTile ("Gravel tile", Float) = 0.5
		_BedGravelThreshold ("Gravel in joints threshold", Range(0, 2)) = 0.75
		_GravelSoftness ("Gravel softness", Range(0.01, 1)) = 0.2
		_ShadeFloor ("Joint shade floor", Range(0, 1)) = 0.58
		_SmoothBed ("Joint smoothness", Range(0, 1)) = 0.13
		_EdgeSharpness ("Paving edge sharpness", Range(1, 6)) = 2
		_EdgeNoise ("Paving edge noise", Range(0, 2)) = 0.7
		_EdgeNoiseScale ("Paving edge noise scale (per m)", Float) = 1.4
		[Header(Far cobbles (cobble LODs culled))] [NoScaleOffset] _FarCobbleMap ("Cobble far colour", 2D) = "grey" {}
		[NoScaleOffset] [Normal] _FarCobbleNormal ("Cobble far normal", 2D) = "bump" {}
		[NoScaleOffset] _FarCobbleMask ("Cobble far mask", 2D) = "white" {}
		_FarTile ("Cobble far tile (m)", Float) = 1.5
		_FarStart ("Fade in from (m)", Float) = 17
		_FarEnd ("Full at (m)", Float) = 23
		_FarStrength ("Strength", Range(0, 1)) = 1
		[Header(Surface)] _NormalStrength ("Normal strength", Range(0, 2)) = 1
		_OcclusionStrength ("AO strength (masks G)", Range(0, 1)) = 1
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
	Fallback "Hidden/Universal Render Pipeline/FallbackError"
}