extends Control


@export var RessourceListVBox: VBoxContainer
@export var CraftingButtonsVBox: VBoxContainer

@onready var Units: Array[UnitData] = UnitData.getDefaultUnits()
@onready var Ressources: Array[RessourceData] = RessourceData.getDefaultRessources()

# It's here to keep track which button corresponds to which unit
var buttonMap: Dictionary 

func updateRessources():
	# Mass execution of children
	for child in RessourceListVBox.get_children():
		RessourceListVBox.remove_child(child)
	
	for k in Global.playerRessources:
		var label = Label.new()
		label.text = k + ": " + str(Global.playerRessources[k])
		RessourceListVBox.add_child(label)


func canCraft(unit: UnitData) -> bool:
	for k in unit.prices:
		if k not in Global.playerRessources:
			return false
		if Global.playerRessources[k] < unit.prices[k]:
			return false
	return true

func expendCraft(unit: UnitData) -> void:
	for k in unit.prices:
		Global.playerRessources[k] -= unit.prices[k]

func tryCraft(button: Button):
	var unit = buttonMap[button]
	if canCraft(unit):
		Global.playerUnit = unit as UnitData
		expendCraft(unit)

func _ready():
	for ressource in Ressources:
		Global.playerRessources[ressource.uniqueName] = 0
		
	for unit in Units:
		var button = Button.new()
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.text = unit.uniqueName + "\n"
		for k in unit.prices:
			button.text += k + ": " + str(unit.prices[k]) + "\n"
			
		button.pressed.connect(func():
			tryCraft(button)
		)
		buttonMap[button] = unit
		
		CraftingButtonsVBox.add_child(button)


func _process(delta):
	updateRessources()
