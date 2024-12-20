local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('tools.windowbuilder', 'eclipse-windowbuilder') {
  settings+: {
    blog: "https://www.eclipse.org/windowbuilder/",
    description: "A powerful, easy-to-use, bi-directional Java GUI designer.",
    email: "wb-dev@eclipse.org",
    name: "Eclipse WindowBuilder™",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/windowbuilder/github-webhook/') {
      content_type: "json",
      events+: [
        "issue_comment",
        "pull_request",
        "push"
      ],
    },
    orgs.newOrgWebhook('https://ci.eclipse.org/windowbuilder/ghprbhook/') {
      content_type: "json",
      events+: [
        "issue_comment",
        "pull_request",
        "push"
      ],
    },
  ],
  secrets+: [
    orgs.newOrgSecret('GITLAB_API_TOKEN') {
      value: "pass:bots/tools.windowbuilder/gitlab.eclipse.org/api-token",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('windowbuilder') {
      allow_merge_commit: true,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Eclipse Windowbuilder",
      has_discussions: true,
      homepage: "https://projects.eclipse.org/projects/tools.windowbuilder",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('windowbuilder-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('windowbuilder-website-source') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
  ],
}
