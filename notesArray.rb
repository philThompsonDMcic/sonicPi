bp1 = [:d2, :e2, :e2, :d2, :e2, :e2, :g2, :e2, :d2, :d2, :e2, :e2, :d2, :e2, :e2, :g2, :e2, :g2].ring
tt1 = [0.25, 0.75, 1, 0.25, 0.5, 0.25, 0.25, 0.25, 0.5].ring

live_loop :tune do
  #if tuneFlag == true
  use_synth :sine
  tuneSleep = tick
  play bp1[tuneSleep] + 8, release: 0.25, slide: 0.25, sustain: 0.33, pan: -0.2, amp: 4
  sleep (tt1[tuneSleep])
  puts tuneSleep
end
