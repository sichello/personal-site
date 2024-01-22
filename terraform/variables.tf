variable root_doamin_name {
  type        = string
  default     = "sichello.com"
  description = "Root domain name for the site"
}

variable sichello_R53_zoneId {
  type        = string
  default     = "Z024950516JAD3A13T2XU"
  description = "Zone ID of existing sichello.com R53 hosted zone. Only want to modify existing zone to avoid deletion/recreation"
}
