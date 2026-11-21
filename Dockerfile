# ============================================================
# Étape 1 — BUILD : compilation Maven dans un conteneur JDK
# ============================================================
FROM eclipse-temurin:17-jdk-alpine AS builder
LABEL stage="builder"

WORKDIR /build

# Copier uniquement le pom.xml en premier pour profiter du cache de couches Maven
COPY pom.xml ./
COPY .mvn/ .mvn/
COPY mvnw ./
RUN chmod +x ./mvnw
# Télécharger les dépendances sans compiler le code (layer cachable)
RUN ./mvnw dependency:go-offline -q

# Copier le code source et compiler (en sautant les tests d'intégration)
COPY src/ src/
RUN ./mvnw package -DskipTests -q && \
    mv target/livres_proj-0.0.1-SNAPSHOT.jar target/app.jar

# ============================================================
# Étape 2 — RUNTIME : image finale légère JRE uniquement
# ============================================================
FROM eclipse-temurin:17-jre-alpine AS runtime

# Métadonnées de l'image (OCI / Atelier 3)
LABEL maintainer="Bahri Hajer <bahrihajer14@gmail.com>"
LABEL org.opencontainers.image.title="livres-api"
LABEL org.opencontainers.image.description="API REST de gestion de bibliothèque — Spring Boot 3 / MySQL"
LABEL org.opencontainers.image.version="1.0.0"

# Utilisateur non-root obligatoire (Atelier 3 - sécurité)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copier uniquement le JAR compilé depuis l'étape builder
COPY --from=builder /build/target/app.jar app.jar

# Changer le propriétaire du fichier vers l'utilisateur non-root
RUN chown appuser:appgroup app.jar

USER appuser

EXPOSE 8080

# HEALTHCHECK : Docker vérifie la santé du conteneur toutes les 30s
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
    CMD wget -qO- http://localhost:8080/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]
