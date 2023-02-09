extends Spatial

#instanced note art/animation for each note from song
var note = preload("res://Scenes/NoteLabel.tscn")


var hardcodedSongChartPath = "res://Songcharts/btbamwhitewallsalb11_lead.xml"
var hardcodedSongAudioPath = "res://SongAudio/song_btbamwhitewallsalb11_fixed.ogg"
var hardcodedAALSongPath = "res://SongCharts/cusaalpointtopoint_lead.xml"
var hardcodedAALAudioPath = "res://SongAudio/song_cusaalpointtopoint_fixed.ogg"

var currentSong = hardcodedSongAudioPath
var currentChart = hardcodedSongChartPath

#array of coords for fret numbers
var fret_coords = [-5.0, -4.6, -4.2, -3.8, -3.4, 
-3.0, -2.6, -2.2,-1.8, -1.4, -1.0, -.6, -.2, .2, .6,
 1.0, 1.4, 1.8, 2.2, 2.6, 3.0, 3.4, 3.8, 4.2, 4.6]



#array of coords for string numbers
var string_coords = [-.5, -.3, -.1, .1, .3, .5]

#track starting point for elapsed time
var start_time

var chord_start_time


var latency = 0.0
var currentNote = 0
var globalDelta = 0.0


#???
var time = 0.0

var actualNoteArray = []
var actualTimeArray = []
var actualStringArray = []

#WIP
var actualChordTimeArray = []
var actualChordIDArray = []

var actualChordLowEstring = []
var actualChordAstring = []
var actualChordDstring = []
var actualChordGstring = []
var actualChordBstring = []
var actualChordHighEstring = []

var noteNodeArray = []

#testing for debug related crashes
var array500 = []
var array1000 = []
var array1500 = []
var array2000 = []
var array2500 = []
var array3000 = []
var array3500 = []

var chordNodeArray = []

var timeToNextMix

var previousNoteTime


# Called when the node enters the scene tree for the first time.
func _ready():
	# this prints, but the other one on the button doesn't
	#print("hi")
	#testChord()
	#$Label.text = AutoloadSongInfo.currentSong
	#$Label2.text = AutoloadSongInfo.currentAudio
	
	#var song = file.open(str("res://SongAudio/", AutoloadSongInfo.currentAudio), 1)
	
	print(currentSong)
	print(currentChart)
	currentSong = AutoloadSongInfo.currentAudio
	currentChart = AutoloadSongInfo.currentSong
	print(currentSong)
	print(currentChart)
	$AudioStreamPlayer.stream = load(currentSong)
	#$AudioStreamPlayer.stream = load(hardcodedAALAudioPath)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	# Revision 2/9/23 -- to undo, uncomment lines that are commented with "TEST 1" at the start
	# Lowered audio latency setting to 0 (for both versions including HTML5)
	# latency is improved, but chords are unusually out of sync
	# and the non chord notes are much better
	
	#TEST 1time = $AudioStreamPlayer.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	
	#print("TIME: ", time)
	# This is from the docs, but I don't think it ever 
	# gets a value other than 0
	#TEST 1time += AudioServer.get_output_latency()
	
	
	
	#timeToNextMix = AudioServer.get_time_to_next_mix()
	#print("GTTNM: ", timeToNextMix)
	#print("GOL:", AudioServer.get_output_latency())
	
	#yolo
	# lower dividend = faster note arrival times
	# higher divident = slower note arrival times
	#latency = time/600000
	#i do not know why the below options is more accurate than this
	
	# This is okay, but not really passable for dealing with delay
	
	# I really have no idea why this is having the best results
	# for making the latency match up with the song
	# TEST 1 if time > 0.003:
		# 0.003 was good but lagged at the end
		
		#time = time - 0.003
		#TEST 1 time = fmod(time, 0.003)
		#TEST 1 latency = time
	
	pass


