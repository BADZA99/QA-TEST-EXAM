*** Settings ***
Documentation     Tests CRUD pour la base de données MongoDB fakeStoreDB
Library          ../ressources/mongodb_library.py
Resource         ../ressources/common.robot
Variables        ../po/variable.py

Test Setup       Connect To Database    ${DB_URI}    ${DB_NAME}
Test Teardown    Disconnect From Database

*** Test Cases ***
# Tests CRUD pour les produits
Create Product - Success
    [Documentation]    Test de création d'un produit valide
    ${id}=    Insert Product    ${VALID_PRODUCT}
    Should Not Be Empty    ${id}

Create Product - Missing Required Field
    [Documentation]    Test de création avec champ requis manquant
    Run Keyword And Expect Error    *Missing required field*    Insert Product    ${INVALID_PRODUCT}

Create Product - Invalid Price
    [Documentation]    Test de création avec prix invalide
    Run Keyword And Expect Error    *Price must be a number*    Insert Product    ${BAD_TYPE_PRODUCT}

Read Product - Success
    [Documentation]    Test de lecture d'un produit existant
    ${id}=    Insert Product    ${VALID_PRODUCT}
    ${product}=    Get Product By ID    ${id}
    Should Be Equal    ${product}[title]    Samsung S24

Read Product - Non-Existent ID
    [Documentation]    Test de lecture d'un ID inexistant
    ${product}=    Get Product By ID    nonexistent
    Should Be Equal    ${product}    ${None}

Read Product - Invalid ID Format
    [Documentation]    Test de lecture avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Get Product By ID    invalid-id

Update Product - Success
    [Documentation]    Test de mise à jour d'un produit
    ${id}=    Insert Product    ${VALID_PRODUCT}
    ${count}=    Update Product    ${id}    {"price": 999}
    Should Be Equal As Integers    ${count}    ${1}

Update Product - Non-Existent ID
    [Documentation]    Test de mise à jour avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Update Product    nonexistent    {"price": 999}

Update Product - Invalid Data
    [Documentation]    Test de mise à jour avec données invalides
    ${id}=    Insert Product    ${VALID_PRODUCT}
    Run Keyword And Expect Error    *Price must be a number*    Update Product    ${id}    {"price": "invalid"}

Delete Product - Success
    [Documentation]    Test de suppression d'un produit
    ${id}=    Insert Product    ${VALID_PRODUCT}
    ${count}=    Delete Product    ${id}
    Should Be Equal As Integers    ${count}    ${1}

Delete Product - Non-Existent ID
    [Documentation]    Test de suppression avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete Product    nonexistent

Delete Product - Invalid ID Format
    [Documentation]    Test de suppression avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete Product    invalid-id

# Tests CRUD pour les utilisateurs
Create Valid User
    [Documentation]    Test de création d'un utilisateur valide
    ${id}=    Insert User    ${VALID_USER}
    Should Not Be Empty    ${id}

Create User Missing Field
    [Documentation]    Test de création avec email manquant
    Run Keyword And Expect Error    *Missing required field*    Insert User    ${INVALID_USER}

Create User With Invalid Type
    [Documentation]    Test de création avec email invalide
    Run Keyword And Expect Error    *Invalid email format*    Insert User    ${BAD_TYPE_USER}

Read Valid User
    [Documentation]    Test de lecture d'un utilisateur
    ${id}=    Insert User    ${VALID_USER}
    ${user}=    Get User By ID    ${id}
    Should Be Equal    ${user}[email]    test@example.com

Read User Non-Existent ID
    [Documentation]    Test de lecture d'un ID inexistant
    ${user}=    Get User By ID    nonexistent
    Should Be Equal    ${user}    ${None}

Read User Invalid ID Format
    [Documentation]    Test de lecture avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Get User By ID    invalid-id

Update Valid User
    [Documentation]    Test de mise à jour d'un utilisateur
    ${id}=    Insert User    ${VALID_USER}
    ${count}=    Update User    ${id}    {"username": "newuser"}
    Should Be Equal As Integers    ${count}    ${1}

Update User Non-Existent ID
    [Documentation]    Test de mise à jour avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Update User    nonexistent    {"username": "newuser"}

Update User Invalid Data
    [Documentation]    Test de mise à jour avec données invalides
    ${id}=    Insert User    ${VALID_USER}
    Run Keyword And Expect Error    *Invalid email format*    Update User    ${id}    {"email": "invalid"}

Delete Valid User
    [Documentation]    Test de suppression d'un utilisateur
    ${id}=    Insert User    ${VALID_USER}
    ${count}=    Delete User    ${id}
    Should Be Equal As Integers    ${count}    ${1}

Delete User Non-Existent ID
    [Documentation]    Test de suppression avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete User    nonexistent

