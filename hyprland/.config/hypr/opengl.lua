-- https://wiki.hypr.land/Configuring/Basics/Variables/#opengl

hl.config({
  opengl = {
    nvidia_anti_flicker = true, -- Reduces flockering on nvidia at the cost of possible frame drops on lower-end GPUs. On non-nvim, this is ignored.
  }
})
