# Compte rendu d'incident et procédure de retour arrière (Rollback)

## 1. Description de l'incident
Lors de la mise en service d'une version applicative v0.9.0 en environnement de test (staging), le conteneur `api` a démarré mais le service est resté inaccessible. L'incident a été détecté immédiatement par l'échec du contrôle de santé (`./scripts/wait-healthy.sh`).

## 2. Diagnostic et analyse des journaux
La première erreur utile relevée dans les journaux Docker (`docker compose logs api`) indiquait une incapacité du service à répondre sur le point de santé HTTP `/health` (code de retour différent de 200).

## 3. Action corrective : Retour arrière immédiat (Rollback)
Conformément aux principes DevOps de l'Atelier 5, aucune reconstruction d'image n'a été tentée en urgence :
1. Mise à jour de la variable de déploiement vers la dernière version immuable et saine : `IMAGE_TAG=v1.0.0` dans `.env.deploy`.
2. Relance instantanée de la pile : `docker compose --env-file .env.deploy -f compose.staging.yaml up -d`.
3. Validation du retour arrière par `./scripts/wait-healthy.sh` qui confirme le rétablissement en moins de 2 minutes.

## 4. Bilan et prévention
- **Temps d'indisponibilité** : 1 minute 45 secondes.
- **Mesure préventive** : Rendre obligatoire la validation automatique du pipeline CI et les tests d'intégration avant toute publication de tag de version.
