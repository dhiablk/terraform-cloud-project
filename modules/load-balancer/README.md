# Module: load-balancer

Application Load Balancer public, target group avec health checks, listener HTTP.

## Entrées principales

| Variable                | Type         | Description                        |
|-------------------------|--------------|------------------------------------|
| `vpc_id`                | string       | VPC cible                          |
| `public_subnet_ids`     | list(string) | >= 2 subnets publics (validée)     |
| `alb_security_group_id` | string       | SG de l'ALB                        |
| `health_check_path`     | string       | Chemin du health check (défaut `/`)|

## Sorties

`alb_dns_name` (URL publique), `target_group_arn`, `listener_arn`.

## Exemple

```hcl
module "load_balancer" {
  source = "../../modules/load-balancer"
  project_name          = "cloud5"
  environment           = "dev"
  vpc_id                = module.network.vpc_id
  public_subnet_ids     = module.network.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
}
```
