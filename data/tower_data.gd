class_name Towers extends Resource

enum Type {ARCHER, POISON, LIGHTNING, ICE, SLIME}
enum DataType {SCENE, COST, WIDTH, SPRITE, NAME}

const ICE_TURRET = preload("uid://cv13uq7diugin")
const SPR_TOWER_ICE_WIZARD = preload("uid://kr5x5qxgcp6l")
const ARCHER_TURRET = preload("uid://tmht4gutufgl")
const SPR_TOWER_ARCHER = preload("uid://bcotwe2k8grdn")
const LIGHTNING_TURRET = preload("uid://c7ec65aq7g0h")
const SPR_TOWER_LIGHTNING_TOWER = preload("uid://b47kiy5m3rwui")
const POISON_TURRET = preload("uid://cuouveka0gf80")
const SPR_TOWER_POISON_WIZARD = preload("uid://mff3pak1iokh")
const SLIME_ENEMY = preload("uid://d4em0ochsyyy1")
const SLIME_ICO = preload("uid://dyigttfk5ho1m")

const SPR_TOWER_CANNON = preload("uid://cdiwy2e8g3vc6")
const SPR_TOWER_CROSSBOW = preload("uid://bwlaw6gqaina")

# type : scene, cost, width, sprite, name
var data : Dictionary = {
	Type.ARCHER : [ARCHER_TURRET, 15, 6, SPR_TOWER_ARCHER, "Archer"],
	Type.ICE : [ICE_TURRET, 20, 6, SPR_TOWER_ICE_WIZARD, "Ice"],
	Type.POISON : [POISON_TURRET, 25, 6, SPR_TOWER_POISON_WIZARD, "Poison"],
	Type.LIGHTNING : [LIGHTNING_TURRET, 30, 8, SPR_TOWER_LIGHTNING_TOWER, "Lightning"],
	Type.SLIME : [SLIME_ENEMY, 0, 0, SLIME_ICO, "Slime"],
}
