# my fish prompt..
# lives with my dotfiles at..
# https://github.com/mzrinsky/dotfiles
function fish_prompt
  set --local ret_status $status
  set --local now_time (date '+%m/%d/%Y %r')
  echo -e "\n  "(set_color "$fish_color_dark_gray")"new prompt "(set_color "$fish_color_light_gray")"@"(set_color "$fish_color_gray")" $now_time\n"
  set -l realhome ~
  set -l cdir (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)
  echo -e (set_color ffffff)"@"(set_color $fish_color_host)"$hostname"(set_color "bcbcbc")": "(set_color "$fish_color_cwd")"$cdir"
	set_color ffffff
  echo -n '⮞'
  set_color 00d7ff
  echo -n '⮞'
  if test "$ret_status" -eq 0
    # show success color
    set_color 00ff5f
  else
    # show error color
    set_color ff005f
  end
  echo -n '⮞ '
  set_color normal
end