func _on_Button_pressed():
	# this is to test how everything functions so it will
	# have a lot of commented out methods
	
	#parse_xml_charts_with_regex()
	
		
	betterRegexMethod()
	test_song()
	#launchNotes()
	displayChords()
	#trialCombineNoteData()
	#print(actualChordTimeArray)
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
	
	#there is definitely a cleaner way to do this, but it works
	var smallestSizeArray = actualNoteArray
	if actualStringArray.size() < actualNoteArray.size():
		smallestSizeArray = actualStringArray
	if actualTimeArray.size() < smallestSizeArray.size():
		smallestSizeArray = actualTimeArray
	
	#below is the actual intended code
	for i in smallestSizeArray.size():
		
		
		currentNote = i
		
		#create instance of "falling note" scene
		#and add it to scene 
		#idk if this needs to be done before it gets modified
		var newNote = note.instance()
		#add_child(newNote)
		
		#map fret's locations from data
		# i know this looks bad
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
		newNote.visible = false
		
		#if i == 0:
			#newNote.set_animationStartTime(actualTimeArray[i])
		#else:
			#newNote.set_animationStartTime(actualTimeArray[i] - actualTimeArray[i - 1])
		
		
		
		
		add_child(newNote)
		
		# end code here
		# to separate the creation of the nodes with the 
		# playback of the nodes to not introduce as much latency
		
		
		#TODO fix the thing that this is supposed to fix but doesnt
		# when the last note is made, it says "invalid get index '3163' (on base: 'Array')
		#even though i thought this would detect if it is null and stop
		if actualTimeArray[i] != null:
			if i == 0:
				start_time = $AudioStreamPlayer.get_playback_position()
				#yield(get_tree().create_timer(actualTimeArray[i] - latency), "timeout")
				yield(get_tree().create_timer(actualTimeArray[i]), "timeout")
			else:
				# this is an absolute mess, but when it works, it needs to be replicated with the chords 
				# right now, this portion only works with individual notes
				
				#print("Note latency = ", latency)
				#print("Current Time? = ", $AudioStreamPlayer.get_playback_position())
				#print("Target time? = ", actualTimeArray[i] - actualTimeArray[i - 1])
				
				# actual holder for upcoming note start time
				# this is the original correct version
				var targetTime = actualTimeArray[i] - actualTimeArray[i - 1]
				
				# test at calculating latency based off of times that should be the same but aren't
				# this gets applied below in the yield function
				var testLatency = (start_time + actualTimeArray[i]) - (start_time + $AudioStreamPlayer.get_playback_position())
				#print(testLatency)
				
				
				#yield(get_tree().create_timer(targetTime - latency), "timeout")
				
				# lower dividend = faster notes, higher dividend = slower notes
				# need to figure out the logic behind needing to divide this, because I have no idea
				# 2750 is the right number (at least for this 15 minute song)
				yield(get_tree().create_timer(targetTime-testLatency/2750), "timeout")
		
		#print(time)
		#add_child(newNote)
		
		
		if !($AudioStreamPlayer.playing):
			start_time = Time.get_ticks_msec()
			$AudioStreamPlayer.play()	
		
		
		
		newNote.get_child(0).get_child(0).play("FallingAnimation")
		newNote.visible = true
		
	#launchNotes()
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
	# because idk why a single non dynamic difficulty chart needs 16 difficulties
	
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
	
	# i might only need to do this once
	# instead of for every regex search
	# but whatever yolo
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
	var try9 = "(?<=chordId=\")(.*?)(?=\")"
	
	regex.compile(try9)
	var test5 = regex.search(sectionOfDoc)
	
	while test5 != null:
		#i dont remember what this line does
		#print(test5.get_string(0))
		actualChordTimeArray.append(int(test5.get_string(0)))
		test5 = regex.search(sectionOfDoc, test5.get_end(0))
	
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

