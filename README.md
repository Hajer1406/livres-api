# Livres API

API REST de gestion d'une bibliothèque (livres et écrivains) développée avec **Spring Boot 3 / Java 17 LTS** et **MySQL 8.0**.  
Projet individuel de fin de module — Chaîne DevOps complète (Licence 3 DSI - ISET).

---

## 🚀 Démarrage en une seule commande

### Prérequis
- Docker Desktop ou Docker Engine avec Compose v2

### Lancement de l'environnement de développement (Atelier 4)
```bash
docker compose up -d
```
Vérifier la santé du service :
```bash
curl http://localhost:8080/health
```

### Lancement de l'environnement de test Staging (Atelier 5)
```bash
printf 'IMAGE_TAG=v1.0.0\n' > .env.deploy
docker compose --env-file .env.deploy -f compose.staging.yaml up -d
./scripts/wait-healthy.sh
```

---

## 📋 Livrables du Guide Étudiant

1. **[Fiche de synthèse d'une page](file:///docs/fiche-synthese.md)** : Architecture, version mise en service et déroulé du retour arrière (Rollback).
2. **[Compte rendu d'incident et procédure de Rollback](file:///docs/incident.md)** : Démonstration de l'incident et rétablissement en moins de 2 minutes.
3. **[Architecture détaillée](file:///docs/architecture.md)** : Schéma multi-conteneurs Compose, réseau privé et persistance.
4. **[Spécification de l'API](file:///docs/api.md)** : Documentation des routes REST et du point `/health`.
5. **[Guide d'installation](file:///docs/setup.md)** : Procédure de configuration pas à pas.
6. **[Règles de contribution](file:///CONTRIBUTING.md)** : Workflow Git et bonnes pratiques d'équipe.

---

## 🔗 Liens du Pipeline CI/CD et Pull Requests (GitHub Actions)

- **Exécution réussie (Vert ✅)** : [Run #44962747164](https://github.com/Hajer1406/livres-api/actions/runs/44962747164)
- **Exécution en échec (Rouge ❌)** : [Run #44962468952](https://github.com/Hajer1406/livres-api/actions/runs/44962468952)
- **Pull Request #1 (Validée & fusionnée)** : [PR #1](https://github.com/Hajer1406/livres-api/pull/1)
- **Pull Request #2 (En échec pour démonstration soutenance)** : [PR #2](https://github.com/Hajer1406/livres-api/pull/2)
- **Image Docker publiée sur GHCR** : `ghcr.io/hajer1406/livres-api:v1.0.0`
