resource "azurerm_resource_group" "example" {
  name     = "rg-learn-migrate-terraform-provider"
  location = "Southeast Asia"
}

resource "azurerm_service_plan" "example" {
  name                = "asp-learn-migrate-terraform-provider"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Windows"

  sku_name = "F1"
}

resource "azurerm_windows_web_app" "example" {
  name                = "app-learn-migrate-terraform-provider"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    always_on  = false
    ftps_state = "FtpsOnly"

    virtual_application {
      physical_path = "site\\wwwroot"
      preload       = false
      virtual_path  = "/"
    }
  }
}
