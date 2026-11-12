# Module: network

VPC et sous-réseaux sur 2 AZ, Internet Gateway, NAT Gateway et routage.

## Entrées principales

| Variable             | Type         | Description                       |
|----------------------|--------------|-----------------------------------|
| `project_name`       | string       | Préfixe de nommage                |
| `environment`        | string       | dev / test / prod (validée)       |
| `vpc_cidr`           | string       | Bloc principal (validée CIDR)     |
| `public_subnet_cidrs`| list(string) | Subnets publics                   |
| `app_subnet_cidrs`   | list(string) | Subnets privés application        |
| `db_subnet_cidrs`    | list(string) | Subnets privés base de données    |
| `azs`                | list(string) | Zones de disponibilité            |

## Sorties

`vpc_id`, `public_subnet_ids`, `app_subnet_ids`, `db_subnet_ids`,
`nat_gateway_id`, `internet_gateway_id`, `azs`.

## Exemple

```hcl
module "network" {
  source = "../../modules/network"
  project_name = "cloud5"
  environment  = "dev"
  aws_region   = "eu-west-1"
  vpc_cidr     = "10.20.0.0/16"
  public_subnet_cidrs = ["10.20.1.0/24", "10.20.2.0/24"]
  app_subnet_cidrs    = ["10.20.11.0/24", "10.20.12.0/24"]
  db_subnet_cidrs     = ["10.20.21.0/24", "10.20.22.0/24"]
  azs          = ["eu-west-1a", "eu-west-1b"]
}
```
