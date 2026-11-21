# API - Spécification des routes

## Point de santé (Healthcheck)
- **Route** : `GET /health`
- **Description** : Vérifie la disponibilité et l'état de fonctionnement du service
- **Réponse attendue** : HTTP 200 OK
- **Corps de réponse** :
```json
{
  "status": "ok"
}
```

## Gestion des Livres
- **GET `/api`** : Liste tous les livres (HTTP 200)
- **GET `/api/{id}`** : Récupère un livre par son identifiant (HTTP 200)
- **POST `/api`** : Ajoute un nouveau livre (HTTP 200 / 201)
- **PUT `/api`** : Met à jour un livre existant (HTTP 200)
- **DELETE `/api/{id}`** : Supprime un livre par son identifiant (HTTP 200)
- **GET `/api/livrsecriv/{idEcrivain}`** : Liste les livres d'un écrivain (HTTP 200)
