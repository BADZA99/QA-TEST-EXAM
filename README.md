# Projet Test Automation avec Robot Framework - ISI GL 2025 G1

Ce dépôt contient une suite de tests automatisés développés avec Robot Framework pour la startup e-commerce Looma. Le projet est divisé en quatre laboratoires distincts, chacun couvrant un aspect différent du test logiciel.

## Structure du Projet

```
├── lab1/               # Tests MongoDB
├── lab2/               # Tests UI Customer Service
├── lab3/               # Tests API eBay
├── lab4/               # Tests Mobile (APK Looma)
└── README.md
```

## Laboratoires

### Lab 1 : Tests MongoDB

Tests automatisés sur une base de données MongoDB hébergée sur MongoDB Atlas.

- **Objectif** : Automatisation des tests CRUD
- **Scénarios** : 
  - 1 scénario passant
  - 2 scénarios non passants
  pour chaque opération CRUD
- **Base de données** : fakeStoreDB
- **Documentation API** : [FakeStore API](https://fakestoreapi.com/docs)

### Lab 2 : Tests UI Customer Service

Tests fonctionnels de l'interface utilisateur sur l'application CRM.

- **Application** : https://automationplayground.com/crm/index.html
- **Base** : Document "Customer Service Test Cases"
- **Objectif** : Automatisation des cas de test fonctionnels

### Lab 3 : Tests API eBay

Tests d'intégration avec l'API Fulfillment d'eBay.

- **API** : [eBay Fulfillment API](https://developer.ebay.com/api-docs/sell/fulfillment/resources/methods)
- **Opérations testées** :
  - createShippingFulfillment
  - getShippingFulfillment
  - getShippingFulfillments
- **Scénarios** :
  - 1 scénario passant
  - 1 scénario non passant
  pour chaque opération

### Lab 4 : Tests Mobile

Tests automatisés de l'application mobile Looma.

- **Application** : looma.apk
- **Fonctionnalités testées** :
  - Authentification
  - Création et affichage de produits
- **Bonus Innovation (+2 points)** : Implémentation sans utilisation de XPath
- **Technologie suggérée** : [Flutter Driver](https://github.com/appium-userland/appium-flutter-driver)

## Bonnes Pratiques Implémentées

1. **Architecture du Projet**
   - Structure Page Object Model (POM)
   - Séparation des locators et variables
   - Organisation modulaire des tests

2. **Documentation**
   - README détaillé pour chaque laboratoire
   - Documentation des scénarios de test
   - Instructions d'installation et d'exécution

3. **Gestion du Code**
   - Contrôle de version avec Git
   - Variables d'environnement sécurisées
   - Tests maintenables et réutilisables

## Installation et Configuration

Chaque laboratoire contient son propre fichier README avec les instructions spécifiques d'installation et de configuration.

### Prérequis Généraux

- Python 3.x
- Robot Framework
- Git
- MongoDB (pour Lab 1)
- Appium (pour Lab 4)

## Exécution des Tests

Chaque laboratoire peut être exécuté indépendamment. Consultez le README.md de chaque laboratoire pour les instructions détaillées.

## Équipe

- Projet réalisé dans le cadre de la formation ISI MASTER GENIE LOGICIEL 2025
- Groupe 1



