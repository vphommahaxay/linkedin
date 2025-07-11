
-- MBA ESG - Évaluation Architecture Big Data
-- Projet : Analyse des Offres d’Emploi LinkedIn avec Snowflake
-- Script complet de préparation de l’environnement et chargement des données

-- 1. Initialisation : Entrepôt, base, schéma
CREATE OR REPLACE WAREHOUSE my_wh WAREHOUSE_SIZE = XSMALL;
USE WAREHOUSE my_wh;

CREATE OR REPLACE DATABASE linkedin;
USE DATABASE linkedin;

CREATE OR REPLACE SCHEMA linkedin_schema;
USE SCHEMA linkedin_schema;

-- 2. Définition des formats de fichiers
CREATE OR REPLACE FILE FORMAT csv_format
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1;

CREATE OR REPLACE FILE FORMAT json_format
    TYPE = 'JSON';

-- 3. Création du stage pour accès aux fichiers S3
CREATE OR REPLACE STAGE linkedin_stage
URL = 's3://snowflake-lab-bucket/';

-- 4. Création des tables

CREATE OR REPLACE TABLE job_postings (
  job_id STRING,
  company_name STRING,
  title STRING,
  description STRING,
  max_salary FLOAT,
  pay_period STRING,
  formatted_work_type STRING,
  location STRING,
  applies INT,
  original_listed_time TIMESTAMP,
  remote_allowed BOOLEAN,
  views INT,
  job_posting_url STRING,
  application_url STRING,
  application_type STRING,
  expiry TIMESTAMP,
  closed_time TIMESTAMP,
  formatted_experience_level STRING,
  skills_desc STRING,
  listed_time TIMESTAMP,
  posting_domain STRING,
  sponsored BOOLEAN,
  work_type STRING,
  currency STRING,
  compensation_type STRING
);

CREATE OR REPLACE TABLE benefits (
  job_id STRING,
  inferred BOOLEAN,
  type STRING
);

CREATE OR REPLACE TABLE companies (
  company_id STRING,
  name STRING,
  description STRING,
  company_size INT,
  state STRING,
  country STRING,
  city STRING,
  zip_code STRING,
  address STRING,
  url STRING
);

CREATE OR REPLACE TABLE employee_counts (
  company_id STRING,
  employee_count INT,
  follower_count INT,
  time_recorded BIGINT
);

CREATE OR REPLACE TABLE job_skills (
  job_id STRING,
  skill_abr STRING
);

CREATE OR REPLACE TABLE job_industries (
  job_id STRING,
  industry_id STRING
);

CREATE OR REPLACE TABLE company_specialities (
  company_id STRING,
  speciality STRING
);

CREATE OR REPLACE TABLE company_industries (
  company_id STRING,
  industry STRING
);

-- 5. Chargement des données depuis le bucket public

COPY INTO job_postings
FROM @linkedin_stage/job_postings.csv
FILE_FORMAT = (FORMAT_NAME = csv_format);

COPY INTO benefits
FROM @linkedin_stage/benefits.csv
FILE_FORMAT = (FORMAT_NAME = csv_format);

COPY INTO companies
FROM @linkedin_stage/companies.json
FILE_FORMAT = (FORMAT_NAME = json_format);

COPY INTO employee_counts
FROM @linkedin_stage/employee_counts.csv
FILE_FORMAT = (FORMAT_NAME = csv_format);

COPY INTO job_skills
FROM @linkedin_stage/job_skills.csv
FILE_FORMAT = (FORMAT_NAME = csv_format);

COPY INTO job_industries
FROM @linkedin_stage/job_industries.json
FILE_FORMAT = (FORMAT_NAME = json_format);

COPY INTO company_specialities
FROM @linkedin_stage/company_specialities.json
FILE_FORMAT = (FORMAT_NAME = json_format);

COPY INTO company_industries
FROM @linkedin_stage/company_industries.json
FILE_FORMAT = (FORMAT_NAME = json_format);
