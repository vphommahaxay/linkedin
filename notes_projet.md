
# Notes de projet

## Problèmes rencontrés et solutions apportées

### Problème 1 – Incohérence entre la structure du fichier CSV et la table `job_postings`

Lors de la tentative de chargement du fichier `job_postings.csv` depuis le bucket S3, une erreur est survenue indiquant que la table `job_postings` contenait 25 colonnes, alors que le fichier CSV en comptait 27.

**Solution apportée :**  
Nous avons téléchargé manuellement le fichier depuis l’adresse suivante :  
https://snowflake-lab-bucket.s3.amazonaws.com/job_postings.csv

Après analyse du contenu dans un tableur, nous avons identifié deux colonnes manquantes dans notre script de création de table : `min_salary` et `med_salary`.  
Nous avons donc mis à jour la définition de la table `job_postings` en y ajoutant ces deux colonnes, ce qui a permis de résoudre le problème et de charger les données correctement.

---

### Problème 2 – Importation des fichiers JSON

L’importation des fichiers JSON (notamment `companies.json`, `job_industries.json`, etc.) posait problème, contrairement aux fichiers CSV qui se chargeaient facilement. Le chargement direct dans des tables relationnelles échouait systématiquement.

**Solution apportée :**  
Nous avons adopté une stratégie en deux étapes :

1. Création d’une table temporaire contenant une seule colonne de type `VARIANT` permettant de stocker le contenu brut du fichier JSON.
2. Utilisation de la commande `COPY INTO` pour charger les données JSON dans cette table intermédiaire.
3. Transformation des données à l’aide d’une requête `SELECT`, en extrayant les éléments utiles vers une table cible structurée.
4. Suppression de la table temporaire après traitement, afin de maintenir un environnement propre.

Cette méthode nous a permis de contourner les limites du chargement direct de fichiers JSON et de structurer les données de manière exploitable.

---

### Problème 3 – Difficulté de jointure sur la colonne `company_name`

Lors de la phase d’analyse, nous avons constaté que la colonne `company_name` de la table `job_postings` ne contenait pas le nom réel de l’entreprise, mais un identifiant numérique. De plus, cet identifiant était au format décimal (par exemple `123456.0`), ce qui empêchait toute correspondance avec la colonne `company_id` de la table `companies`, enregistrée au format chaîne.

**Solution apportée :**  
Nous avons appliqué une conversion en chaîne de caractères à l’aide de la fonction `TRY_CAST(... AS STRING)` et nettoyé les valeurs afin de supprimer la partie décimale `.0`.  
Cette opération a permis de normaliser les identifiants et de restaurer la possibilité de faire des jointures fiables entre les tables `job_postings` et `companies`.
