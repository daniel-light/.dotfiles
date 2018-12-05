function has_cmd {
    which $1 2>&1 > /dev/null
}
