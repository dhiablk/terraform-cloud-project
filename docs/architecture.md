# Architecture

Vue d'ensemble de la plateforme déployée par Terraform.

```
                       Internet
                          |
                          v
                  +--------------+
                  |     ALB      |   Security Group: ALB (80/443)
                  +------+-------+
                         | HTTP
        +----------------+----------------+
        |                                 |
 +------v------+                   +------v------+
 | App instance|                   | App instance|   SG: app (80 depuis SG ALB)
 |  (AZ a)     |                   |  (AZ b)     |   SG: app (80 depuis SG ALB)
 +------+------+                   +------+------+
        |  Auto Scaling Group (min 2, max 4)
        |
 +------v-----------------------------+
 |            RDS MySQL               |   SG: db (3306 depuis SG app)
 |   subnets privés db (AZ a, AZ b)   |   non accessible depuis Internet
 +------------------------------------+

 Sortie privée : NAT Gateway (subnet public A) -> IGW
 Stockage      : S3 (versioning + chiffrement + blocage accès public)
 Etat Terraform: S3 backend (chiffrement, versioning, use_lockfile)
```

## Composants par module

| Module    | Ressources                                                                 |
|-----------|----------------------------------------------------------------------------|
| network   | VPC, 2 subnets publics, 2 privés app, 2 privés db, IGW, NAT, tables de routage |
| security  | SG ALB, SG app (chainé), SG db (chainé), rôle IAM moindre privilège + instance profile |
| load-balancer | ALB, target group (health check `/`), listener HTTP                     |
| compute   | Launch Template (AL2023 + nginx), Auto Scaling Group, rattachement au target group |
| database  | DB subnet group, RDS MySQL (chiffré, non public, Multi-AZ en prod)         |
| storage   | S3 versioné, chiffré, blocage public, cycle de vie                         |

## Haute disponibilité

- Deux zones de disponibilité à chaque couche (ALB, instances, RDS).
- ASG avec health check ELB : une instance défaillante est remplacée automatiquement.
- RDS Multi-AZ en prod.
