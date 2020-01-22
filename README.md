# sonicPi
Phil's repository for Sonic Pi experiments

First uploads are : 
beatArray.rb
notesArray.rb

The beatArray file was inspired by Phil's "Teenage Engineering Pocket Operator" a fantastic 16 beat pocket sized drum machine. 
After struggling to find an easy way to get the right "timings" for beats in Sonic Pi, phil looked at his PO-12 and started to use an array of 16 items to store a sample or silence and use a regular "sleep" unit to cycle through each position (making a 16 beat pattern in effect). 

He added more than one array for bass drum & snare patterns, then created arrays that held "sequences" of patterns. 
Phil used variables as counters to cycle through beat positions in pattern arrays AND overall sequence positions.

The Ruby file is commented and hopefully makes sense - if not, let Phil know. 
