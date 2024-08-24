terraform {
  backend "gcs" {
    bucket = "home-infra-92553705-7610-4966-a615-4c6a87d6dcae"
    prefix = "terraform"
  }
}