# 🏥 ClinicManager

> Application web **Java EE (Jakarta EE)** multicouche pour automatiser et fiabiliser la gestion d'une clinique : patients, médecins, disponibilités, rendez-vous sans conflit et notes médicales sécurisées.

![Java](https://img.shields.io/badge/Java-17%2B-orange)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-yellow)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791)
![Hibernate](https://img.shields.io/badge/Hibernate-6.x-59666C)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED)
![Tests](https://img.shields.io/badge/Tests-JUnit%205%20%2B%20Mockito-green)

**Auteur :** Abdelhafid Belfqir
**Référentiel :** Concepteur·rice développeur·se d'applications (2023)
**Période :** 28/09/2026 → 09/10/2026 (10 jours, travail individuel)
 
---

## 📑 Table des matières

1. [Contexte et vision](#-contexte-et-vision)
2. [Fonctionnalités](#-fonctionnalités)
3. [Stack technique](#-stack-technique)
4. [Architecture](#-architecture)
5. [Structure du projet](#-structure-du-projet)
6. [Modèle de données](#-modèle-de-données)
7. [Règles métier critiques](#-règles-métier-critiques)
8. [Sécurité et rôles](#-sécurité-et-rôles)
9. [Prérequis](#-prérequis)
10. [Installation et lancement avec Docker](#-installation-et-lancement-avec-docker)
11. [Configuration](#-configuration)
12. [Lancement sans Docker](#-lancement-sans-docker-optionnel)
13. [Base de données et script SQL](#-base-de-données-et-script-sql)
14. [Tests](#-tests)
15. [Comptes de démonstration](#-comptes-de-démonstration)
16. [Scénarios principaux](#-scénarios-principaux)
17. [Workflow Git et Jira](#-workflow-git-et-jira)
18. [Plan de réalisation (19 phases)](#-plan-de-réalisation-19-phases)
19. [Bonus](#-bonus)
20. [Dépannage](#-dépannage)
21. [Livrables](#-livrables)
22. [Critères de performance visés](#-critères-de-performance-visés)
---

## 🎯 Contexte et vision

La clinique fait face à des **erreurs de planification manuelle**, des **conflits d'horaires** et un **manque de traçabilité des soins**. ClinicManager centralise la gestion :

- des patients ;
- des médecins ;
- des spécialités et départements ;
- des disponibilités et absences ;
- des rendez-vous ;
- des notes médicales.
  L'objectif est une application **structurée, maintenable et testable**, respectant une architecture multicouche stricte et découplée.

---

## ✨ Fonctionnalités

### 👤 Patient
- Inscription, connexion, gestion du profil et changement de mot de passe
- Prise de rendez-vous : spécialité → médecin → date → créneau → type → motif
- Consultation, modification, replanification et annulation de ses rendez-vous
- Consultation de l'historique médical
### 🩺 Médecin
- Dashboard et agenda personnel
- Gestion des disponibilités et des absences
- Consultation des rendez-vous
- Création et validation des notes médicales (après un rendez-vous `DONE`)
### 🛠️ Administrateur
- Gestion des patients, médecins, utilisateurs
- Gestion des départements et spécialités
- Dashboard
### 🗂️ Staff
- Planning global, rendez-vous, replanification, liste d'attente
---

## 🧰 Stack technique

| Couche | Technologie |
|---|---|
| Langage | Java 17+ (`java.time`, `Optional`, Streams) |
| Plateforme | Jakarta EE 10 (Servlet 6, JSP 3, JSTL 3) |
| Serveur | Apache Tomcat 10.1 |
| Persistance | JPA 3.1 / Hibernate 6 (`EntityManager`, JPQL) |
| Base de données | PostgreSQL 16 |
| Build | Maven (packaging WAR) |
| Tests | JUnit 5, Mockito |
| Conteneurisation | Docker, Docker Compose |
| Versioning / Gestion de projet | Git + GitHub, Jira (Agile) |

> ⚠️ **Tomcat 10+ impose les packages `jakarta.*`** (et non `javax.*`). Toutes les dépendances doivent être alignées Jakarta EE 10.
 
---

## 🏛️ Architecture

Architecture multicouche, **étanche** : chaque couche ne dépend que de la couche immédiatement inférieure.

```
┌──────────────────────────┐
│     JSP / JSTL (vue)     │   affiche uniquement des DTO
└────────────┬─────────────┘
             ▼
┌──────────────────────────┐
│   Servlets (controller)  │   HTTP, validation des entrées, session
└────────────┬─────────────┘
             ▼
┌──────────────────────────┐
│   Services (métier)      │   règles de gestion, transactions
└────────────┬─────────────┘
             ▼
┌──────────────────────────┐
│   Repositories (accès)   │   JPQL / EntityManager
└────────────┬─────────────┘
             ▼
┌──────────────────────────┐
│   JPA / Hibernate        │
└────────────┬─────────────┘
             ▼
        PostgreSQL
```

### Principes appliqués
- **SOLID** et séparation des responsabilités (interfaces `Repository` / `Service`, injection par constructeur).
- **DTO + Mapper** : les JSP ne manipulent **jamais** les entités JPA.
  `Entity → Mapper → DTO → Servlet → JSP`
- **Exceptions métier** dédiées, traduites en messages utilisateur par les servlets.
- **Transactions** gérées côté Service (begin / commit / rollback via `EntityManager`).
- **Java Time** (`LocalDate`, `LocalTime`, `LocalDateTime`) et `Optional` partout.
- **Filters** pour l'authentification et l'autorisation par rôle.
---

## 📁 Structure du projet

```
clinic-manager/
├── pom.xml
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env.example
├── README.md
├── docs/                          # cahier des charges, diagrammes UML/MCD
├── db/
│   └── init.sql                   # schéma + données de démo
│
├── src/main/java/com/clinicmanager/
│   ├── model/                     # entités JPA + enums
│   ├── dto/                       # objets de transfert vers la vue
│   ├── mapper/                    # Entity <-> DTO
│   ├── repository/                # interfaces + implémentations JPA
│   ├── service/                   # logique métier
│   ├── controller/                # Servlets
│   ├── filter/                    # AuthFilter, RoleFilter
│   ├── exception/                 # exceptions métier
│   └── util/                      # JPAUtil, PasswordUtil, etc.
│
├── src/main/resources/
│   └── META-INF/persistence.xml
│
├── src/main/webapp/
│   ├── META-INF/context.xml       # DataSource JNDI (pool JDBC)
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   └── views/                 # JSP protégées (inaccessibles directement)
│   ├── css/
│   ├── auth/
│   ├── patient/
│   ├── doctor/
│   ├── staff/
│   └── admin/
│
└── src/test/java/                 # JUnit 5 + Mockito
```
 
---

## 🗃️ Modèle de données

### Entités principales
`User`, `Patient`, `Doctor`, `Department`, `Specialty`, `Availability`, `Appointment`, `MedicalNote`

### Relations clés

```
Department 1 ────── * Specialty
Specialty  1 ────── * Doctor
Doctor     1 ────── * Availability
Doctor     1 ────── * Appointment * ────── 1 Patient
Appointment 1 ───── 0..1 MedicalNote
User       1 ────── 0..1 Patient | Doctor   (selon le rôle)
```

### Enums
| Enum | Valeurs |
|---|---|
| `Role` | `ADMIN`, `DOCTOR`, `PATIENT`, `STAFF` |
| `AppointmentType` | `CONSULTATION`, `FOLLOW_UP`, `URGENT` |
| `AppointmentStatus` | `PLANNED`, `DONE`, `CANCELED` |
| `NoteStatus` | `DRAFT`, `VALIDATED` (lecture seule) |
| `Gender`, `BloodGroup`, `DayOfWeek` (java.time) | — |

### Attributs principaux
- **Patient** : CIN, nom, prénom, date de naissance, genre, adresse, téléphone, groupe sanguin
- **Doctor** : matricule (unique), nom, prénom, titre, email, téléphone, spécialité, département
- **Availability** : médecin, jour, heure début/fin, statut, période de validité
- **Appointment** : patient, médecin, date/heure, type, statut, motif
- **MedicalNote** : médecin, rendez-vous, diagnostic, contenu, date, statut
---

## 📏 Règles métier critiques

### Authentification
- Email **unique** · mot de passe **≥ 6 caractères** (stocké **haché**, jamais en clair)
- Compte désactivé → connexion interdite
### Génération des créneaux (`TimeSlotService`)

| Paramètre | Valeur |
|---|---|
| Durée d'un rendez-vous | 30 min |
| Buffer entre rendez-vous | 5 min |
| Lead time minimum | 2 h |
| Pause déjeuner | 12:00 → 13:00 |
| Dimanche | Fermé |

Les créneaux générés **excluent** : congés, absences, rendez-vous existants, pause déjeuner et créneaux trop proches.

### Rendez-vous (`AppointmentService`)
Un rendez-vous :
- doit être **dans une disponibilité** du médecin ;
- ne doit **pas chevaucher** un autre rendez-vous ;
- doit respecter le **lead time de 2 h** ;
- ne peut être **annulé par le patient que ≥ 12 h avant** ;
- **reste dans l'historique** après annulation (statut `CANCELED`, pas de suppression).
  Chaîne de validation à la création :
```
Vérifier patient → médecin → disponibilité → conflit → délai → créer (PLANNED)
```

### Notes médicales (`MedicalNoteService`)
- Création possible uniquement sur un rendez-vous **`DONE`** (interdit sur `PLANNED`)
- Une note **validée** devient **READ ONLY** → `MedicalNoteLockedException` en cas de modification
### Exceptions métier
`UserNotFoundException`, `DoctorNotFoundException`, `AppointmentNotFoundException`, `AppointmentConflictException`, `UnavailableSlotException`, `DuplicateEmailException`, `DuplicateMatriculeException`, `MedicalNoteLockedException`, `UnauthorizedActionException`
 
---

## 🔐 Sécurité et rôles

Sécurisation via **HttpSession + Filters + rôles**.

| URL | Rôle requis |
|---|---|
| `/admin/*` | `ADMIN` |
| `/doctor/*` | `DOCTOR` |
| `/patient/*` | `PATIENT` |
| `/staff/*` | `STAFF` |
| `/auth/*` | Public |

Bonnes pratiques mises en œuvre :
- JSP sensibles placées sous `WEB-INF/views/` (accès uniquement via Servlet)
- Régénération de l'ID de session à la connexion (anti *session fixation*)
- Invalidation de la session à la déconnexion
- Hachage des mots de passe (BCrypt recommandé)
- Un utilisateur n'accède qu'aux fonctionnalités de son rôle ; un patient ne voit que **ses** données
---

## ✅ Prérequis

**Pour lancer avec Docker (recommandé) :**
- [Docker](https://docs.docker.com/get-docker/) ≥ 24
- [Docker Compose](https://docs.docker.com/compose/) v2 (`docker compose`)
- Git
  **Pour développer hors Docker (optionnel) :**
- JDK 17+, Maven 3.9+, Tomcat 10.1, PostgreSQL 16
---

## 🐳 Installation et lancement avec Docker

### 1. Cloner le dépôt

```bash
git clone https://github.com/<votre-utilisateur>/clinic-manager.git
cd clinic-manager
```

### 2. Configurer l'environnement

```bash
cp .env.example .env
```

Contenu de `.env.example` :

```env
# --- PostgreSQL ---
POSTGRES_DB=clinicdb
POSTGRES_USER=clinic
POSTGRES_PASSWORD=change_me_please
DB_HOST=db
DB_PORT=5432
 
# --- Application ---
APP_PORT=8080
TZ=Africa/Casablanca
```

> 🔒 Ne jamais committer le fichier `.env` (il figure dans `.gitignore`).

### 3. Fichiers Docker

**`Dockerfile`** (build multi-étapes : Maven → Tomcat)

```dockerfile
# ---------- Étape 1 : build du WAR ----------
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -B -q dependency:go-offline
COPY src ./src
RUN mvn -B clean package -DskipTests
 
# ---------- Étape 2 : runtime Tomcat ----------
FROM tomcat:10.1-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/clinic-manager.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

**`docker-compose.yml`**

```yaml
services:
  db:
    image: postgres:16-alpine
    container_name: clinic-db
    restart: unless-stopped
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      TZ: ${TZ}
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./db/init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 5s
      timeout: 5s
      retries: 10
    networks:
      - clinic-net
 
  app:
    build: .
    container_name: clinic-app
    restart: unless-stopped
    depends_on:
      db:
        condition: service_healthy
    ports:
      - "${APP_PORT}:8080"
    environment:
      TZ: ${TZ}
      CATALINA_OPTS: >-
        -DDB_HOST=${DB_HOST}
        -DDB_PORT=${DB_PORT}
        -DDB_NAME=${POSTGRES_DB}
        -DDB_USER=${POSTGRES_USER}
        -DDB_PASSWORD=${POSTGRES_PASSWORD}
    networks:
      - clinic-net
 
  # Optionnel : interface d'administration de la base
  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: clinic-pgadmin
    profiles: ["tools"]
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@clinic.local
      PGADMIN_DEFAULT_PASSWORD: admin
    ports:
      - "5050:80"
    depends_on:
      - db
    networks:
      - clinic-net
 
volumes:
  pgdata:
 
networks:
  clinic-net:
```

**`.dockerignore`**

```
target/
.git/
.idea/
.vscode/
*.iml
.env
```

### 4. Construire et démarrer

```bash
docker compose up -d --build
```

Suivre les logs :

```bash
docker compose logs -f app
```

### 5. Accéder à l'application

| Service | URL |
|---|---|
| Application | http://localhost:8080 |
| pgAdmin (optionnel) | http://localhost:5050 (`docker compose --profile tools up -d`) |

### 6. Commandes utiles

```bash
docker compose ps                     # état des conteneurs
docker compose logs -f app            # logs Tomcat
docker compose restart app            # redémarrer l'application
docker compose down                   # arrêter (données conservées)
docker compose down -v                # arrêter ET supprimer la base (reset complet)
docker compose exec db psql -U clinic -d clinicdb   # console PostgreSQL
docker compose build --no-cache app   # rebuild complet
```
 
---

## ⚙️ Configuration

### `src/main/webapp/META-INF/context.xml` — DataSource et pool JDBC

Les variables `${DB_*}` sont résolues par Tomcat depuis les propriétés système (`CATALINA_OPTS`).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context>
  <Resource name="jdbc/ClinicDB"
            auth="Container"
            type="javax.sql.DataSource"
            driverClassName="org.postgresql.Driver"
            url="jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}"
            username="${DB_USER}"
            password="${DB_PASSWORD}"
            maxTotal="20"
            maxIdle="10"
            minIdle="2"
            maxWaitMillis="10000"
            validationQuery="SELECT 1"
            testOnBorrow="true"/>
</Context>
```

### `src/main/resources/META-INF/persistence.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<persistence xmlns="https://jakarta.ee/xml/ns/persistence"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="https://jakarta.ee/xml/ns/persistence
                                 https://jakarta.ee/xml/ns/persistence/persistence_3_0.xsd"
             version="3.0">
 
  <persistence-unit name="clinicPU" transaction-type="RESOURCE_LOCAL">
    <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>
    <non-jta-data-source>java:comp/env/jdbc/ClinicDB</non-jta-data-source>
 
    <properties>
      <property name="hibernate.dialect" value="org.hibernate.dialect.PostgreSQLDialect"/>
      <property name="hibernate.hbm2ddl.auto" value="validate"/>
      <property name="hibernate.show_sql" value="false"/>
      <property name="hibernate.format_sql" value="true"/>
    </properties>
  </persistence-unit>
</persistence>
```

> 💡 `validate` : le schéma est créé par `db/init.sql`, Hibernate vérifie seulement la cohérence. Pendant le développement, `update` est possible, mais à éviter en rendu final.

### `web.xml` (points clés)
- Déclaration des **Filters** (`AuthFilter`, `RoleFilter`) et de leurs mappings
- `session-config` (timeout, cookie `HttpOnly`)
- Pages d'erreur (`404`, `500`, exceptions)
- `welcome-file-list`
---

## 💻 Lancement sans Docker (optionnel)

```bash
# 1. Créer la base
createdb -U postgres clinicdb
psql -U postgres -d clinicdb -f db/init.sql
 
# 2. Définir les variables de connexion
export CATALINA_OPTS="-DDB_HOST=localhost -DDB_PORT=5432 -DDB_NAME=clinicdb -DDB_USER=clinic -DDB_PASSWORD=change_me_please"
 
# 3. Construire le WAR
mvn clean package
 
# 4. Déployer sur Tomcat 10.1
cp target/clinic-manager.war $CATALINA_HOME/webapps/ROOT.war
$CATALINA_HOME/bin/catalina.sh run
```
 
---

## 🗄️ Base de données et script SQL

Le script `db/init.sql` est exécuté **automatiquement au premier démarrage** du conteneur PostgreSQL (volume vide). Il contient :

- la création des tables, clés primaires/étrangères et contraintes (`UNIQUE` email, matricule) ;
- les index (recherche par médecin + date, par patient) ;
- les données de référence (départements, spécialités) ;
- des comptes et données de démonstration.
  Pour **rejouer** le script :

```bash
docker compose down -v && docker compose up -d --build
```
 
---

## 🧪 Tests

Tests unitaires avec **JUnit 5** et **Mockito** (repositories mockés).

```bash
mvn test                       # en local
docker run --rm -v "$PWD":/app -w /app maven:3.9-eclipse-temurin-17 mvn -B test   # via Docker
```

### Couverture ciblée

| Service | Cas testés |
|---|---|
| `AppointmentService` | rendez-vous valide · conflit · médecin indisponible · délai insuffisant · annulation interdite (< 12 h) · modification |
| `TimeSlotService` | génération des créneaux · exclusion des rendez-vous · exclusion des congés · exclusion de la pause |
| `MedicalNoteService` | note sur `DONE` · note interdite sur `PLANNED` · modification interdite après validation |

Rapport de couverture (optionnel, JaCoCo) :

```bash
mvn verify      # rapport dans target/site/jacoco/index.html
```
 
---

## 👥 Comptes de démonstration

> À adapter selon le contenu de `db/init.sql`. **À supprimer / changer en production.**

| Rôle | Email | Mot de passe |
|---|---|---|
| ADMIN | `admin@clinic.local` | `admin123` |
| DOCTOR | `doctor@clinic.local` | `doctor123` |
| STAFF | `staff@clinic.local` | `staff123` |
| PATIENT | `patient@clinic.local` | `patient123` |
 
---

## 🎬 Scénarios principaux

**1. Prise de rendez-vous**
`Patient → Login → Spécialité → Médecin → Date → Créneaux affichés → Choix du créneau → Vérifications → Rendez-vous PLANNED`

**2. Consultation**
`Médecin → Agenda → Rendez-vous → Consultation terminée (DONE) → Création de la note → VALIDATED (lecture seule)`

**3. Annulation**
`Patient → Mes rendez-vous → Choix du rendez-vous → Vérification délai ≥ 12 h → CANCELED`
 
---

## 🌿 Workflow Git et Jira

### Organisation Jira (Agile)
- Backlog découpé en **Epics** (ex. Authentification, Disponibilités, Rendez-vous, Notes, Sécurité, Tests, Docker) et **User Stories** avec **critères d'acceptation** clairs
- Suivi sur tableau **Kanban/Scrum** (`To Do → In Progress → Review → Done`)
- Chaque ticket est **lié à une branche Git**
### Stratégie de branches

```
main            ← version stable livrable
└── develop     ← intégration
    ├── feature/CM-12-auth-login
    ├── feature/CM-25-timeslot-generation
    ├── fix/CM-40-cancel-12h-rule
    └── chore/CM-50-docker-setup
```

### Convention de commits (Conventional Commits)

```
feat(appointment): empêche le chevauchement de rendez-vous [CM-31]
fix(auth): refuse la connexion d'un compte désactivé [CM-14]
test(timeslot): couvre l'exclusion de la pause déjeuner [CM-27]
docs(readme): ajoute la section Docker
chore(docker): ajoute le healthcheck PostgreSQL
```
 
---

## 🗺️ Plan de réalisation (19 phases)

| # | Phase | Contenu |
|---|---|---|
| 1 | Authentification & Utilisateurs | Inscription, login, session, profil |
| 2 | Gestion des patients | Profil, historique, CRUD admin |
| 3 | Gestion des médecins | Matricule unique, agenda |
| 4 | Spécialités & Départements | Relation 1–N |
| 5 | Disponibilités & Créneaux | Génération automatique |
| 6 | Rendez-vous | Création, modification, annulation, replanification |
| 7 | Notes médicales | Création, validation, lecture seule |
| 8 | Architecture & Persistance | Entités, repositories |
| 9 | Services & Règles métier | Logique, transactions |
| 10 | Interface web | JSP/JSTL par rôle |
| 11 | Sécurité & Autorisation | Filters, rôles |
| 12 | DTO, Mapper & Exceptions | Isolation de la vue |
| 13 | Tests | JUnit 5 / Mockito |
| 14 | Livrables | WAR, SQL, README |
| 15 | Docker | Dockerfile, Compose, déploiement reproductible |
| 16 | Jira & Git | Backlog, branches, PR |
| 17 | Documentation | UML, MCD, README |
| 18 | Bonus (optionnel) | Liste d'attente, emails, rappels, stats |
| 19 | Préparation soutenance | Démo, justification d'architecture |

> Les intitulés des phases 15 à 19 sont indicatifs : adaptez-les au découpage exact du cahier des charges officiel.
 
---

## ⭐ Bonus

- [ ] **Bonus 1** — Liste d'attente automatique
- [ ] **Bonus 2** — Notification email de confirmation
- [ ] **Bonus 3** — Rappel 24 h avant le rendez-vous
- [ ] **Bonus 4** — Dashboard avec statistiques
---

## 🩹 Dépannage

| Problème | Cause probable / Solution |
|---|---|
| `ClassNotFoundException: javax.servlet...` | Mauvais namespace : utiliser `jakarta.*` avec Tomcat 10+ |
| `Cannot create PoolableConnectionFactory` | Base non prête ou identifiants erronés → vérifier `.env` et `docker compose logs db` |
| `Name [jdbc/ClinicDB] is not bound` | `context.xml` absent du WAR (doit être dans `src/main/webapp/META-INF/`) |
| Driver PostgreSQL introuvable | Mettre le driver dans `WEB-INF/lib` ou copier le JAR dans `$CATALINA_HOME/lib` |
| `Schema-validation: missing table` | `init.sql` non exécuté → `docker compose down -v && docker compose up -d --build` |
| Port 8080 déjà utilisé | Changer `APP_PORT` dans `.env` |
| Modifications non prises en compte | `docker compose up -d --build` (rebuild de l'image) |
| Variables `${DB_*}` non remplacées | Vérifier `CATALINA_OPTS` dans `docker-compose.yml` |
| Erreur 404 sur une JSP | Les JSP sous `WEB-INF/views/` s'atteignent uniquement via une Servlet (`forward`) |
 
---

## 📦 Livrables

- [x] Projet Maven
- [x] Code source complet sur GitHub (organisé et documenté)
- [x] Base PostgreSQL + script SQL (`db/init.sql`)
- [x] `persistence.xml` et `context.xml`
- [x] Tests JUnit 5 / Mockito
- [x] `Dockerfile` et `docker-compose.yml`
- [x] README et documentation
- [x] WAR déployable sur Tomcat (`target/clinic-manager.war`)
- [x] Dépôt Git avec historique cohérent
---

## 🏆 Critères de performance visés

- **Jira (Agile)** : Epics/US avec critères d'acceptation, tableau à jour, tickets liés aux branches Git
- **Architecture & découplage** : étanchéité JSP → Servlet → Service → Repository, isolation par DTO/Mappers
- **Clean Code & robustesse** : SOLID, Java Time, `Optional`, exceptions métier rigoureuses
- **Jakarta EE** : MVC web, cycle de vie des Servlets/Filters, sessions sécurisées, persistance transactionnelle JPA/Hibernate
- **Tomcat** : déploiement WAR sans erreur, `web.xml` propre, `context.xml` (DataSource/pool JDBC), classpath isolé sous `WEB-INF`
### 🎤 Soutenance (45 min) — points à préparer
1. Démo live : parcours patient, planning médecin, validation d'une note
2. Justification de l'architecture découplée (JSP → Servlet → Service → JPA)
3. Règles critiques : génération des créneaux, conflits, annulation < 12 h
4. Transactions et persistance
5. Revue du code Java 17+ et exécution des tests JUnit 5 / Mockito
---

## 📄 Licence

Projet pédagogique — usage éducatif uniquement.
 
---

<p align="center">Réalisé avec ☕ par <strong>Abdelhafid Belfqir</strong> — ClinicManager © 2026</p>
