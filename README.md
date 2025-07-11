
# 📊 MBA ESG - Évaluation Architecture Big Data

## 🎯 Sujet : Analyse des Offres d’Emploi LinkedIn avec Snowflake

Ce projet a pour objectif de démontrer la capacité à manipuler, structurer et analyser un jeu de données LinkedIn en utilisant Snowflake, en lien avec les compétences acquises en Architecture Big Data.

---

## 📁 Structure du livrable

- `MBAESG_EVALUATION_ARCHITECTURE_BIGDATA.sql`  
  Script SQL unique contenant :
  - Création de l'entrepôt, base et schéma
  - Définition des formats de fichiers
  - Création des tables
  - Chargement des données via `COPY INTO` depuis un bucket S3 public

---

## 🛠️ Technologies utilisées

- **Snowflake** : entrepôt de données cloud pour la création des structures et l’ingestion de données
- **S3 Public Bucket** : source de fichiers CSV et JSON utilisés
- **SQL** : langage utilisé pour le traitement et la modélisation

---

## 🔄 Étapes automatisées dans le script

1. Création de l'entrepôt `my_wh`
2. Création de la base de données `linkedin` et du schéma `linkedin_schema`
3. Création des formats de fichiers CSV et JSON
4. Définition d’un `STAGE` externe vers le bucket S3
5. Création des 8 tables relationnelles
6. Chargement complet des données à l’aide de `COPY INTO`

---

## 👤 Réalisé par

Nom : [À compléter]  
Groupe : [À compléter]  
Binôme : [Oui / Non]  

---

## 📨 Livraison

Ce fichier fait partie du livrable à envoyer à l’adresse suivante :  
**axel@logbrain.fr**  
avec pour objet :  
`MBAESG_EVALUATION_ARCHITECTURE_BIGDATA`

