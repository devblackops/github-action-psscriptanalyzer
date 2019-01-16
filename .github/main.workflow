workflow "script-analysis" {
  resolves = ["analyze"]
  on       = "push"
}

workflow "pr-script-analysis" {
  on       = "pull_request"
  resolves = "analyze-pr"
}

action "filter-to-pr-open-synced" {
  uses = "actions/bin/filter@master"
  args = "action 'opened|synchronize'"
}

action "analyze-pr" {
  uses    = "devblackops/github-action-psscriptanalyzer@master"
  needs   = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
}

action "analyze" {
  uses    = "devblackops/github-action-psscriptanalyzer@master"
  secrets = ["GITHUB_TOKEN"]
}