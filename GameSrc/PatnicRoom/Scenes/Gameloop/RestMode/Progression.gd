extends Node2D

var background 
var inputmode
var station

var kitSelection 
var stationManager



func _init() :
	Gameloop.scene = self
	API_009_Sound.buildSceneReference()
	API_009_Sound.playEnterPanicRoom()
	Davinci.initialiceRestScene(self)


func _input(event: InputEvent) -> void: Davinci.manageInput(event)


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("background").texture = Utils.rng().getBackground("rest")
	

func changeSwitchPanel(filepathOfScene:String) -> void:
	get_node("SwitchPanel").get_child(0).free()
	var node = load(filepathOfScene)
	get_node("SwitchPanel").add_child(node.instance())
