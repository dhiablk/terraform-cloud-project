# Module: compute

Launch Template (Amazon Linux 2023 + nginx) et Auto Scaling Group
attaché au target group de l'ALB.

## Entrées principales

| Variable               | Type         | Description                             |
|------------------------|--------------|-----------------------------------------|
| `app_subnet_ids`       | list(string) | >= 2 subnets privés app (validée)       |
| `app_security_group_id`| string       | SG des instances                        |
| `instance_profile_name`| string       | Profil IAM                              |
| `target_group_arn`     | string       | Target group de l'ALB                   |
| `instance_type`        | string       | Type d'instance (défaut `t3.micro`)     |
| `min_size` / `max_size`| number       | Capacité ASG (min >= 2, validée)        |
| `user_data`            | string       | Script base64 (page nginx + hostname)   |

## Sorties

`asg_name`, `asg_arn`, `launch_template_id`, `ami_id`.

## Exemple

```hcl
module "compute" {
  source = "../../modules/compute"
  project_name          = "cloud5"
  environment           = "dev"
  instance_type         = "t3.micro"
  app_subnet_ids        = module.network.app_subnet_ids
  app_security_group_id = module.security.app_security_group_id
  instance_profile_name = module.security.instance_profile_name
  target_group_arn      = module.load_balancer.target_group_arn
  min_size              = 2
  max_size              = 4
  user_data             = filebase64("${path.module}/../../scripts/user_data.sh")
}
```
