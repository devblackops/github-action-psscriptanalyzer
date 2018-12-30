workflow "PSScriptAnalyzer" {
  resolves = ["analyze"]
  on       = "push"
}

action "analyze" {
  uses    = "./analyze"
  secrets = ["GITHUB_TOKEN"]
}