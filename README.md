# aks-power-switcher

This GitHub Action starts or stops an Azure Kubernetes Service (AKS) cluster. Save costs by turning off the cluster during non-business hours.

## Inputs

### `action`

**Required** The action to perform on the AKS cluster. Possible values are `start` or `stop`. Default is `"start"`.

## Environment Variables

To use this action, you need to provide the following environment variables:

- **`ARM_CLIENT_ID`**: The Azure Service Principal Client ID.
- **`ARM_CLIENT_SECRET`**: The Azure Service Principal Client Secret.
- **`ARM_TENANT_ID`**: The Azure Tenant ID.
- **`RESOURCE_GROUP`**: The resource group where the AKS cluster is located.
- **`CLUSTER_NAME`**: The name of the AKS cluster to start or stop.

## Example usage

```yaml
jobs:
  power-switch:
    runs-on: ubuntu-latest
    steps:
      - name: Start AKS Cluster
        uses: CiucurDaniel/aks-power-switcher@main
        with:
          action: 'start'
        env:
          ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
          ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
          ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
          RESOURCE_GROUP: "your-resource-group"
          CLUSTER_NAME: "your-cluster-name"
```