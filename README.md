# Boulder
A barebones, almost functional rhythm game/guitar tab viewer using Godot. Works with xml guitar tabs combined with corresponding sound files, but not very well. 
I also don't know how to make a proper README.md
<br /><br />
![image](https://user-images.githubusercontent.com/111002047/184797752-6f804d30-378d-4e33-add2-a7fdbc5f6a27.png)
<br /><br />
problem 1 = Fix the latency problem that individually acumulates as notes get spawned in both chords and standalone notes.
              - notes and chords get spawned separate from each other, therefore the latency builds up at different and independent rates from each other.
<br /><br />
problem 2 = Fix the overall design (of notes/3D camera angle/etc) to improve visual clarity of the information.
<br /><br />
problem 3 = Create a custom regex expression editor that saves expressions for each chart to guarantee a solution is accessible if the chart's data isn't in the             same format as other charts.
<br /><br />
problem 4 = Figure out if the README.md is an appropiate location to place TODO items.
<br /><br />
problem 5 = Figure out how to do line breaks in a README. (Solved)
