policy "require_tags" {
  source            = "./policies/require_tags.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "deny_public_s3" {
  source            = "./policies/deny_public_s3.sentinel"
  enforcement_level = "hard-mandatory"
}
