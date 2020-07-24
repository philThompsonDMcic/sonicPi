use_bpm 128
use_cue_logging false
use_debug false

loops = "C:/Users/Phil/Documents/samples/Percussion Loops/128"
#samps = "C:/Users/Phil/Desktop/vaughan/vtune/desktop/"

snFadeIn = range(0, 1, 0.01).mirror
a = 0
slowFad = range(0, 1, 0.01)
fastFad = range(0, 1, 0.05)
vFastFad = range(0, 1, 0.1)

cc = 0
bc = 0
section = 0
lastSection = 0
tickreset = false
beatsPerBar = 8


parts = {:intro => (0..2),
         :main => (3..64),
         :break1 => (9..10),
         :break2 => (17..19)
         }
bdForSections = {:intro => [:bd_boom, 0, 1, 1],
                 :main => [:drum_bass_hard, 0, 2, 1],
                 :break1 => [:drum_bass_soft, 0, 1, 1],
                 :break2 => [:bd_zome, 0, 2, 1]
                 }
snForSections = {:intro => [:sn_dolf, 0.5, 1.5, 0],
                 :main => [:elec_lo_snare, 0.5, 2.5, 0.2],
                 :break1 => [:drum_snare_soft, 0.25, 1.25, 0.3],
                 :break2 => [:drum_snare_hard, 0.25, 2.25, 0.3]
                 }
htForSections = {:intro => [:drum_cymbal_pedal, 0.5, 1.5, 0],
                 :main => [:drum_cymbal_pedal, 0.5, 1.5, :r],
                 :break1 => [:hc, 0.5, 1.5, :r],
                 :break2 => [:hc, 0.5, 0.5, :r]
                 }
loopsSections = {:intro => "Loop_14", #02 ws good
                 :main => "Loop_13", #04 was good
                 :break1 => "Loop_16", #15 was good
                 :break2 => "Loop_16"
                 }

define :getRand do | a=0, b=1, c=0.1 |
  return range(a, b, c).sample
end

live_loop :cc do
  cc = cc+ 1
  parts.each do | s, v |
    if v.include? cc then
      section = s
      if section != lastSection then
        tickreset = true
        if section != :main then
          mySamp = loops, "Loop_16"
          injectSlowLoop(mySamp, 0.5, 0.8)
        end
      else
        tickreset = false
      end
      puts section
    end
  end
  sleep beatsPerBar
  lastSection = section
end

live_loop :bc do
  bc=bc+1
  sleep 1
end

live_loop :ll do
  t = tick
  if t >= vFastFad.length then
    ta = 1
  else
    ta = vFastFad[t]
  end
  if section == :intro then
    ta = 0.8
  end
  myLoop = loops, loopsSections[section]
  sample myLoop, amp: ta
  sleep sample_duration myLoop
end

define :injectSlowLoop do | whatLoop="Loop_20", speed=0.1, a=0.2 |
  puts "injected #{whatLoop}"
  sample whatLoop, rate: speed, amp: a
end

live_loop :bb do
  sleep bdForSections[section][1]
  if section == :main and tick % 4 == 0 then
    sample :bd_boom, sustain: 1.2, amp: 1.4
  end
  sample bdForSections[section][0], amp: bdForSections[section][3] + getRand(0, 0.1, 0.01), sustain: 1 + getRand(-0.1, 0.1, 0.01)
  sleep bdForSections[section][2]
end

live_loop :sn do
  sleep snForSections[section][1]
  sample snForSections[section][0], amp: snForSections[section][3] + getRand(0, 0.1, 0.01), sustain: 1 + getRand(-0.1, 0.1, 0.01)
  sleep snForSections[section][2]
  if section == :main and tick % 6 == 0 then
    with_fx :echo, decay: 2, phase: [0.333, 0.666, 0.999].sample, mix: 0.8 do
      sample :drum_snare_soft, sustain: 1.2, amp: 1.4, pan: range(-1, 1).sample
    end
  end
  sync :bb
end

define :hc do
  return "perc"
end

live_loop :ht do
  t = tick
  if tickreset then
    tick_reset
  else
    if t >= fastFad.length then
      ta = 1
    else
      ta = fastFad[t]
    end
  end
  
  with_fx :level, amp: ta do
    a = htForSections[section][3]
    s = htForSections[section][0]
    if a == :r then
      a = getRand(0.7, 1.1, 0.1)
    end
    
    if s == :hc then
      s = hc(), pick
      a = 0.3
    end
    
    sleep htForSections[section][1]
    sample s, amp: a
    sleep htForSections[section][2]
    sync :bb
  end
end

live_loop :boomBip do
  t = tick
  x = 0
  sleep 1
  if section == :main then
    if t%2 == 0 then
      sample :bd_boom, rate: 2, pan: -0.3
    else
      sample :bd_boom, rate: 1.4, pan: 0.3
      x = 1
    end
  end
  sleep 3 - x
end


