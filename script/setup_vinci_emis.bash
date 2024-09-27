#!/bin/bash

_vinci_emis() {
    local cur prev opts bin_dir

    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # 定义二进制文件的目录
    bin_dir="${SCRIPT_DIR}../install/bin"

    if [ "$prev" == "run" ]; then
        if [ -d "$bin_dir" ]; then
            # 补全 bin 目录中的文件名
            local files
            files=$(ls "$bin_dir" 2>/dev/null)
            COMPREPLY=($(compgen -W "${files}" -- "$cur"))
        fi
    else
        # 仅补全命令（如 run 和 clean）
        opts="run clean"
        COMPREPLY=($(compgen -W "${opts}" -- "$cur"))
    fi
}

# 获取当前脚本所在目录的绝对路径
SCRIPT_ABS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 设置 LD_LIBRARY_PATH
source ${SCRIPT_ABS_DIR}/../install/.setup.bash

complete -F _vinci_emis ../script/vinci_emis
