# Azure Sentiment Analysis Infra

This project is use to deploy my Sentiment Analysis application on Azure.
I use the App Service to deploy my container, to benefit the auto scaling capabilities, waiting the [Azure Container Apps](https://azure.microsoft.com/en-us/services/container-apps/#features) avaibilities through [terraform](https://github.com/hashicorp/terraform-provider-azurerm/issues/14122)

![deployment status](https://github.com/rtrompier/azure-sentiment-analysis-infra/actions/workflows/container_deploy.yml/badge.svg)


## How to use

There is a Github Action allow me to deploy and undeploy my resource to the Azure cloud.
This actions are triggered manually.