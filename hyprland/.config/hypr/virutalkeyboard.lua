-- https://wiki.hypr.land/Configuring/Basics/Variables/#virtualkeyboard
hl.config({
  input = {
    virtualkeyboard = {
      share_states = 2,                 -- Unify key down states and modifier states with other keyboards. 0 -> no, 1 -> yes, 2 -> yes unless IME client	
      release_pressed_on_close = false, --	Release all pressed keys by virtual keyboard on close.
    },
  },
})
