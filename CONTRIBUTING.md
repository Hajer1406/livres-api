# Règles de contribution - Livres API

Pour contribuer au projet Livres API, chaque développeur doit respecter les règles DevOps suivantes :

1. **Isolation des modifications** : Ne jamais pousser directement sur `main`. Créer une branche dédiée nommée `feature/nom` ou `fix/nom`.
2. **Contrôles locaux préalables** : Exécuter `./scripts/check-project.sh` et `./mvnw test` avant de publier la branche.
3. **Pull Request obligatoire** : Ouvrir une Pull Request vers `main`. Le pipeline CI GitHub Actions doit être entièrement validé (vert) avant toute fusion.
4. **Sécurité des données** : Aucun secret, mot de passe ni fichier `.env` réel ne doit être versionné.
