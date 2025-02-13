local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-mylyn') {
  settings+: {
    default_repository_permission: "none",
    dependabot_security_updates_enabled_for_new_repositories: false,
    description: "",
    members_can_change_project_visibility: false,
    name: "Eclipse Mylyn",
    packages_containers_internal: false,
    packages_containers_public: false,
    readers_can_create_discussions: true,
    two_factor_requirement: false,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/mylyn/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  secrets+: [
    orgs.newOrgSecret('GITLAB_API_TOKEN') {
      value: "pass:bots/tools.mylyn/gitlab.eclipse.org/api-token",
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      has_discussions: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('mylyn-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "master",
      gh_pages_source_path: "/",
      web_commit_signoff_required: false,
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "master"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('org.eclipse.mylyn') {
      allow_merge_commit: true,
      delete_branch_on_merge: false,
      has_discussions: true,
      web_commit_signoff_required: false,
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('org.eclipse.mylyn.all') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.builds') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.commons') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.context') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.context.mft') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.docs') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      has_discussions: true,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.docs.intent.main') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.docs.vex') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.incubator') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.reviews') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.reviews.ui') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.tasks') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
    orgs.newRepo('org.eclipse.mylyn.versions') {
      archived: true,
      default_branch: "master",
      web_commit_signoff_required: false,
    },
  ],
}
