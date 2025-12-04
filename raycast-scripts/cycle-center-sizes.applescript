#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Cycle Center Sizes
# @raycast.mode silent
# @raycast.packageName Window Management

tell application "Finder" to get bounds of window of desktop
set {d_left, d_top, d_right, d_bottom} to bounds of window of desktop

# 1. Force Screen Dimensions to Integers
set d_width to (d_right - d_left) as integer
set d_height to (d_bottom - d_top) as integer

tell application "System Events"
	set frontApp to first application process whose frontmost is true
	tell frontApp
		set frontWindow to value of attribute "AXFocusedWindow"
		set {w_w, w_h} to size of frontWindow
		
		# 2. Calculate Ratio
		set widthRatio to w_w / d_width
		
		# Define target widths (Integers)
		set widthOneThird to (d_width * (1 / 3)) as integer
		set widthHalf to (d_width * 0.5) as integer
		set widthTwoThirds to (d_width * (2 / 3)) as integer
		
		# 3. LOGIC: 1/3 -> 1/2 -> 2/3 -> 1/3
		if (widthRatio > 0.30) and (widthRatio < 0.36) then
			set newWidth to widthHalf
		else if (widthRatio > 0.45) and (widthRatio < 0.55) then
			set newWidth to widthTwoThirds
		else
			set newWidth to widthOneThird
		end if
		
		# 4. Calculate Center Position (Round to nearest integer)
		set newX to (d_left + ((d_width - newWidth) / 2)) as integer
		
		# 5. MAXIMIZED HEIGHT CALCULATION
		# We start Y at 'd_top + 25' to sit exactly under the Menu Bar.
		# We set Height to 'd_height - 25' to fill the rest of the screen exactly.
		
		set menuBarHeight to 25
		set safeY to (d_top + menuBarHeight) as integer
		set maximizedHeight to (d_height - menuBarHeight) as integer
		
		# 6. Apply Changes
		set position of frontWindow to {newX, safeY}
		set size of frontWindow to {newWidth, maximizedHeight}
		
	end tell
end tell

