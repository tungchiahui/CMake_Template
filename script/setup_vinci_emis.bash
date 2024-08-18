#!/bin/bash

_vinci_emis() {
    local cur prev opts run_temp_dir

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 定义二进制文件的目录
    run_temp_dir="${SCRIPT_DIR}../install/bin/run_temp"


    if [ "$prev" == "run" ]; then
        if [ -d "$run_temp_dir" ]; then
            # 补全 run_temp 目录中的文件名
            local files
            files=$(ls "$run_temp_dir" 2>/dev/null)
            COMPREPLY=($(compgen -W "${files}" -- "$cur"))
        fi
    else
        # 仅补全命令（如 run）
        opts="run"
        COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
    fi
}

complete -F _vinci_emis ../script/vinci_emis
