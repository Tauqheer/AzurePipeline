# Azure Pipeline for Hourly Dataset Processing

## Overview

This Azure pipeline is designed to automate the process of pulling hourly datasets through API extracting DESO crypto every hour against USD, pushing them to Azure Blob Storage, loading into an Azure Synapse SQL Pool, creating a view, and presenting the data on a web application.

## Pipeline Steps

1. **Pulling Hourly Datasets**:
   - Description: Fetches hourly datasets from an external source - https://api.coinbase.com/v2/exchange-rates and this is packed into a docker container
   - Tools/Services Used: Custom data retrieval Bash script,Docker and Azure container Instances with Logical Apps.

2. **Pushing to Azure Blob Storage**:
   - Description: Uploads the retrieved datasets to Azure Blob Storage for storage and further processing converts the file from json to csv.
   - Tools/Services Used: Azure Blob Storage.

3. **Loading into Azure Synapse SQL Pool**:
   - Description: Transfers the datasets from Azure Blob Storage to Azure Synapse SQL Pool for data warehousing and analytics.
   - Tools/Services Used: Azure Synapse SQL Pool,Azure Synapse Analytics and Azure Functions.

4. **Creating View in Azure Synapse SQL Pool**:
   - Description: Defines a SQL view to extract DESO Currency value against USD from loaded datasets and pushed back to blob storage.
   - Tools/Services Used: SQL script executed in Azure Synapse SQL Pool and Azure Functions.

5. **Presenting Data on Web Application**:
   - Description: Displays the extracted data on a web application for user consumption.
   - Tools/Services Used: HTML, Azure App Service, or Azure Functions.
   - https://azulstorage1.z30.web.core.windows.net/

## Issues Faced

1. **Issue 1**:
   - Description: Ansible not working on azure cli and Azure vms(Missing modules)
   - Resolution: Had to build things through the UI and download the templates which could be used to automate if required. Tried building a pipeline through azure devops but the request was rejected multiple times for parallelism.
   - https://github.com/MicrosoftDocs/azure-dev-docs/issues/1316
   - https://stackoverflow.com/questions/66335800/error-couldnt-resolve-module-action-this-often-indicates-a-misspelling-miss

2. **Issue 2**:
   - Description: Docker image built on Mac - Architecture issue as mac docker loads with arm64 and container instances in azure supports only amd64
   - Resolution: Had to spin an ubuntu VM and install docker and build a new image.
     
3. **Issue 3**:
   - Description: Docker image built on Mac - Architecture issue as docker on Mac loads with arm64 and container instances in azure supports only amd64
   - Resolution: Had to spin an ubuntu VM and install docker and build a new image.

