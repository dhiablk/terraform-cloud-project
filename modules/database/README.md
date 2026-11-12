# Module: database

RDS MySQL chiffré dans un DB subnet group privé, non accessible depuis Internet.

## Entrées principales

| Variable               | Type         | Description                              |
|------------------------|--------------|------------------------------------------|
| `db_subnet_ids`        | list(string) | >= 2 subnets db (validée)                |
| `db_security_group_id` | string       | SG db (3306 depuis SG app)               |
| `db_instance_class`    | string       | Classe RDS (défaut `db.t3.micro`)        |
| `db_master_password`   | string       | **sensitive** — fournie par le secret store |
| `multi_az`             | bool         | Multi-AZ pour prod                       |

## Sorties

`rds_endpoint`, `rds_port`, `rds_arn`.

## Exemple

```hcl
module "database" {
  source = "../../modules/database"
  project_name         = "cloud5"
  environment          = "dev"
  db_subnet_ids        = module.network.db_subnet_ids
  db_security_group_id = module.security.db_security_group_id
  db_instance_class    = "db.t3.micro"
  db_master_password   = var.db_master_password   # TF_VAR_db_master_password
}
```
