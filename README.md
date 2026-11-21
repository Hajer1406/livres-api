# Livres API

API REST de gestion d'une bibliothèque (livres et écrivains) développée avec Spring Boot 3 et MySQL.
Projet support pour la mise en place d'une chaîne DevOps complète (Licence 3 DSI - ISET).

## Fonctionnalités principales
- Gestion des livres (création, consultation, mise à jour, suppression)
- Association des livres aux écrivains
- Point de contrôle de santé : `GET /health`
- Architecture conteneurisée et orchestrée avec Docker Compose

## Démarrage rapide

### Prérequis
- Docker Engine ou Docker Desktop avec Compose v2
- Git

### Démarrage en une seule commande (Atelier 4)
```bash
docker compose up -d
```
Vérifier la santé du service :
```bash
curl http://localhost:8080/health
```

### Documentation
- [Architecture du projet](file:///docs/architecture.md)
- [Guide d'installation](file:///docs/setup.md)
- [Documentation de l'API](file:///docs/api.md)
