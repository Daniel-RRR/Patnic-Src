extends Component
class_name C_47_SYNONYM

var value

func _init(valuePara):
	name = "C_47_SYNONYM"
	value = valuePara



########################
# --- AUTODOC -------- #
########################
static func getAutoDoc(): return{
	"suggestion"  : "",
	"description" : "list of differnt names for this spcialication",
	"validInputs" : [],
	"validType"   : getType_quack(),
	"nameToShow"  : "synonyms",
}
static func getType_quack(): return "ARRAY"
