//Bounce between 0.0 -> 1.0 with a wee pause at 0.0 and 1.0
shader_depth = clamp(abs(((current_time/3000) mod 2.4) - 1.2) - 0.1, 0.0, 1.0);