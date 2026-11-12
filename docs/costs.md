# Estimation des coûts (dev, eu-west-1, ~2h de démonstration puis destroy)

| Ressource                    | Dimension                | Prix unitaire (approx.) | Coût 2h |
|------------------------------|--------------------------|------------------------:|--------:|
| t3.micro (x2, ASG)           | 2 instances              | ~0,0104 $/h             | ~0,04 $ |
| ALB                          | 1                        | ~0,0225 $/h + LCU       | ~0,05 $ |
| NAT Gateway                  | 1                        | ~0,045 $/h + Go         | ~0,09 $ |
| EIP NAT                      | 1 (associée)             | gratuit si attachée     | 0 $     |
| db.t3.micro RDS              | 1, mono-AZ               | ~0,017 $/h              | ~0,03 $ |
| S3 (assets/logs)             | < 1 Go                   | ~0,023 $/Go/mois        | ~0,01 $ |
| **Total démonstration**      |                          |                         | **~0,25 $** |

## Points de vigilance

- **NAT Gateway** : le poste le plus cher en continu (~32 $/mois). À détruire
  hors démonstration.
- RDS Multi-AZ (prod) double le coût de la base.
- Un ASG laissé en place régénère les instances : toujours `destroy` après usage.

## Réduction

- dev : `min_size = max_size = 2`, mono-AZ RDS, `force_destroy = true` sur S3.
- Destruction systématique en fin de séance (documentée dans le README).
