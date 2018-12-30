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
  uses    = "./analyze"
  needs   = "filter-to-pr-open-synced"
  secrets = ["GITHUB_TOKEN"]
}

action "analyze" {
  uses    = "./analyze"
  secrets = ["GITHUB_TOKEN"]
}