# Boulder
A barebones, almost functional rhythm game/guitar tab viewer using Godot. Works with xml guitar tabs combined with corresponding sound files, but not very well. 
I also don't know how to make a proper README.md

![image](https://user-images.githubusercontent.com/111002047/184797752-6f804d30-378d-4e33-add2-a7fdbc5f6a27.png)

problem 1 = fix the latency problem that individually acumulates as notes get spawned in both chords and standalone notes.
              - notes and chords get spawned seperate from each other, therefore the latency builds up at different and independent rates from each other.
problem 2 = fix the overall design (of notes/3D camera angle/etc) to improve visual clarity of the information.
problem 3 = create a custom regex expression editor that saves expressions for each chart to guarantee a solution is accessible if the chart's data isn't in the             same format as other charts.
problem 4 = figure out if the README.md is an appropiate location to place TODO items.
