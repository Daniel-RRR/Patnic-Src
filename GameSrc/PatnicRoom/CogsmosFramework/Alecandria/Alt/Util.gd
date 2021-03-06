extends Object
class_name _Alecandria_Parser_Util


const SECTOR_SEPARATOR  = "//==============================================================================\\\\"
const SECTOR_BEGIN     = "{"
const SECTOR_END       = "}"

const PACKAGE_SEPARATOR = "//------------------------------------------------------------------------------\\\\"
const PACKAGE_BEGIN     = "["
const PACKAGE_END       = "]"

const KEY_VALUE_SEPARATOR = "--->"


static func loadContent(filePath:String) -> Array :
	var file = File.new()
	file.open(filePath, File.READ)
	return file.get_as_text().split("\n") as Array
	file.close()



static func removeSeparators(content:Array,toReturn = []) -> Array:
	for line in content: 
		if ![SECTOR_SEPARATOR,PACKAGE_SEPARATOR].has(line):
			if !line.empty(): toReturn.append(line)
	return toReturn



static func scopeSector(content:Array) -> Dictionary:
	var currentMode   = "EMPTY"
	var scopedContent = {  "META":[] , "MAIN":[] , "REFERENCES":[]   }
	for line in content:
		if   currentMode == "EMPTY" : currentMode = line.rstrip(SECTOR_BEGIN)
		elif line == SECTOR_END     : currentMode = "EMPTY"
		else                        : scopedContent[currentMode].append(line.lstrip(" "))
	return scopedContent



static func buildMainStructure(content:Array,toReturn={}) -> Dictionary:
	for line in content: 
		var currentPackage = []
		if PACKAGE_BEGIN in line :  toReturn[line.rstrip(PACKAGE_BEGIN)] = [] 
		elif !PACKAGE_END in line :  
			currentPackage.append(line) ; 
			toReturn.values().back().append(line)
	return toReturn



static func buildMetaStructure(metaData:Array,toReturn={}) -> Dictionary:
	for line in metaData:
		var saniticedMeta = line.replace(" ","").split("--->")
		toReturn[saniticedMeta[0]] = saniticedMeta[1]
	return {   "C_12_ATLAS_INDEX":toReturn["INDEX"] , "C_72_LEC_META_USE":toReturn["USE"] , "C_71_LEC_META_BY":toReturn["BY"]   }



static func buildReferenceSector(metaData:Array,toReturn={}) -> Dictionary:
	return toReturn




static func getEntityByType(type:String) -> Entity :
	match type:
		"RACE"         : return Entity.new()
		"ROLE"         : return Entity.new()
		"SPECIALTY"    : return Entity.new()
		"KITPART_BASE" : return KitPartEntity.new() as Entity
		"KITPART_MOD"  : return KitPartEntity.new() as Entity
	return Entity.new()



static func getPackageParserByKeyWord() -> Dictionary:
	return{
		 "COMPONENTS" : _Alecandria_LecToEnt_PackageComponents
		,"FLAGS"      : _Alecandria_LecToEnt_PackageFlag
		,"PROPERTIES" : _Alecandria_LecToEnt_PackageProperties
		,"SELECT"     : _Alecandria_LecToEnt_PackageSelect
		,"RUN"        : _Alecandria_LecToEnt_PackageRun
		,"TABLE"      : _Alecandria_LecToEnt_PackageTable
		,"UPGRADE"    : _Alecandria_LecToEnt_PackageUpgrade
	} 















static func addToAtlas(ent):
	if isValid(ent):
			
			match ent.getCompValue("C_72_LEC_META_USE"):
				"KITPART_BASE"      : API_001_Atlas.KitParts().addEntity(ent)
				"KITPART_MOD"       : API_001_Atlas.KitParts().addEntity(ent)
				"ACTOR_ROLE"        : API_001_Atlas.Role().addEntity(ent)
				"ACTOR_RACE"        : API_001_Atlas.Race().addEntity(ent)
				"ACTOR_SPECIALTY"   : API_001_Atlas.Specialties().addEntity(ent)



static func isValid(ent):
	for compToString in ENUM.LEC.TYPES_METADATA[ent.getCompValue("C_72_LEC_META_USE")]["MANDATORY"]: 
		if !ent.hasComp(compToString): 
			printerr("not all mandatory Components in Dictionary for Parsing to Entity! Missing: "+compToString)
			return false
	return true