func betterRegexMethod():
	
	# regex descriptions above each variable declaration
	
	# grabs the target difficulty section only to parse through
	# level difficulty sections might be related to dynamic difficulty
	# -- todo --
	# use If statement to get the largest note portion of the file
	# ie. if there are two groupings of notes:
	#     first grouping = level difficulty 5 note count 274
	#     second grouping = level difficulty 3 note count 163
	# *** it will select the larger of the two
	# the important relevant tag is <notes count="274">
	
	# (?<=notes count=)*(?=<\/notes>) test but doesnt work
	# still wip
	
	var try4 = "(?=level difficulty=\"0\")[\\s\\S]*(?=</level>)"
	#var try4 = "(?=level difficulty=\"3\")[\\s\\S]*(?=</level>)"
	#var try4 = "/<notes count=\"293\">(.*?)<\/notes>/sg"
	# -- Begin grabbing individual note data --
	
	
	# grabs note fret location from section
	var try5 = "(?<=fret=\")(.*?)(?=\")"
	
	# grabs note time from section
	var try6 = "(?<=note time=\")(.*?)(?=\")"
	
	# grabs target string from section
	var try7 = "(?<=string=\")\\d*(?=\")"
	
	# -- End grabbing individual note data --
	# -- Begin grabbing chord data --
	
	# grabs target chord time of upcoming chord
	var try8 = "(?<=chord time=\")(.*?)(?=\")"
	
	# grabs chord id of upcoming note/chord
	
	# *** the chord id is referenced in order from
	# how the chord templates get created
	# 	ie. the first chord template in the list is "1"
	#		the second chord in the template is "2"
	var try9 = "(?<=chordId=\")(.*?)(?=\")"
	
	# grabs low E string note from chord
	var try10 = "(?<=fret0=\")(.*?)(?=\")"
	
	# grabs A string note from chord
	var try11 = "(?<=fret1=\")(.*?)(?=\")"
	
	# grabs D string note from chord
	var try12 = "(?<=fret2=\")(.*?)(?=\")"
	
	# grabs G string note from chord
	var try13 = "(?<=fret3=\")(.*?)(?=\")"
	
	# grabs B string note from chord
	var try14 = "(?<=fret4=\")(.*?)(?=\")"
	
	# grabs high E string note from chord
	var try15 = "(?<=fret5=\")(.*?)(?=\")"
	
	# --- End regex statements ---
	# --- Begin file operations,
	#     data organization into arrays,
	#     and regex statement executions
	
	var file = File.new()
	#file.open("res://Songcharts/btbamwhitewallsalb11_lead.xml", 1)
	#file.open(hardcodedSongChartPath, 1)
	#file.open(hardcodedAALSongPath, 1)
	#file.open("res://Songcharts/cusaalpointtopoint_lead.xml", 1)
	
	#below is what should work but doesn't
	#file.open(str(AutoloadSongInfo.currentSong), 1)
	file.open(currentChart, 1)
	
	var wholeFile = file.get_as_text()
	
	var regex = RegEx.new()
	
	regex.compile(try4)
	
	var partOfFile = regex.search(wholeFile).get_string()
	
	#grab and organize fret data
	regex.compile(try5)
	var test = regex.search(partOfFile)
	while test != null:
		actualNoteArray.append(int(test.get_string(0)))
		test = regex.search(partOfFile, test.get_end(0))
	regex.clear()
	
	#grab and organize time data
	# data needs to be in a float format
	regex.compile(try6)
	test = regex.search(partOfFile)
	while test != null:
		actualTimeArray.append(float(test.get_string(0)))
		test = regex.search(partOfFile, test.get_end(0))
	regex.clear()
	
	# grab and organize string data
	regex.compile(try7)
	test = regex.search(partOfFile)
	while test != null:
		actualStringArray.append(int(test.get_string(0)))
		test = regex.search(partOfFile, test.get_end(0))
	regex.clear()
	
	# -- End individual note gathering --
	
	# -- Begin chord info gathering --
	
	# chord arrival time
	regex.compile(try8)
	test = regex.search(wholeFile)
	while test != null:
		actualChordTimeArray.append(float(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# chord ID (based off the order of documented chord templates)
	# ie. the first chord in the template is 1, next is 2, etc.
	regex.compile(try9)
	test = regex.search(wholeFile)
	while test != null:
		actualChordIDArray.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# low E string
	regex.compile(try10)
	test = regex.search(wholeFile)
	while test != null:
		actualChordLowEstring.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# A string
	regex.compile(try11)
	test = regex.search(wholeFile)
	while test != null:
		actualChordAstring.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# D string
	regex.compile(try12)
	test = regex.search(wholeFile)
	while test != null:
		actualChordDstring.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# G string
	regex.compile(try13)
	test = regex.search(wholeFile)
	while test != null:
		actualChordGstring.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# B string
	regex.compile(try14)
	test = regex.search(wholeFile)
	while test != null:
		actualChordBstring.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# high E string
	regex.compile(try15)
	test = regex.search(wholeFile)
	while test != null:
		actualChordHighEstring.append(int(test.get_string(0)))
		test = regex.search(wholeFile, test.get_end(0))
	regex.clear()
	
	# -- End chord info gathering --
	pass

func testChord():
	var note1 = note.instance()
	var note2 = note.instance()
	var note3 = note.instance()
	
	note1.translation.x = fret_coords[2]
	note1.translation.y = string_coords[1]
	note1.get_child(0).set_text("2")
	note1.get_child(0).modulate = Color.yellow
	
	note2.translation.x = fret_coords[2]
	note2.translation.y = string_coords[2]
	note2.get_child(0).set_text("2")
	note2.get_child(0).modulate = Color.cornflower
	
	note3.translation.x = fret_coords[1]
	note3.translation.y = string_coords[3]
	note3.get_child(0).set_text("1")
	note3.get_child(0).modulate = Color.orange
	
	add_child(note1)
	add_child(note2)
	add_child(note3)
	
	note1.get_child(0).get_child(0).play("FallingAnimation")
	note2.get_child(0).get_child(0).play("FallingAnimation")
	note3.get_child(0).get_child(0).play("FallingAnimation")
	pass

func displayChords():
	for i in actualChordTimeArray.size():
		
		var chordID = actualChordIDArray[i]
		
		var noteLowE = null
		var noteA = null
		var noteD = null
		var noteG = null
		var noteB = null
		var noteHighE = null
		
		# if this code is run at this position,
		# the delay is increased by a large portion
		"""
		if actualChordTimeArray[i] != null:
			print(i)
			print(actualChordTimeArray[i])
			if i == 0:
				yield(get_tree().create_timer(actualChordTimeArray[i]), "timeout")
			else:
				# TODO suppress error with the last field in ActualTimeArray
				# it says that the field is null and crashes
				var targetTime = actualChordTimeArray[i] - actualChordTimeArray[i - 1]
				yield(get_tree().create_timer(targetTime), "timeout")
		"""
		
		if actualChordLowEstring[chordID] >= 0:
			noteLowE = note.instance()
			noteLowE.translation.x = fret_coords[actualChordLowEstring[chordID]]
			noteLowE.translation.y = string_coords[0]
			noteLowE.get_child(0).set_text(str(actualChordLowEstring[chordID]))		
			noteLowE.get_child(0).modulate = Color.red
			noteLowE.get_child(0).get_child(1).outline_modulate = Color.red
			noteLowE.visible = false
			add_child(noteLowE)
		
		if actualChordAstring[chordID] >= 0:
			noteA = note.instance()
			noteA.translation.x = fret_coords[actualChordAstring[chordID]]
			noteA.translation.y = string_coords[1]
			noteA.get_child(0).set_text(str(actualChordAstring[chordID]))
			noteA.get_child(0).modulate = Color.yellow
			noteA.get_child(0).get_child(1).outline_modulate = Color.yellow
			noteA.visible = false
			add_child(noteA)
		
		if actualChordDstring[chordID] >= 0:
			noteD = note.instance()
			noteD.translation.x = fret_coords[actualChordDstring[chordID]]
			noteD.translation.y = string_coords[2]
			noteD.get_child(0).set_text(str(actualChordDstring[chordID]))
			noteD.get_child(0).modulate = Color.cornflower
			noteD.get_child(0).get_child(1).outline_modulate = Color.cornflower
			noteD.visible = false
			add_child(noteD)
		
		if actualChordGstring[chordID] >= 0:
			noteG = note.instance()
			noteG.translation.x = fret_coords[actualChordGstring[chordID]]
			noteG.translation.y = string_coords[3]
			noteG.get_child(0).set_text(str(actualChordGstring[chordID]))
			noteG.get_child(0).modulate = Color.orangered
			noteG.get_child(0).get_child(1).outline_modulate = Color.orangered
			noteG.visible = false
			add_child(noteG)
		
		if actualChordBstring[chordID] >= 0:
			noteB = note.instance()
			noteB.translation.x = fret_coords[actualChordBstring[chordID]]
			noteB.translation.y = string_coords[4]
			noteB.get_child(0).set_text(str(actualChordBstring[chordID]))
			noteB.get_child(0).modulate = Color.green
			noteB.get_child(0).get_child(1).outline_modulate = Color.green
			noteB.visible = false
			add_child(noteB)
		
		if actualChordHighEstring[chordID] >= 0:
			noteHighE = note.instance()
			noteHighE.translation.x = fret_coords[actualChordHighEstring[chordID]]
			noteHighE.translation.y = string_coords[5]
			noteHighE.get_child(0).set_text(str(actualChordHighEstring[chordID]))
			noteHighE.get_child(0).modulate = Color.purple
			noteHighE.get_child(0).get_child(1).outline_modulate = Color.purple
			noteHighE.visible = false
			add_child(noteHighE)
	
		#"""
		if actualChordTimeArray[i] != null:
			#print(i)
			#print(actualChordTimeArray[i])
			if i == 0:
				# this line desyncs the arrival time of the chords from the notes
				# ie. if the notes are generated with a delay, this won't use any of that offset info
				# however, the arrival time of the first chord isn't laggy for some reason
				#chord_start_time = $AudioStreamPlayer.get_playback_position()
				yield(get_tree().create_timer(actualChordTimeArray[i]), "timeout")
			else:
				# TODO suppress error with the last field in ActualTimeArray
				# it says that the field is null and crashes
				#var targetTime = actualChordTimeArray[i] - actualChordTimeArray[i - 1]
				#print("Chord latency = ", latency)
				#yield(get_tree().create_timer(targetTime - latency), "timeout")
				
				# chords still have lag and I have no idea how
				var targetTime = actualChordTimeArray[i] - actualChordTimeArray[i - 1]
				var testLatency = (start_time + actualChordTimeArray[i]) - (start_time + $AudioStreamPlayer.get_playback_position())
				#yield(get_tree().create_timer(targetTime-testLatency), "timeout")
				yield(get_tree().create_timer(targetTime), "timeout")
		#"""
		
		if noteLowE != null:
			noteLowE.get_child(0).get_child(0).play("FallingAnimation")
			noteLowE.visible = true
		
		if noteA != null:
			noteA.get_child(0).get_child(0).play("FallingAnimation")
			noteA.visible = true
		
		if noteD != null:
			noteD.get_child(0).get_child(0).play("FallingAnimation")
			noteD.visible = true
		
		if noteG != null:
			noteG.get_child(0).get_child(0).play("FallingAnimation")
			noteG.visible = true
		
		if noteB != null:
			noteB.get_child(0).get_child(0).play("FallingAnimation")
			noteB.visible = true	
		
		if noteHighE != null:
			noteHighE.get_child(0).get_child(0).play("FallingAnimation")
			noteHighE.visible = true
		
		
	pass

func launchNotes():
	# -- Ignore this --
	
	# This method plays all the previously created nodes
	# instead of playing them as they are created.
	# It didn't noticably improve latency, but I am keeping
	# it for now.
	
	
	#$AudioStreamPlayer.play()
	
	for i in noteNodeArray.size():
		#add_child(noteNodeArray[i])
		#yield(get_tree().create_timer(noteNodeArray[i].get_animationStartTime() - latency),"timeout")
		yield(get_tree().create_timer(noteNodeArray[i].get_animationStartTime()),"timeout")
		noteNodeArray[i].visible = true
		if !($AudioStreamPlayer.playing):
			$AudioStreamPlayer.play()
		noteNodeArray[i].get_child(0).get_child(0).play("FallingAnimation")
		pass
	pass

func testAudioStreamGenerator():
	# Testing functionality of AudioStreamGenerator
	# and AudioStreamPlayback
	# -- relevant urls : 
	#  .  https://github.com/godotengine/godot/issues/32382
	#  .  https://github.com/godotengine/godot-demo-projects/blob/3.4-b0d4a7c/audio/generator/generator_demo.gd
	#  .  https://godotengine.org/article/godot-32-will-get-new-audio-features
	
	#AudioStreamGenerator
	pass



func _on_SelectSongButton_pressed():
	#disabled because of problems loading new non hardcoded files
	#and also because there is a bigger problem of figuring out
	#how other charts have the important information to gather
	#it is very all over the place and inconsistent
	get_tree().change_scene("res://Scenes/SelectSong.tscn")
	pass # Replace with function body.
