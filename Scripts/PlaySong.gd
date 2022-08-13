extends Spatial

#instanced note art/animation for each note from song
var note = preload("res://Scenes/NoteLabel.tscn")


#array of coords for fret numbers
var fret_coords = [-5.0, -4.6, -4.2, -3.8, -3.4, 
-3.0, -2.6, -2.2,-1.8, -1.4, -1.0, -.6, -.2, .2, .6,
 1.0, 1.4, 1.8, 2.2, 2.6, 3.0, 3.4, 3.8, 4.2, 4.6]


#array of coords for string numbers
var string_coords = [-.5, -.3, -.1, .1, .3, .5]

#track starting point for elapsed time
var start_time


var latency = 0.0
var currentNote = 0


#???
var time = 0.0

var actualNoteArray = []
var actualTimeArray = []
var actualStringArray = []

#WIP
var actualChordTimeArray = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	time = $AudioStreamPlayer.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time += AudioServer.get_output_latency()
	#print("Time is: ", time)
	
	time = time / 60000 
	#time = time + _delta/60000
	if time > 0.0025:
		# 0.003 was good but lagged at the end
		#time = time - 0.003
		time = fmod(time, 0.0025)
	
	#if range(actualTimeArray.size()).has(currentNote):
	if currentNote > 1:
		if start_time != null:
			latency = (Time.get_ticks_msec() / 1000.0 + actualTimeArray[currentNote]) - (start_time / 1000.0 + actualTimeArray[currentNote])
			latency = latency / 60000 + time
			latency = time
			#latency = 0
			#print(latency)
			#print(time)
	pass


func _on_Button_pressed():
	parse_xml_charts_with_regex()
	test_song()
	print(actualChordTimeArray)
	#var newNote = note.instance()
	#add_child(newNote)
	#newNote.translation = Vector3(3, -.3, 0)
	#newNote.get_child(0).get_child(0).play("FallingAnimation")
	pass # Replace with function body.

