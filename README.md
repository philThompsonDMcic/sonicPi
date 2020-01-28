# sonicPi
Phil's repository for Sonic Pi experiments

First uploads are : 
beatArray.rb
notesArray.rb

#Edit 28/01/20
I developed the sonic pi files on a laptop (they work a treat) I have since run the code on a raspberry Pi and discovered that the short Sleep units between each beat (0.25 seconds) is too fast to process & the pi stops playing the beats. I'll develop an 8 beat array and longer sleeps. It means that you can't have as complicated patterns, but it should be fine for simple tunes / beats.

The beatArray file was inspired by Phil's "Teenage Engineering Pocket Operator" a fantastic 16 beat pocket sized drum machine. 
After struggling to find an easy way to get the right "timings" for beats in Sonic Pi, phil looked at his PO-12 and started to use an array of 16 items to store a sample or silence and use a regular "sleep" unit to cycle through each position (making a 16 beat pattern in effect). 

He added more than one array for bass drum & snare patterns, then created arrays that held "sequences" of patterns. 
Phil used variables as counters to cycle through beat positions in pattern arrays AND overall sequence positions.

The Ruby file is commented and hopefully makes sense - if not, let Phil know. 
