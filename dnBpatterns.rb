use_sample_bpm :loop_amen, num_beats: 4

#define drum patterns
bd1 = [1, 0, 0, 0, 0, 0, 0, 0].ring
bd2 = [0, 0, 1, 0, 0, 0, 0, 0].ring
bd3 = [0, 0, 1, 0, 0, 2, 0, 0].ring
sn1 = [0, 0, 0, 0, 1, 0, 0, 0].ring
sn2 = [0, 0, 0, 0, 1, 0, 0, 0].ring
ht1 = [1, 0, 0, 0, 0, 0, 1, 0].ring
ht2 = [1, 0, 0, 0, 1, 0, 1, 0].ring
ht3 = [1, 0, 1, 0, 2, 0, 0, 0].ring

#define drum sounds to play "0" at start (position 0) is a holder so "1", "2"... from sequences will call correct sound from array
bassDrums = [0, :bd_fat, :bd_klub ]
snares = [0, :sn_dolf, :sn_zome]
hats = [0, :drum_cowbell, :drum_splash_hard]

# define sequences
sns = [sn1, sn2].ring
bdb = [bd1, bd2, bd1, bd2, bd3, bd2, bd1, bd3].ring
hth = [ht1, ht2, ht1, ht1, ht2, ht1, ht2, ht3].ring
playAmen = (ramp * range(0.1, 1, 0.02)).ring

seq = 0

live_loop :amen do
  a = tick
  puts "amen res = #{playAmen[a]}"
  if playAmen[a] != 0 then
    with_fx :krush, gain: 1, mix: 0.8, res: playAmen[a] do
      sample :loop_amen, amp: 0.2, rate: [1, 1, 1, 1, 1, 1, 1, -1].ring[a]
    end
  end
  sleep sample_duration(:loop_amen)
end


live_loop :db do
  x = 0
  curBD = bdb[seq]
  curSN = sns[seq]
  curHT = hth[seq]
  8.times do
    if curBD[x] != 0 then
      sample bassDrums[curBD[x]], amp: 2
      if curBD == bd1 then
        sample :bd_boom, amp: 1, decay: 2, hpf: playAmen[x] * 5
      end
    end
    
    if curSN[x] != 0 then
      sample snares[curSN[x]], rate: 1
    end
    
    if curHT[x] != 0 then
      with_fx :ping_pong, phase: 1.25, max_phase: 1.75, mix: 0.2 do
        sample hats[curHT[x]], amp: range(0.5, 1.5).sample / 10.0
      end
    end
    x+=1
    sleep 0.25
  end
  seq+=1
end
