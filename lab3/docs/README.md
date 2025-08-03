# Lab 3 : Tests d'APIs REST – Intégration avec eBay

Ce projet contient des tests d'intégration avec l'API eBay Fulfillment.

## Structure du Projet

```
lab3/
├── docs/                  # Documentation du projet
│   └── README.md         # Ce fichier
├── po/                   # Page Objects
│   └── variable.py       # Variables et données de test pour l'API
├── ressources/
│   ├── common.robot      # Keywords communs pour les tests API
│   └── setup_test_data.py # Script de configuration des données de test
└── testcases/
    └── api_tests.robot   # Tests des endpoints de l'API eBay
```

## Fichiers Supprimés
- `locator.py` : Non nécessaire pour les tests d'API
- `test_api.py` : Remplacé par api_tests.robot

## Description des Fichiers

### variable.py
Contient :
- Configuration de l'API (URL, credentials)
- Données de test (IDs, payloads)
- Headers pour les requêtes
- Endpoints de l'API

### common.robot
Contient les keywords réutilisables pour :
- Création de session eBay
- Envoi de requêtes API
- Vérification des réponses

### setup_test_data.py
Script pour :
- Génération du token OAuth
- Création de données de test dans le Sandbox
- Mise à jour des variables de test

### api_tests.robot
Tests des endpoints de l'API eBay Fulfillment.

#### Tests et Résultats Attendus

1. createShippingFulfillment :
   ```
   Scénario Passant :
   - Input : Données valides de fulfillment
   - Attendu : Code 201 + Location header (ou 400 en Sandbox)
   
   Scénario Non Passant :
   - Input : Payload invalide
   - Attendu : Code 400/500 avec message d'erreur
   ```

2. getShippingFulfillment :
   ```
   Scénario Passant :
   - Input : IDs valides
   - Attendu : Code 200 + données du fulfillment (ou 400 en Sandbox)
   
   Scénario Non Passant :
   - Input : ID fulfillment invalide
   - Attendu : Code 404 avec message d'erreur
   ```

3. getShippingFulfillments :
   ```
   Scénario Passant :
   - Input : ID commande valide
   - Attendu : Code 200 + liste des fulfillments (ou 400 en Sandbox)
   
   Scénario Non Passant :
   - Input : ID commande invalide
   - Attendu : Code 404 avec message d'erreur
   ```

## Exécution des Tests

1. Installation des dépendances :
```bash
pip install robotframework robotframework-requests requests
```

2. Exécution de tous les tests :
```bash
robot testcases/api_tests.robot
```

3. Exécution des tests positifs uniquement :
```bash
robot --include positive testcases/api_tests.robot
```

## Note sur l'Environnement Sandbox

En environnement Sandbox, les réponses peuvent différer :
- Code 400 avec "Invalid Order Id" pour les requêtes sur des commandes test
- Code 500 pour certains payloads invalides

Ces comportements sont gérés dans les tests via la variable SANDBOX_MODE.
