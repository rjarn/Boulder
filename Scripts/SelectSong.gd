extends Node2D

var songChartArray = []
var songAudioArray = []

var chartButtonArray = []
var audioButtonArray = []

var songChartsPath = "res://SongCharts/"
var songAudioPath = "res://SongAudio/"


# Called when the node enters the scene tree for the first time.
func _ready():
	populateArrays()
	createSongSelectionButtons()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func populateArrays():
	# get files in folders and append appropiate arrays
	var dir = Directory.new()
	dir.open(songChartsPath)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			songChartArray.append(file)
			#songChartsPath.add_item(file, null, true)
			
	dir.list_dir_end()
	
	dir.open(songAudioPath)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			songAudioArray.append(file)
			#songAudioA
	
	dir.list_dir_end()
	
	pass

func createSongSelectionButtons():
	# Dynamically create buttons for the files in the songCharts folder
	for i in songChartArray.size():
		var button = Button.new()
		button.text = songChartArray[i]
		button.connect("pressed", self, "_chart_button_pressed")
		chartButtonArray.append(button)
		$HBox/ChartVBox.add_child(button)
		pass
	
	for i in songAudioArray.size():
		var button = Button.new()
		button.text = songAudioArray[i]
		button.connect("pressed", self, "_audio_button_pressed")
		audioButtonArray.append(button)
		$HBox/AudioVBox.add_child(button)
		pass
	pass

func _chart_button_pressed():
	for i in chartButtonArray.size():
		if chartButtonArray[i].is_pressed():
			AutoloadSongInfo.currentSong = chartButtonArray[i]
			print("fart")
	pass

func _audio_button_pressed():
	for i in audioButtonArray.size():
		if audioButtonArray[i].is_pressed():
			AutoloadSongInfo.currentAudio = audioButtonArray[i]
			print("i have gas")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/PlaySong.tscn")
	pass # Replace with function body.