func test_song():
	#in this version, just use this array
	#in ACTUAL version, reference premade array 
	#var actualNoteArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]
	#var actualTimeArray = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6]
	#var timelol = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
	
	#todo map out transform coords for each and every
	#and string location
	#all 144 of them and save it in an array?
	
	#start_time = OS.get_ticks_msec()
	
	for i in actualNoteArray.size():
		
		currentNote = i
		
		#create instance of "falling note" scene
		#and add it to scene 
		#idk if this needs to be done before it gets modified
		var newNote = note.instance()
		#add_child(newNote)
		
		#map fret's locations from data
		if actualNoteArray[i] == 0:
			newNote.translation.x = fret_coords[0]
		elif actualNoteArray[i] == 1:
			newNote.translation.x = fret_coords[1]
		elif actualNoteArray[i] == 2:
			newNote.translation.x = fret_coords[2]
		elif actualNoteArray[i] == 3:
			newNote.translation.x = fret_coords[3]
		elif actualNoteArray[i] == 4:
			newNote.translation.x = fret_coords[4]
		elif actualNoteArray[i] == 5:
			newNote.translation.x = fret_coords[5]
		elif actualNoteArray[i] == 6:
			newNote.translation.x = fret_coords[6]
		elif actualNoteArray[i] == 7:
			newNote.translation.x = fret_coords[7]
		elif actualNoteArray[i] == 8:
			newNote.translation.x = fret_coords[8]
		elif actualNoteArray[i] == 9:
			newNote.translation.x = fret_coords[9]
		elif actualNoteArray[i] == 10:
			newNote.translation.x = fret_coords[10]
		elif actualNoteArray[i] == 11:
			newNote.translation.x = fret_coords[11]
		elif actualNoteArray[i] == 12:
			newNote.translation.x = fret_coords[12]
		elif actualNoteArray[i] == 13:
			newNote.translation.x = fret_coords[13]
		elif actualNoteArray[i] == 14:
			newNote.translation.x = fret_coords[14]
		elif actualNoteArray[i] == 15:
			newNote.translation.x = fret_coords[15]
		elif actualNoteArray[i] == 16:
			newNote.translation.x = fret_coords[16]
		elif actualNoteArray[i] == 17:
			newNote.translation.x = fret_coords[17]
		elif actualNoteArray[i] == 18:
			newNote.translation.x = fret_coords[18]
		elif actualNoteArray[i] == 19:
			newNote.translation.x = fret_coords[19]
		elif actualNoteArray[i] == 20:
			newNote.translation.x = fret_coords[20]
		elif actualNoteArray[i] == 21:
			newNote.translation.x = fret_coords[21]
		elif actualNoteArray[i] == 22:
			newNote.translation.x = fret_coords[22]
		elif actualNoteArray[i] == 23:
			newNote.translation.x = fret_coords[23]
		elif actualNoteArray[i] == 24:
			newNote.translation.x = fret_coords[24]
		
		#map string's location from data
		if actualStringArray[i] == 0:
			newNote.translation.y = string_coords[0]
			newNote.get_child(0).modulate = Color.red
			newNote.get_child(0).get_child(1).outline_modulate = Color.red
		elif actualStringArray[i] == 1:
			newNote.translation.y = string_coords[1]
			newNote.get_child(0).modulate = Color.yellow
			newNote.get_child(0).get_child(1).outline_modulate = Color.yellow
		elif actualStringArray[i] == 2:
			newNote.translation.y = string_coords[2]
			newNote.get_child(0).modulate = Color.cornflower
			newNote.get_child(0).get_child(1).outline_modulate = Color.cornflower
		elif actualStringArray[i] == 3:
			newNote.translation.y = string_coords[3]
			newNote.get_child(0).modulate = Color.orangered
			newNote.get_child(0).get_child(1).outline_modulate = Color.orangered
		elif actualStringArray[i] == 4:
			newNote.translation.y = string_coords[4]
			newNote.get_child(0).modulate = Color.green
			newNote.get_child(0).get_child(1).outline_modulate = Color.green
		elif actualStringArray[i] == 5:
			newNote.translation.y = string_coords[5]
			newNote.get_child(0).modulate = Color.orchid
			newNote.get_child(0).get_child(1).outline_modulate = Color.orchid
		
		
		newNote.get_child(0).set_text(str(actualNoteArray[i]))
		
		
		
		#TODO fix the thing that this is supposed to fix but doesnt
		# when the last note is made, it says "invalid get index '3163' (on base: 'Array')
		#even though i thought this would detect if it is null and stop
		if actualTimeArray[i] != null:
			if i == 0:
				yield(get_tree().create_timer(actualTimeArray[i]), "timeout")
			else:
				# TODO suppress error with the last field in ActualTimeArray
				# it says that the field is null and crashes
				var targetTime = actualTimeArray[i] - actualTimeArray[i - 1]
				yield(get_tree().create_timer(targetTime - latency), "timeout")
		
		#print(time)
		add_child(newNote)
		
		
		if !($AudioStreamPlayer.playing):
			start_time = Time.get_ticks_msec()
			$AudioStreamPlayer.play()	
		
		
		
		newNote.get_child(0).get_child(0).play("FallingAnimation")
		
		
