*** Settings ***
Documentation     Tests de l'API eBay Fulfillment
Resource          ../resources/resources.robot
Suite Setup       Create Session To Ebay API

*** Test Cases ***
Test Get Shipping Fulfillments - Cas Passant
    [Documentation]    Vérifier la récupération de tous les fulfillments 
    [Tags]    positive    fulfillments
    ${response}=    Get Shipping Fulfilments Pass
    Validate Response Status    ${response}    200
    Validate Response Contains    ${response}    fulfillments

Test Get Shipping Fulfillments - Cas Non Passant
    [Documentation]    Vérifier la gestion des erreurs pour la récupération des fulfillments
    [Tags]    negative    fulfillments
    ${response}=    Get Shipping Fulfilments No Pass
    Validate Response Status    ${response}    400
    Validate Response Contains    ${response}    errors

Test Create Shipping Fulfillment - Cas Passant
    [Documentation]    Vérifier la création d'un fulfillment 
    [Tags]    positive    create
    ${response}=    Create Shipping Fulfillment Pass
    Validate Response Status    ${response}    201

Test Create Shipping Fulfillment - Cas Non Passant
    [Documentation]    Vérifier la gestion des erreurs pour la création d'un fulfillment
    [Tags]    negative    create
    ${response}=    Create Shipping Fulfillment No Pass
    Validate Response Status    ${response}    400


Test Get Shipping Fulfillment - Cas Passant
    [Documentation]    Vérifier la récupération d'un fulfillment spécifique 
    [Tags]    positive    fulfillment
    ${response}=    Get Shipping Fulfillment Pass
    Validate Response Status    ${response}    200


Test Get Shipping Fulfillment - Cas Non Passant
    [Documentation]    Vérifier la gestion des erreurs pour la récupération d'un fulfillment
    [Tags]    negative    fulfillment
    ${response}=    Get Shipping Fulfillment No Pass
    Validate Response Status    ${response}    400
 


