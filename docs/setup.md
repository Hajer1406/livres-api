# Guide d'installation et de configuration

## 1. Cloner le projet
```bash
git clone https://github.com/Hajer1406/livres-api.git
cd livres-api
```

## 2. Configuration des variables d'environnement
Copier le fichier d'exemple :
```bash
cp .env.example .env
```
Le fichier `.env` est ignoré par Git et ne doit jamais être commité.

## 3. Démarrage de l'environnement de développement
Pour lancer la pile complète avec Docker Compose :
```bash
docker compose up -d
```

## 4. Vérification
Contrôler que la pile est saine :
```bash
docker compose ps
curl http://localhost:8080/health
```
