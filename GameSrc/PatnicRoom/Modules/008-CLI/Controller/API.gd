extends Node
# BOOKMARK[epic=Modules] 002_Tilemap_Structure                                 
# DOCS  > Docs\API\docs\Cogsmos\democrECS\SokraTILES.md                        
# DOCS  > TO ADD                                                               


# ----- INITIALICE --------------------------------------------------------- ##


var shallowCmdAtlas = {}
var groupedCmdAtlas = {}
var cmdsToString    = []
var activeCheats    = []

var commandSystem : _008_CommandSystem


func _ready() -> void:
	commandSystem = _008_CommandSystem.new()



# ----- GETTER ------------------------------------------------------------- ##


func getGroupedSyntax()         -> Dictionary :   return groupedCmdAtlas
func getMetaByInputKey(cmd)     -> Dictionary :   return shallowCmdAtlas[cmd]
func getAllCmdMeta()            -> Dictionary :   return shallowCmdAtlas


# ----- MAIN --------------------------------------------------------------- ##


func processCmdRaw(cmd:String,arrOfParameter:Array) -> void: 
	commandSystem.addTask(cmd,arrOfParameter)
	Signals.emit_signal("API_008_runCmds")

