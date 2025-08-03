*** Settings ***
Documentation    Tests de l'API eBay Fulfillment selon les spécifications
Resource         ../ressources/common.robot
Library          Collections
Library          String

*** Test Cases ***
Créer un fulfillment - Cas Passant
    [Documentation]    Test du cas passant - Création avec données valides
    ...    Vérifie : Code 201 + Location header
    [Tags]    positive    create
    ${payload}=    Create Valid Payload
    ${response}=    Create Shipping Fulfillment    ${VALID_ORDER_ID}    ${payload}
    Verify Success Response    ${response}    201    ${TRUE}

Créer un fulfillment - Payload Invalide
    [Documentation]    Test du cas non passant - Payload invalide
    ...    Vérifie : Code 400 avec message d'erreur
    [Tags]    negative    create
    ${payload}=    Create Invalid Payload
    ${response}=    Create Shipping Fulfillment    ${VALID_ORDER_ID}    ${payload}
    Verify Error Response    ${response}    400    Invalid request

Créer un fulfillment - Order ID Invalide
    [Documentation]    Test avec un ID de commande invalide
    ...    Vérifie : Code 400 avec message spécifique
    [Tags]    negative    create
    ${payload}=    Create Valid Payload
    ${response}=    Create Shipping Fulfillment    ${INVALID_ORDER_ID}    ${payload}
    Verify Error Response    ${response}    400    Invalid Order Id

Récupérer les fulfillments - Cas Passant
    [Documentation]    Test du cas passant - Liste des fulfillments
    ...    Vérifie : Code 200 + liste des fulfillments
    [Tags]    positive    read
    ${response}=    Get Shipping Fulfillments    ${VALID_ORDER_ID}
    Verify Success Response    ${response}    200

Récupérer les fulfillments - Order ID Invalide
    [Documentation]    Test avec ID commande invalide
    ...    Vérifie : Code 404 avec message d'erreur
    [Tags]    negative    read
    ${response}=    Get Shipping Fulfillments    ${INVALID_ORDER_ID}
    Verify Error Response    ${response}    404    Not found

Récupérer un fulfillment - Cas Passant
    [Documentation]    Test du cas passant - Récupération d'un fulfillment
    ...    Vérifie : Code 200 + données du fulfillment
    [Tags]    positive    read
    ${response}=    Get Shipping Fulfillment    ${VALID_ORDER_ID}    ${VALID_FULFILLMENT_ID}
    Verify Success Response    ${response}    200

Récupérer un fulfillment - ID Invalide
    [Documentation]    Test avec ID fulfillment invalide
    ...    Vérifie : Code 404 avec message d'erreur
    [Tags]    negative    read
    ${response}=    Get Shipping Fulfillment    ${VALID_ORDER_ID}    ${INVALID_FULFILLMENT_ID}
    Verify Error Response    ${response}    404    Not found