func parse_xml_charts_with_regex():
	
	# WARNING: I DON'T KNOW REGEX
	
	var file = File.new()
	file.open("res://Songcharts/btbamwhitewallsalb11_lead.xml", 1)
	
	
	var regex = RegEx.new()
	#var try1 = "/(?<=fret=\")(.*)(?=\")/"
	#var try2 = "/(?=fret=\") *(?=\")"
	#this kinda works for getting fret
	#jk it doesnt
	#var try3 = "(?<=fret=\")(.\\d)"
	#this works for getting between 14 and 15
	# escape sequences were on [\s\S] part
	
	#regex101 appends the "g
	# idk if it needs that
	# it doesnt need it
	
	# below is for the poorly made chart "sfumato" where it has 16 difficulty groupings?
	# im sticking with the one farther below called "try4"
	# because idk why a single non dynamic difficulty char needs 16 difficulties
	
	#var try4 = "(?=level difficulty=\"14\")[\\s\\S]*(?=level difficulty=\"15\")"
	var try4 = "(?=level difficulty=\"0\")[\\s\\S]*(?=</level>)"
	
	
	
	regex.compile(try4)
	
	var wholeDoc = file.get_as_text()
	#print(wholeDoc)
	var sectionOfDoc = regex.search(wholeDoc).get_string()
	#print(sectionOfDoc)
	
	# i am a god
	# oh nooooooooooooooooooooooooooooo
	# now i am a god
	
	#escape sequence is on the \d => \\d
	#i hate this
	# GET FRETS
	#-----------------------------------------------
	#var try5 = "(?<=fret=\")\\d*(?=\")"
	# so this picks up the "unwanted" anchor fret values
	# which only imply behaviour changes to existing notes
	# so ima instead use one of the other catagories to 
	# get the "total" notes
	var try5 = "(?<=fret=\")(.*?)(?=\")"
	
	regex.compile(try5)
	var test = regex.search(sectionOfDoc)
	
	#ty reddit
	#https://www.reddit.com/r/godot/comments/6jxdw5/in_godot_30_how_to_get_subsequent_matches_from/
	
	while test != null:
		#print(test.get_string(0))
		actualNoteArray.append(int(test.get_string(0)))
		test = regex.search(sectionOfDoc, test.get_end(0))
	
	# GET NOTES
	#---------------------------------------------------------------
	#var try6 = "(?<=note time=\")\\d*(?=\")"
	#var try6 = "(?<=note time=\")[\\s\\S]*(?=\")"
	
	#the ".*?" means lazy which will get the shortest fitting match
	#before i was doing the aggressive which grabbed the longest fitting match
	#ie. everything in the page up until the last double quote
	var try6 = "(?<=note time=\")(.*?)(?=\")"
	
	regex.compile(try6)
	var test2 = regex.search(sectionOfDoc)
	
	while test2 != null:
		#print(test2.get_string(0))
		actualTimeArray.append(float(test2.get_string(0)))
		test2 = regex.search(sectionOfDoc, test2.get_end(0))
		
	# GET STRINGS
	#--------------------------------------------------------
	var try7 = "(?<=string=\")\\d*(?=\")"
	
	regex.compile(try7)
	var test3 = regex.search(sectionOfDoc)
	
	while test3 != null:
		#print(test3.get_string(0))
		actualStringArray.append(int(test3.get_string(0)))
		test3 = regex.search(sectionOfDoc, test3.get_end(0))
		
	# GRABS CHORD TIME VARIABLE OF TYPE FLOAT
	# =====================================
	# actual regex is (?<=chord time=\")(.*?)(?=\")
	# the one below will probably have confusing literal keywords that are for gdscript
	var try8 = "(?<=chord time=\")(.*?)(?=\")"
	
	regex.compile(try8)
	var test4 = regex.search(sectionOfDoc)
	
	while test4 != null:
		#i dont remember what this line does
		print(test4.get_string(0))
		actualChordTimeArray.append(int(test4.get_string(0)))
		test4 = regex.search(sectionOfDoc, test4.get_end(0))
		
		#todo make variable for chord information
		# and figure out what chord information i need to collect
		
	#next up is the chord ID number, as well as the chord templates
	#the chord templates need to be ordered as received, and also referenced
	#by the order it is listed, instead of having an "ID" that is unique
	#which is dumb that they dont have that
	#like some of them are listed Cb5 or something
	#but a lot of them have blank fields
	#and its really dumb 
	
	#actual regex is (?<=chordId=")(.*?)(?=")
	# "\" makes the next character a literal
	var test9 = "(?<=chordId=\")(.*?)(?=\")"
	
	#the variable that holds chords notes is unique
	#so im just grabbing all 6 variables for each string
	#fret0 - fret 5
	#if the value is "-1", then it is an open string 
	#actual regex for this is as follows:
	# (?<=fret0=")(.*?)(?=")
	# (?<=fret1=")(.*?)(?=")
	# (?<=fret2=")(.*?)(?=")
	# (?<=fret3=")(.*?)(?=")
	# (?<=fret4=")(.*?)(?=")
	# (?<=fret5=")(.*?)(?=")
	pass

