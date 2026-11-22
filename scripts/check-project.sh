#!/usr/bin/env bash
set -u

errors=0
required=(README.md .gitignore .env.example docs/architecture.md docs/api.md docs/setup.md pom.xml compose.yaml compose.staging.yaml)

echo "[CHECK] Livres API - Contrôles automatiques du projet"

# 1. Vérification de la présence des fichiers indispensables
for file in "${required[@]}"; do
  if [[ -f "$file" ]]; then
    echo "[OK] Fichier présent : $file"
  else
    echo "[ERREUR] Fichier obligatoire manquant : $file" >&2
    errors=$((errors + 1))
  fi
done

# 2. Vérification qu'aucun fichier .env contenant des secrets n'est suivi par Git
if git ls-files | grep -Eq '(^|/)\.env$'; then
  echo "[ERREUR] Fichier sensible .env suivi par Git !" >&2
  errors=$((errors + 1))
else
  echo "[OK] Aucun fichier .env suivi par Git"
fi

# 3. Défi final Atelier 2 : Garde-fou sur les modifications non validées
# Permet de bloquer la livraison si du code n'a pas été commité proprement
if [[ -n $(git status --porcelain) ]]; then
  echo "[AVERTISSEMENT] Modifications non validées présentes dans le répertoire de travail :" >&2
  git status --short >&2
  # En mode strict (passé par la CI avec --strict), cela compte comme une erreur
  if [[ "${1:-}" == "--strict" ]]; then
    errors=$((errors + 1))
  fi
else
  echo "[OK] Répertoire de travail propre (aucun travail non validé)"
fi

# 4. Code de sortie final
if [[ $errors -gt 0 ]]; then
  echo "[ÉCHEC] $errors erreur(s) détectée(s)" >&2
  exit 1
fi

echo "[SUCCÈS] Tous les contrôles du projet sont validés (Code 0)"
exit 0
