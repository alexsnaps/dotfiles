# shellcheck shell=bash

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
# Arguments passed to tmux-mem-cpu-load.
# See https://github.com/thewtex/tmux-mem-cpu-load for all available options.
# export TMUX_POWERLINE_SEG_TMUX_MEM_CPU_LOAD_ARGS="${TMUX_POWERLINE_SEG_TMUX_MEM_CPU_LOAD_ARGS}"
EORC
	echo "$rccontents"
}

run_segment() {
	read -r -a args <<<"$TMUX_POWERLINE_SEG_TMUX_POMODORO_PLUS"
	stats=""
	if type "$TMUX_PLUGIN_MANAGER_PATH/tmux-pomodoro-plus/scripts/pomodoro.sh" >/dev/null 2>&1; then
		stats=$("$TMUX_PLUGIN_MANAGER_PATH/tmux-pomodoro-plus/scripts/pomodoro.sh" "${args[@]}")
	else
		return 0
	fi

	if [ -n "$stats" ]; then
		echo "$stats"
	fi
	return 0
}
