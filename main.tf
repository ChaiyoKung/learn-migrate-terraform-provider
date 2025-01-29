resource "azurerm_resource_group" "example" {
  name     = "rg-learn-migrate-terraform-provider"
  location = "Southeast Asia"
}

resource "azurerm_app_service_plan" "example" {
  name                = "asp-learn-migrate-terraform-provider"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "app-learn-migrate-terraform-provider"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id
}
