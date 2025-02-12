resource "pingdom_check" "manage-recalls" {
  type                     = "http"
  name                     = "manage-recalls - PROD"
  host                     = "manage-recalls.hmpps.service.justice.gov.uk"
  resolution               = 1
  notifywhenbackup         = true
  sendnotificationwhendown = 6
  notifyagainevery         = 0
  url                      = "/"
  encryption               = true
  port                     = 443
  tags                     = "hmpps,ppud-replacement,manage-recalls,prod,isproduction_true,cloudplatform-managed"
  probefilters             = "region:EU"
  integrationids           = [116724]
}

resource "pingdom_check" "manage-recalls-ui-health" {
  type                     = "http"
  name                     = "manage-recalls-ui /health - PROD"
  host                     = "manage-recalls.hmpps.service.justice.gov.uk"
  resolution               = 1
  notifywhenbackup         = true
  sendnotificationwhendown = 6
  notifyagainevery         = 0
  url                      = "/health"
  encryption               = true
  port                     = 443
  tags                     = "hmpps,ppud-replacement,manage-recalls,prod,isproduction_true,cloudplatform-managed"
  probefilters             = "region:EU"
  integrationids           = [116724]
}

resource "pingdom_check" "manage-recalls-api-health" {
  type                     = "http"
  name                     = "manage-recalls-api /health - PROD"
  host                     = "manage-recalls-api.hmpps.service.justice.gov.uk"
  resolution               = 1
  notifywhenbackup         = true
  sendnotificationwhendown = 6
  notifyagainevery         = 0
  url                      = "/health"
  encryption               = true
  port                     = 443
  tags                     = "hmpps,ppud-replacement,manage-recalls,prod,isproduction_true,cloudplatform-managed"
  probefilters             = "region:EU"
  integrationids           = [116724]
}
