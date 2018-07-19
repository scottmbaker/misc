# NOTE: add this to .bashrc
preexec () { echo "2" | sudo tee /proc/sys/vm/drop_caches > /dev/null; }
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing                                                                       
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND                                   
    local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
    preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG
