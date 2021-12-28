extends AudioStreamPlayer


const songs = ["res://Music/Karl Casey - White Bat I - 01 Elysium.mp3","res://Music/Karl Casey - White Bat I - 02 Casualty.mp3","res://Music/Karl Casey - White Bat I - 03 Anima.mp3","res://Music/Karl Casey - White Bat I - 04 Patrol Bot.mp3","res://Music/Karl Casey - White Bat I - 05 Alliance.mp3","res://Music/Karl Casey - White Bat I - 06 Last Man Standing.mp3","res://Music/Karl Casey - White Bat I - 07 Self Inflicted.mp3","res://Music/Karl Casey - White Bat I - 08 B.F.G..mp3","res://Music/Karl Casey - White Bat I - 09 The Witch.mp3","res://Music/Karl Casey - White Bat I - 10 The Traveler.mp3","res://Music/Karl Casey - White Bat I - 11 Lost Vegas.mp3","res://Music/Karl Casey - White Bat I - 12 Doomed to Survive.mp3","res://Music/Karl Casey - White Bat I - 13 Sanity Unravels.mp3","res://Music/Karl Casey - White Bat I - 14 The Bouncer.mp3","res://Music/Karl Casey - White Bat I - 15 Countach.mp3","res://Music/Karl Casey - White Bat I - 16 Tenebrae.mp3","res://Music/Karl Casey - White Bat I - 17 Tyrell Corporation.mp3","res://Music/Karl Casey - White Bat I - 18 Torn Flesh.mp3","res://Music/Karl Casey - White Bat I - 19 Cosmic Death Machine.mp3","res://Music/Karl Casey - White Bat I - 20 Night Crawler.mp3","res://Music/Karl Casey - White Bat I - 21 New Beginnings.mp3","res://Music/Karl Casey - White Bat I - 22 The Prophet.mp3","res://Music/Karl Casey - White Bat I - 23 Unhuman.mp3","res://Music/Karl Casey - White Bat I - 24 Menace.mp3","res://Music/Karl Casey - White Bat I - 25 Empty City.mp3"]
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var id = rand_range(0, songs.size())
	var song = load(songs[id])
	stream = song
	play()
	
