resource "random_string" "token_id" {
  length  = 8
  special = false
  upper   = false
}
resource "random_string" "token_secret" {
  length  = 16
  special = false
  upper   = false
}
