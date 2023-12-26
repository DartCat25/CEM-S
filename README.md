# CEM-S: Custom Entity Models with shaders

<img src="img/img0.png" height=200px>
<img src="img/pack.png" height=200px>

Pack adds primitive implementation of CEM on vanilla shaders.

It ables to render geometry in fragment as there is a way to TBN matrix in it, finally.

## Features
It applies features to add or change geometry of entities with done functions `ADD_BOX`, `ADD_BOX_ROTATE` and `ADD_SQUARE` but you can add any [intersector function](https://iquilezles.org/articles/intersectors/) or even other techniques like raymarching.

Model has no limits in size and rotations but you should consider that entity culling is still vanilla.

May be used on any mobs, block enities (like chests, beds, bells, etc.), armors, trims, arrows, tridents, etc.

# Implementation (WIP)
[Old implementation.](templates/impl.md)

To setup pack, copy `include` folder from this repository to your `minecraft/shaders/`.

Copy one of `templates` (there will be more templates and some of them may be same for some shaders) to `minecraft/shaders/core/`.

# Compatibility (DIDN'T TESTED)
Most example packs probably work in 1.18.2 and above (may cause vertex reordering issues, but it's fixable).

Code snippets probably may work in 1.17 and above.

Mods compatibility:
- [x] Sodium
- [ ] Iris
- [x] Optifine
- [ ] Optifine (shaders)

## Known Issues
- ~~Bobbing distortions (troubleshooting: switching out bobbing)~~ (fixed)
- ~~Weird depth when camera is in box~~ (seems to be fixed)
- Doesn't work in GUI

# Contributions, sources and licensing
https://iquilezles.org/articles/intersectors/