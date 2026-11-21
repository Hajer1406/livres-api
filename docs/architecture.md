# Architecture du projet Livres API

## Vue d'ensemble

Livres API est conçue selon une architecture multi-conteneurs modulaire et résiliente :

```
VOTRE MACHINE (hôte)
----------------------------------------------------------------
   navigateur / client  --->  localhost:8080
                                   |
                             -p 8080:8080
                                   |
..... RÉSEAU PRIVÉ COMPOSE (invisible depuis l'extérieur) ......
:                          v                                   :
:     +--------------------+        +----------------------+   :
:     |  service  api      | -----> |  service  db         |   :
:     |  livres-api        |  db    |  mysql:8.0           |   :
:     +--------------------+  3306  +----------+-----------+   :
:                                              |               :
:                                      volume  |  mysql_data   :
:                                   +----------v-----------+   :
:                                   |  données persistantes|   :
:                                   +----------------------+   :
................................................................
```

## Composants
1. **Service API (`api`)** :
   - Application Spring Boot 3 / Java 17
   - Écoute sur `0.0.0.0:8080`
   - Utilisateur conteneurisé non-root (`appuser`)
   - Expose le endpoint de santé `/health`
2. **Service Base de données (`db`)** :
   - Moteur MySQL 8.0 officiel
   - Port 3306 accessible uniquement sur le réseau interne privé Compose (port hôte non publié)
   - Données persistées via le volume nommé `mysql_data`
   - Contrôle de santé configuré via `mysqladmin ping`
