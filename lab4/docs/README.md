# Lab 4 : Tests mobiles – APK Looma

## Objectif
Automatiser les tests sur l’application mobile `looma.apk`.

## Scénarios de tests
- **Scénario passant :**
  - Vérifie que l'utilisateur peut s'authentifier avec des identifiants valides.
  - Vérifie que l'utilisateur peut créer et afficher un produit (ex : Rain Jacket Women Windbreaker).
- **Scénario non passant :**
  - Vérifie que l'utilisateur ne peut pas s'authentifier avec des identifiants invalides.

## Structure
- **`po/variable.py` :** Contient le chemin de l'application mobile.
- **`po/locator.py` :** Contient les localisateurs pour les champs et boutons.
- **`ressources/common.robot` :** Définit des mots-clés pour ouvrir et fermer l'application mobile.
- **`testcases/mobile_tests.robot` :** Contient les cas de tests automatisés.
- **`testcases/login_invalid_test.robot` :** Contient le test pour l'authentification avec des identifiants invalides.

## Astuce bonus
Mme SAMB encourage l’utilisation de [Appium Flutter Driver](https://github.com/appium-userland/appium-flutter-driver) pour éviter l’utilisation de `xpath`.
