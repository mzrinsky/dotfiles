# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#    Copyright (C) 2016-2020 Chuan Ji <chuan@jichu4n.com>                     #
#                                                                             #
#    Licensed under the Apache License, Version 2.0 (the "License");          #
#    you may not use this file except in compliance with the License.         #
#    You may obtain a copy of the License at                                  #
#                                                                             #
#     http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                             #
#    Unless required by applicable law or agreed to in writing, software      #
#    distributed under the License is distributed on an "AS IS" BASIS,        #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. #
#    See the License for the specific language governing permissions and      #
#    limitations under the License.                                           #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# This is based on the excellent work by Chuan Ji
# https://github.com/jichu4n/fish-command-timer
#
# Who also has a great series on X11 window managers!
#
# This is a much "simplified" (worse), version modified to work with my config.
# You probably want the original?
#
# My modified version lives in my dotfiles..
# https://github.com/mzrinsky/dotfiles
#
# IANAL, however it is my understanding that because the original function came
# from an apache liscensed work, this must also carry that liscense, even if
# modified in some way.
#

function fish_cmd_pre --on-event fish_preexec
	echo -e "\n  "(set_color "$fish_color_gray")"exec started"(set_color "$fish_color_light_gray")" @ "(set_color "$fish_color_gray")(date '+%m/%d/%Y %r')(set_color normal)"\n"
end

function fish_cmd_timer --on-event fish_postexec
	set -l command_end_time (date '+%s')

	set -l SEC 1000
	set -l MIN 60000
	set -l HOUR 3600000
	set -l DAY 86400000

	set -l num_days (math -s0 "$CMD_DURATION / $DAY")
	set -l num_hours (math -s0 "$CMD_DURATION % $DAY / $HOUR")
	set -l num_mins (math -s0 "$CMD_DURATION % $HOUR / $MIN")
	set -l num_secs (math -s0 "$CMD_DURATION % $MIN / $SEC")
	set -l num_millis (math -s0 "$CMD_DURATION % $SEC")

	set -l time_str ""
	if [ $num_days -gt 0 ]
		set time_str {$time_str}{$num_days}"d "
	end
	if [ $num_hours -gt 0 ]
		set time_str {$time_str}{$num_hours}"h "
	end
	if [ $num_mins -gt 0 ]
		set time_str {$time_str}{$num_mins}"m "
	end

	set -l num_millis_pretty ''
	set num_millis_pretty (printf '%03d' $num_millis)

	set time_str (set_color "$fish_color_light_gray")"$time_str""$num_secs"(set_color "$fish_color_gray")"s"(set_color "$fish_color_light_gray")"$num_millis_pretty"

	echo -e "\n  "(set_color "$fish_color_dark_gray")"exec took $time_str"

end

