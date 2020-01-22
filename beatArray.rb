use_bpm 110
p = 0.25 # a control variable to affect the sleep timing

# define some samples as shorthand variables (2 chars = all neat & tidy in the array)
bd = :drum_heavy_kick
sn = :sn_generic
hc = :drum_cymbal_pedal
ho = :drum_cymbal_open

# :z = no sample (aka "nothing" or "silence"!)

#define some bass drum patterns in an array 16 beats long
# - all arrays are "rings" so they can easily be looped through with the tick value
bds0 = [:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z].ring
bds1 = [bd,:z,:z,:z,:z,:z,:z,bd,:z,:z,:z,:z,:z,:z,:z,:z].ring
bds2 = [bd,:z,bd,:z,:z,:z,:z,bd,:z,:z,:z,bd,:z,:z,:z,:z].ring
bds3 = [bd,:z,bd,:z,:z,:z,:z,bd,:z,bd,:z,:z,:z,:z,bd,bd].ring
bds4 = [bd,:z,:z,bd,:z,bd,:z,ho,:z,:z,:z,:z,:z,:z,:z,:z].ring

#define some snare drum patterns in an array 16 beats long
sns0 = [:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z,:z].ring
sns1 = [:z,:z,:z,:z,:z,:z,:z,:z,sn,:z,:z,:z,:z,:z,:z,:z].ring
sns2 = [:z,:z,:z,:z,:z,:z,:z,:z,sn,:z,:z,:z,sn,:z,:z,:z].ring
sns3 = [:z,sn,:z,:z,:z,:z,sn,:z,:z,:z,:z,:z,:z,:z,sn,sn].ring

#define some hats patterns in an array 16, 8 or 4beats long
hat1 = [hc,:z,:z,:z,hc,:z,:z,:z,hc,:z,:z,:z,hc,:z,:z,:z].ring
hat2 = [:z,:z,hc,:z,:z,:z,hc,hc].ring
hat3 = [:z,:z,hc,:z].ring

#define some drum sequences from the patterns above
bds = [bds1, bds1, bds1, bds2, bds1, bds1, bds1, bds3, bds1, bds1, bds1, bds2, bds1, bds1, bds4, bds0].ring
sns = [sns1, sns2, sns1, sns2, sns1, sns2, sns1, sns2, sns1, sns2, sns1, sns2, sns1, sns2, sns3, sns0].ring

#define some counters (bass, snare, count)
b = 0
s = 0
c = 0

live_loop :drums do
  with_fx :distortion, distort: 0.5, mix: 0.8 do
    with_fx :reverb, room: 0.1, mix: 0.6, damp: 0.1 do
      # play a sample from each array (bass / snare = sequence arrays, hats = plain pattern at the moment)
      sample bds[b][c], pan: 0.5, amp: 1.1 #[b] = drum sequence position [c] = the beat count in the pattern array
      sample sns[s][c], pan: -0.5, amp: 0.9
      x = [0,1].sample
      sample hat1[c], pan: 0, amp: 0.6
      sleep (1*p)
      c = c+1 #increase the count by 1 per sample play in the pattern
      if c == bds1.length() # the count has got to the end of the pattern array length, change the bass & snare sequence position
        s = s+1
        b = b+1
        c = 0
      end
      if b == bds.length() # check to see if the bass drum sequence counter is at the end of the array
        b = 0 #reset the bass drum sequence counter back to 0
      end
      if s == sns.length() # check to see if the snare sequence counter is at the end of the array
        s = 0 #reset the snare sequence counter back to 0
      end
    end
  end
end

