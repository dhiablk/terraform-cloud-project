# Choix de sécurité

## Chaînage des Security Groups

Le trafic est contrôlé par référence aux SG (et non par CIDR) :

1. **ALB** : accepte 80/443 depuis `0.0.0.0/0` (seul composant exposé).
2. **Instances app** : n'acceptent 80 que **depuis le SG de l'ALB**.
3. **RDS** : n'accepte 3306 que **depuis le SG app**. Aucun accès Internet.

## IAM : moindre privilège

- Un seul rôle instance, limité à `AmazonSSMManagedInstanceCore`
  (administration via Session Manager, **sans** clés SSH ni ports ouverts).
- Pas de credentials long terme dans les instances.

## Secrets

- **Aucun secret dans Git** : `terraform.tfvars` est ignoré par `.gitignore`,
  seule la version `terraform.tfvars.example` (sans secret) est versionnée.
- Mot de passe RDS : variable `sensitive`, fournie par le secret store du
  pipeline (`TF_VAR_db_master_password`) ou OIDC + AWS Secrets Manager.
- Pipeline : authentification par **OIDC** (rôle assumé), pas de `AWS_ACCESS_KEY_ID` stocké.

## Données et état

- S3 chiffré (KMS), versioning, blocage total de l'accès public.
- Backend Terraform : bucket S3 chiffré + versioning + `use_lockfile`
  (verrou natif contre les modifications concurrentes).
- RDS : `storage_encrypted`, non public, suppression protégée en prod,
  snapshots automatiques (1 jour dev/test, 14 jours prod).

## Coûts et destruction

- Ressources coûteuses : NAT Gateway (par heure + Go traités), ALB, instances,
  RDS, EIP.
- L'environnement de test est détruit dès la fin de la démonstration :
  `terraform destroy` (ou job dédié du pipeline).
