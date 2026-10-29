# Sky HDRI textures (B612/Sky, Cloud Mode = Hdri)

| File | Source (CC0, Poly Haven — free for any use, no attribution required) | Preparation |
| --- | --- | --- |
| `Sky_Hdri_Day.exr` (+ `_Ring`) | **Sunflowers (Pure Sky)** — https://polyhaven.com/a/sunflowers_puresky (8K .hdr) | sun core removed (drawn analytically), rotated so the photo's sun (u 0.6004, el 43.0°) sits at the game day sun azimuth 80°, upper hemisphere only |
| `Sky_Hdri_Dusk.exr` (+ `_Ring`) | **The Sky Is On Fire** — https://polyhaven.com/a/the_sky_is_on_fire (8K .hdr) | cleaned to a pure sky (buildings, Signal Hill / Lion's Head, lamp posts removed; `tools/b612/rendering/sky/clean_fire.py`), rotated so the post-sunset sun (u ≈ 0.66) sits at the game dusk azimuth 177°, upper hemisphere only |

Originals (unmodified, md5 in `scenes/b612/assets/sky/md5_expected.txt`): `ROOT/scenes/b612/assets/sky/`.

- Panorama convention (same as the v2 cloud panoramas): u = 0.5 + azimuth / 360 (centre column = north, east to the right),
  v = elevation / 90 (bottom row = horizon). 8192 × 2048, 22.8 px/deg. Import: BC6H, linear, mipmaps, wrap U repeat / V clamp.
- `_Ring` files: 512 × 1 horizon colour (elevation 1–4°, blurred ±4°) per azimuth; RGBAHalf, no mips. The sky fades its
  lowest degrees into it and the far haze (`B612_HorizonSkyColor`) uses it, so distant hills melt into the photo's horizon.
- Rebuild: `blender --background --factory-startup --python tools/b612/rendering/sky/prepare_hdri.py -- --src <hdr or cleaned exr> --game_az <deg> [--remove_sun 1] [--sun_u U --sun_el E] --out <this folder>/Sky_Hdri_<Name>.exr --report <json>`.
  To swap the dusk sky: prepare the new HDRI into `Sky_Hdri_Dusk.exr` (same name → same GUID, material keeps working) and tune
  the Dusk* grade on `Materials/Environment/M_B612_Sky_HDRI.mat`.
