# create a temporary markdown file in ~/tmp
function tmp () {
  if [[ -n $1 ]]; then
    # replace spaces, tabs, etc. with dash
    local CLEAN=${1//[[:space:]]/-}
    # now, clean out anything that's not alphanumeric or a dash
    CLEAN=${CLEAN//[^a-zA-Z0-9-]/}
    hx ~/tmp/${CLEAN}.md
  fi
}

