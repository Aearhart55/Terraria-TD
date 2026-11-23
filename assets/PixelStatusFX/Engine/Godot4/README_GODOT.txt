Godot 4 SpriteFrames - one .tres per category (originals + mirrors).
1. Copy the whole 'PixelStatusFX' folder into your project root (res://PixelStatusFX/...). The .tres files use those paths.
   (Different location? Search & replace 'res://PixelStatusFX/' in the .tres files.)
2. Import settings for all PNGs: Texture > Filter = Nearest (Project Settings > Rendering > Textures > Default Texture Filter = Nearest), Mipmaps off.
3. AnimatedSprite2D > Sprite Frames = load the .tres, pick the animation, play(). Speeds = the fps in Data/fx_database.json.
4. Anchor: set AnimatedSprite2D.centered = false and offset = -anchor_px (from the database) so the node position is the anchor.
5. One-shot FX: connect animation_finished -> queue_free(). Use hit_frame (database) with frame_changed to apply damage.
6. Additive look: CanvasItemMaterial > Blend Mode = Add for rows whose blend column says 'additive look' (optional - they
   are drawn to look right with normal blending too).
