extends Resource
class_name Space

enum SpaceType {
	PROPERTY,
	POT_LUCK,
	OPPORTUNITY_KNOCK,
	JAIL,
	FREE_PARKING,
	GO_TO_JAIL,
	TAX,
	GO
}

@export var name: String
@export var type: SpaceType
@export var property: Property = null
@export var playersOnSpace: Array = []
@export var next: Space = null
@export var bought: bool = false
