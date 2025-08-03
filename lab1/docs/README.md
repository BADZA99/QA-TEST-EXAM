# Tests MongoDB avec Robot Framework

Ce projet contient des tests automatisés pour une base de données MongoDB (fakestore) utilisant Robot Framework.

## Requirements

- Python 3.x
- Robot Framework
- pymongo
- re (module standard Python)

Installation des dépendances :
```bash
pip install robotframework
pip install pymongo
```

## Structure du Projet

### 1. Dossier `po` (Page Objects)
- `variable.py` : Contient les variables globales
  ```python
  DB_URI = "mongodb+srv://..."    # URI de connexion MongoDB
  DB_NAME = "fakestore"          # Nom de la base de données
  PRODUCTS_COLLECTION = "products"  # Noms des collections
  USERS_COLLECTION = "users"
  CATEGORIES_COLLECTION = "categories"
  ORDERS_COLLECTION = "orders"
  ```
- `locator.py` : Non utilisé dans ce projet (prévu pour des tests UI)

### 2. Dossier `ressources`
- `mongodb_keywords.py` : Bibliothèque personnalisée pour MongoDB
  - Imports : `pymongo`, `re`
  - Classe principale : `MongoDBLibrary`
  - Fonctionnalités :
    - Validation des documents
    - Opérations CRUD
    - Gestion des connexions
    
- `common.robot` : Mots-clés Robot Framework communs
  - Import : `mongodb_keywords.py`
  - Mots-clés :
    - Connect To DB
    - Disconnect From DB
    - Insert/Find/Update/Delete Document

### 3. Dossier `testcases`
Contient les fichiers de test :
- `mongo_tests.robot` : Tests CRUD pour chaque entité
  - Products
  - Users
  - Categories
  - Orders

### 4. Dossier `results`
Stocke les résultats des tests :
- `log.html` : Logs détaillés
- `report.html` : Rapport de test
- `output.xml` : Données brutes des résultats

### 5. Scripts Utilitaires
- `insert_fakestore_data.py` : Script d'initialisation de la base
  - Import : `pymongo`, `ObjectId`
  - Fonction : Insertion des données initiales dans MongoDB

## Exécution des Tests

### Tests Complets
```bash
robot .\testcases\mongo_tests.robot
```

### Tests Spécifiques

1. Par opération CRUD :
```bash
# Tests de création uniquement
robot --include create .\testcases\mongo_tests.robot
```

2. Par entité :
```bash
# Tests des produits uniquement
robot --include products .\testcases\mongo_tests.robot
```

3. Par résultat attendu :
```bash
# Tests valides uniquement
robot --include valid .\testcases\mongo_tests.robot
```

4. Combinaison de tags :
```bash
# Tests invalides des produits
robot --include "products" --include "invalid" .\testcases\mongo_tests.robot
```

5. Test spécifique :
```bash
# Un seul test
robot -t "Create Product - Valid" .\testcases\mongo_tests.robot
```

## Fichiers Non Utilisés
- `docs/README.md` : Documentation non implémentée
- `test_mongodb_keywords.robot` : Tests de la bibliothèque MongoDB (non maintenus)

## Notes
- Les tests peuvent être exécutés individuellement ou en groupe grâce aux tags
- Chaque test est documenté avec son comportement attendu (✓ DOIT PASSER ou ✗ DOIT ÉCHOUER)
- Les résultats des tests sont générés dans le dossier `results`
