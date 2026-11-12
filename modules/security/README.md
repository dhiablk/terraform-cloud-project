# Module: security

Security Groups chaînés (ALB → app → db) et rôle IAM instance moindre privilège.

## Entrées principales

| Variable      | Type   | Description                       |
|---------------|--------|-----------------------------------|
| `project_name`| string | Préfixe de nommage                |
| `environment` | string | dev / test / prod                 |
| `vpc_id`      | string | VPC cible                         |
| `vpc_cidr`    | string | CIDR du VPC                       |

## Sorties

`alb_security_group_id`, `app_security_group_id`, `db_security_group_id`,
`instance_profile_name`.

## Règles implémentées

- ALB : 80/443 depuis Internet (seul composant exposé).
- app : 80 **uniquement depuis le SG ALB**.
- db : 3306 **uniquement depuis le SG app**.
- IAM : rôle EC2 limité à SSM (`AmazonSSMManagedInstanceCore`).

## Exemple

```hcl
module "security" {
  source = "../../modules/security"
  project_name = "cloud5"
  environment  = "dev"
  vpc_id       = module.network.vpc_id
  vpc_cidr     = "10.20.0.0/16"
}
```
