function prj() {
    local USAGE="Usage: prj project [workspace]"

    local project="$1"

    if [[ "$project" = "" ]]; then
        echo $USAGE
        return 1
    fi

    local package="$2"

    if [[ $package == "" ]]; then
        run "cd $PERSONAL_PROJECT_ROOT/$project"
    else
        shift
        run "cd $PERSONAL_PROJECT_ROOT/$project/packages/$package"
    fi
}