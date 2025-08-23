return {
	"rachartier/tiny-glimmer.nvim",
	enabled = true,
	event = "VeryLazy",
	priority = 10,
	config = function()
		require("tiny-glimmer").setup({
			enabled = true,

			disable_warnings = true, -- for debugging purposes
			refresh_interval_ms = 8,
			overwrite = {
				auto_map = true,
				yank = {
					enabled = true,
					default_animation = "fade",
				},
				search = {
					enabled = false,
					default_animation = "pulse",
					next_mapping = "n",
					prev_mapping = "N",
				},
				paste = {
					enabled = true,
					default_animation = "reverse_fade",
					paste_mapping = "p",
					Paste_mapping = "P",
				},
				undo = {
					enabled = true,
					default_animation = {
						name = "fade",
						settings = {
							from_color = "DiffDelete",
							max_duration = 500,
							min_duration = 500,
						},
					},
					undo_mapping = "u",
				},
				redo = {
					enabled = true,
					default_animation = {
						name = "fade",
						settings = {
							from_color = "DiffAdd",
							max_duration = 500,
							min_duration = 500,
						},
					},
					redo_mapping = "<C-r>",
				},
			},

			presets = {
				pulsar = {
					enabled = false,
					on_events = { "CursorMoved", "CmdlineEnter", "WinEnter" },
					default_animation = {
						name = "fade",
						settings = {
							min_duration = 1000,
							max_duration = 1000,
						},
						from_color = "DiffDelete",
						to_color = "Normal",
					},
				},
			},
			transparency_color = nil,
			-- Animation config
			animations = {
				reverse_fade = {
					max_duration = 380,
					min_duration = 300,
					easing = "outBack",
					chars_for_max_duration = 10,
					from_color = "Visual",
					to_color = "Normal",
				},
				bounce = {
					max_duration = 500,
					min_duration = 400,
					chars_for_max_duration = 20,
					oscillation_count = 1,
					from_color = "Visual",
					to_color = "Normal",
				},
				left_to_right = {
					max_duration = 350,
					min_duration = 350,
					min_progress = 0.85,
					chars_for_max_duration = 25,
					lingering_time = 50,
					from_color = "Visual",
					to_color = "Normal",
				},
				pulse = {
					max_duration = 600,
					min_duration = 400,
					chars_for_max_duration = 15,
					pulse_count = 2,
					intensity = 1.2,
					from_color = "Visual",
					to_color = "Normal",
				},
				rainbow = {
					max_duration = 600,
					min_duration = 350,
					chars_for_max_duration = 20,
				},
				custom = {
					-- You can also add as many custom options as you want
					-- Only `max_duration` and `chars_for_max_duration` is required
					max_duration = 350,
					chars_for_max_duration = 40,

					color = hl_visual_bg,

					-- Custom effect function
					-- @param self table The effect object
					-- @param progress number The progress of the animation [0, 1]
					--
					-- Should return a color and a progress value
					-- that represents how much of the animation should be drawn
					-- self.settings represents the settings of the animation that you defined above
					effect = function(self, progress)
						return self.settings.color, progress
					end,
				},
				hijack_ft_disabled = {
					"alpha",
					"snacks_dashboard",
				},
			},
			virt_text = {
				priority = 2048,
			},
		})
	end,
}
