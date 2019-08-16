# Collision Detection
Assertions:
 - All hitboxes will be Area2D
 - All entities only have one hurtbox
 - All hitboxes will have associated meta data with entity references and damage descriptors

Scene with the hurtbox listens to area_entered relays that back to the level scene.

On-ready phase of entities will grab references to hitboxes (may be multiples per attack type)
and set any meta and values onto the hitbox object.

Listening to hurtbox area-entered via signals.  The signal handler will do the following:

The function of damage is done by listening to hurtbox intersections (signals) and detecting
the source of the damage.

1) Unpack source reference.  Unpack damage descriptors.
2) In the hurtbox context grab the "target" entity reference
3) Call target.take_damage() with source and damage descriptors
