function prj() {
    local USAGE="Usage: prj [project package]"

    if [[ $1 == "-h" || $1 == "--help" ]]; then
        echo $USAGE
        return
    fi

    local project="$1"
    local package="$2"

    if [[ "$project" = "" ]]; then
        run "cd $PROJECT_ROOT_PERSONAL/$project"
        return
    fi

    if [[ $package == "" ]]; then
        run "cd $PROJECT_ROOT_PERSONAL/$project"
    else
        shift
        run "cd $PROJECT_ROOT_PERSONAL/$project/packages/$package"
    fi
}
