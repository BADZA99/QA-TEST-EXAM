# Tests d'Interface Utilisateur - Customer Service Portal

Ce projet contient des tests automatisés pour l'interface utilisateur du Customer Service Portal utilisant Robot Framework et Selenium.

## Requirements

- Python 3.x
- Robot Framework
- SeleniumLibrary
- Chrome WebDriver

Installation des dépendances :
```bash
pip install robotframework
pip install robotframework-seleniumlibrary
```

## Structure du Projet

### 1. Dossier `po` (Page Objects)
- `variable.py` : Contient les localisateurs et variables globales
  ```python
  # URLs
  URL = "https://automationplayground.com/crm/"
  
  # Login Page
  USERNAME_FIELD = "id:email-id"
  PASSWORD_FIELD = "id:password"
  # ...autres localisateurs
  ```
- `locator.py` : Fichier prévu pour une future séparation des localisateurs (non utilisé actuellement)

### 2. Dossier `ressources`
- `common.robot` : Mots-clés Robot Framework réutilisables
  - Import : SeleniumLibrary
  - Mots-clés principaux :
    - Open CRM Website
    - Login To CRM
    - Fill Customer Form
    - Submit/Cancel Customer Form

### 3. Dossier `testcases`
Contient les fichiers de test basés sur le document "Customer Service Test Cases" :
- `ui_tests.robot` : Implémente les cas de test suivants :
  1. Home page should load (ID: 1001)
  2. Login should succeed (ID: 1002)
  3. Login should fail (ID: 1003)
  4. Remember me checkbox (ID: 1003b)
  5. Logout functionality (ID: 1004)
  6. Display customers (ID: 1005)
  7. Add new customer (ID: 1006)
  8. Cancel new customer (ID: 1007)

### 4. Dossier `results`
Stocke les résultats des tests :
- `log.html` : Logs détaillés avec captures d'écran
- `report.html` : Rapport de test synthétique
- `output.xml` : Données brutes des résultats
- `selenium-screenshot-*.png` : Captures d'écran en cas d'échec

## Exécution des Tests

### Tests Complets
```bash
robot .\testcases\ui_tests.robot
```

### Tests par Catégorie

1. Tests de fumée (smoke tests) :
```bash
robot --include smoke .\testcases\ui_tests.robot
```

2. Tests de connexion :
```bash
robot --include login .\testcases\ui_tests.robot
```

3. Tests de gestion des clients :
```bash
robot --include customers .\testcases\ui_tests.robot
```

4. Tests fonctionnels :
```bash
robot --include functional .\testcases\ui_tests.robot
```

### Test Spécifique
```bash
# Exécuter un test par son nom
robot -t "Test 1001: Home Page Should Load" .\testcases\ui_tests.robot
```

## Organisation des Tests

Chaque test suit la structure suivante :
1. Documentation claire de l'objectif
2. Tags pour catégorisation
3. Étapes selon le document de référence
4. Vérifications appropriées

Exemple :
```robot
Test 1001: Home Page Should Load
    [Documentation]    Vérifie que la page d'accueil se charge correctement
    [Tags]    smoke    home
    Wait Until Page Contains    Customers Are Priority One!
    Page Should Contain    Sign In
```

## Bonnes Pratiques Implémentées

1. **Structure Page Object** :
   - Séparation des localisateurs dans `variable.py`
   - Mots-clés réutilisables dans `common.robot`

2. **Gestion des Tests** :
   - Setup et Teardown pour chaque test
   - Timeouts et délais appropriés
   - Capture d'écran automatique en cas d'échec

3. **Documentation** :
   - Tests documentés avec [Documentation]
   - Tags pour une meilleure organisation
   - Messages d'erreur explicites

4. **Maintenance** :
   - Localisateurs centralisés
   - Variables pour les données de test
   - Structure modulaire

## Fichiers Non Utilisés
- `docs/README.md` était vide avant cette mise à jour
- `locator.py` prévu pour une future séparation des localisateurs

## Notes
- Les tests sont basés sur le document "Customer Service Test Cases"
- La suite couvre les fonctionnalités principales : connexion, gestion des clients
- Chaque test est tagué pour une exécution sélective
- Les captures d'écran sont générées automatiquement en cas d'échec