Delete User Invalid ID Format
    [Documentation]    Test de suppression avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete User    invalid-id

# Tests CRUD pour les catégories
Create Valid Category
    [Documentation]    Test de création d'une catégorie valide
    ${id}=    Insert Category    ${VALID_CATEGORY}
    Should Not Be Empty    ${id}

Create Category Missing Field
    [Documentation]    Test de création avec nom manquant
    Run Keyword And Expect Error    *Missing required field*    Insert Category    ${INVALID_CATEGORY}

Create Category Duplicate
    [Documentation]    Test de création avec nom dupliqué
    ${id}=    Insert Category    ${VALID_CATEGORY}
    Run Keyword And Expect Error    *already exists*    Insert Category    ${DUPLICATE_CATEGORY}

Read Valid Category
    [Documentation]    Test de lecture d'une catégorie
    ${id}=    Insert Category    ${VALID_CATEGORY}
    ${category}=    Get Category By ID    ${id}
    Should Be Equal    ${category}[name]    TestCategory1

Read Category Non-Existent ID
    [Documentation]    Test de lecture d'un ID inexistant
    ${category}=    Get Category By ID    nonexistent
    Should Be Equal    ${category}    ${None}

Read Category Invalid ID Format
    [Documentation]    Test de lecture avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Get Category By ID    invalid-id

Update Valid Category
    [Documentation]    Test de mise à jour d'une catégorie
    ${id}=    Insert Category    ${VALID_CATEGORY}
    ${count}=    Update Category    ${id}    {"description": "Updated"}
    Should Be Equal As Integers    ${count}    ${1}

Update Category Non-Existent ID
    [Documentation]    Test de mise à jour avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Update Category    nonexistent    {"description": "Updated"}

Update Category Invalid Data
    [Documentation]    Test de mise à jour avec nom vide
    ${id}=    Insert Category    ${VALID_CATEGORY}
    Run Keyword And Expect Error    *name cannot be empty*    Update Category    ${id}    {"name": ""}

Delete Valid Category
    [Documentation]    Test de suppression d'une catégorie
    ${id}=    Insert Category    ${VALID_CATEGORY}
    ${count}=    Delete Category    ${id}
    Should Be Equal As Integers    ${count}    ${1}

Delete Category Non-Existent ID
    [Documentation]    Test de suppression avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete Category    nonexistent

Delete Category Invalid ID Format
    [Documentation]    Test de suppression avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete Category    invalid-id

# Tests CRUD pour les commandes
Create Valid Order
    [Documentation]    Test de création d'une commande valide
    ${id}=    Insert Order    ${VALID_ORDER}
    Should Not Be Empty    ${id}

Create Order Missing Field
    [Documentation]    Test de création avec champ manquant
    Run Keyword And Expect Error    *Missing required field*    Insert Order    ${INVALID_ORDER}

Create Order Invalid Type
    [Documentation]    Test de création avec quantité invalide
    Run Keyword And Expect Error    *Quantity must be a number*    Insert Order    ${BAD_TYPE_ORDER}

Read Valid Order
    [Documentation]    Test de lecture d'une commande
    ${id}=    Insert Order    ${VALID_ORDER}
    ${order}=    Get Order By ID    ${id}
    Should Be Equal    ${order}[user_id]    ${VALID_ORDER}[user_id]

Read Order Non-Existent ID
    [Documentation]    Test de lecture d'un ID inexistant
    ${order}=    Get Order By ID    nonexistent
    Should Be Equal    ${order}    ${None}

Read Order Invalid ID Format
    [Documentation]    Test de lecture avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Get Order By ID    invalid-id

Update Valid Order
    [Documentation]    Test de mise à jour d'une commande
    ${id}=    Insert Order    ${VALID_ORDER}
    ${count}=    Update Order    ${id}    {"quantity": 2}
    Should Be Equal As Integers    ${count}    ${1}

Update Order Non-Existent ID
    [Documentation]    Test de mise à jour avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Update Order    nonexistent    {"quantity": 2}

Update Order Invalid Data
    [Documentation]    Test de mise à jour avec quantité invalide
    ${id}=    Insert Order    ${VALID_ORDER}
    Run Keyword And Expect Error    *Quantity must be a number*    Update Order    ${id}    {"quantity": "invalid"}

Delete Valid Order
    [Documentation]    Test de suppression d'une commande
    ${id}=    Insert Order    ${VALID_ORDER}
    ${count}=    Delete Order    ${id}
    Should Be Equal As Integers    ${count}    ${1}

Delete Order Non-Existent ID
    [Documentation]    Test de suppression avec un ID inexistant
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete Order    nonexistent

Delete Order Invalid ID Format
    [Documentation]    Test de suppression avec un format d'ID invalide
    Run Keyword And Expect Error    *Invalid ObjectId format*    Delete Order    invalid-id
