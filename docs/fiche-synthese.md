# Fiche de synthèse — Projet DevOps L3 DSI (ISET)
**Projet : Livres API** | **Étudiante : Hajer Bahri** | **Dépôt : [github.com/Hajer1406/livres-api](https://github.com/Hajer1406/livres-api)**

---

## 1. Architecture du projet

L'application **Livres API** est une API REST développée avec **Spring Boot 3 / Java 17 LTS** orchestrée avec une base de données **MySQL 8.0** via **Docker Compose** sur un réseau privé bridge isolé (`backend-net`) :

```
[ Navigateur / Client ]  --->  http://localhost:8080/health
                                        |  (-p 8080:8080)
┌───────────────────────────────────────v────────────────────────────────────────┐
│ Réseau privé Docker Compose (staging-net / backend-net)                       │
│                                                                               │
│  ┌───────────────────────────────┐     db:3306     ┌────────────────────────┐ │
│  │ Service API : livres-api      │ ──────────────> │ Service DB : mysql:8.0 │ │
│  │ Image : ghcr.io/...:v1.0.0    │  (port interne) │ Volume : mysql_data    │ │
│  │ Utilisateur : appuser (non-root)               │ Santé : mysqladmin ping│ │
│  └───────────────────────────────┘                 └────────────────────────┘ │
└───────────────────────────────────────────────────────────────────────────────┘
```

- **Sécurité** : Processus conteneurisé exécuté sous l'utilisateur non-root `appuser`. Port 3306 non publié sur l'hôte.
- **Résilience** : Démarrage conditionné à l'état de santé de la base (`condition: service_healthy`).
- **Persistance** : Volume nommé persistant `mysql_data` résistant aux arrêts `docker compose down`.

---

## 2. Version mise en service (Staging)

- **Version immuable** : Tag Git **`v1.0.0`** associé à l'image publiée sur le registre de conteneurs GitHub Packages :
  `ghcr.io/hajer1406/livres-api:v1.0.0`
- **Principe fondamental** : L'image n'est **jamais reconstruite** lors du déploiement. L'environnement de test réutilise l'image validée par la CI.
- **Commande unique de mise en service** :
  ```bash
  printf 'IMAGE_TAG=v1.0.0\n' > .env.deploy
  docker compose --env-file .env.deploy -f compose.staging.yaml up -d
  ./scripts/wait-healthy.sh
  ```

---

## 3. Déroulé du retour arrière (Rollback démontré)

1. **Incident simulé** : Mise en service d'une version applicative défectueuse `v0.9.0` via `.env.deploy`.
2. **Détection automatique** : Échec immédiat du contrôle de santé (`./scripts/wait-healthy.sh` renvoie le code d'erreur 1).
3. **Diagnostic** : Identification dans les journaux (`docker compose logs api`) d'une non-réponse du point `/health`.
4. **Action corrective (Rollback)** : Sans reconstruire aucune image, réactivation de la dernière version saine :
   ```bash
   printf 'IMAGE_TAG=v1.0.0\n' > .env.deploy
   docker compose --env-file .env.deploy -f compose.staging.yaml up -d
   ```
5. **Résultat** : Service rétabli avec succès (HTTP 200 OK) en **moins de 30 secondes** (bien en dessous du seuil exigé de 2 minutes).

---

## 4. Preuves des exécutions CI/CD et Pull Requests

- **Lien du Pipeline CI Réussi (Vert ✅)** :  
  `https://github.com/Hajer1406/livres-api/actions/runs/44962747164` (ou run du tag `v1.0.0` #44967972818)
- **Lien du Pipeline CI en Échec (Rouge ❌)** :  
  `https://github.com/Hajer1406/livres-api/actions/runs/44962468952`
- **Pull Request #1 (Validée et fusionnée)** :  
  `https://github.com/Hajer1406/livres-api/pull/1`
- **Pull Request #2 (En échec pour démonstration soutenance)** :  
  `https://github.com/Hajer1406/livres-api/pull/2`
