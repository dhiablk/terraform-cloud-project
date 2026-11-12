# Module: storage

Bucket S3 versioné, chiffré (KMS), avec blocage total de l'accès public
et règles de cycle de vie.

## Entrées principales

| Variable                | Type   | Description                                |
|-------------------------|--------|--------------------------------------------|
| `bucket_name`           | string | Nom global unique du bucket                |
| `force_destroy`         | bool   | true pour dev/test (facilite le destroy)   |
| `transition_to_ia_days` | number | Transition vers STANDARD_IA (défaut 30)    |

## Sorties

`bucket_id`, `bucket_arn`.

## Exemple

```hcl
module "storage" {
  source       = "../../modules/storage"
  project_name = "cloud5"
  environment  = "dev"
  bucket_name  = "cloud5-dev-assets-123456789012"
  force_destroy = true
}
```
