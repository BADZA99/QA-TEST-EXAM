*** Settings ***
Resource          ../ressources/common.robot
Test Setup        Open CRM Website
Test Teardown     Close CRM Website

*** Variables ***
${VALID_USER}     admin@robotframeworkb2b.com
${VALID_PASS}     pwd

*** Test Cases ***
Test 1001: Home Page Should Load
    [Documentation]    Vérifie que la page d'accueil se charge correctement
    [Tags]    smoke    home
    Wait Until Page Contains    Customers Are Priority One!
    Page Should Contain    Sign In

Test 1002: Login Should Succeed With Valid Credentials
    [Documentation]    Vérifie que la connexion fonctionne avec des identifiants valides
    [Tags]    smoke    login
    Login To CRM    ${VALID_USER}    ${VALID_PASS}
    Wait Until Page Contains    Our Happy Customers

Test 1003: Login Should Fail With Missing Credentials
    [Documentation]    Vérifie que la connexion échoue avec des identifiants manquants
    [Tags]    functional    login
    Click Element    ${SIGNIN_LINK}
    Click Button    ${SUBMIT_BUTTON}
    Page Should Contain Element    css:input:invalid

Test 1003b: Remember Me Checkbox Should Persist Email Address
    [Documentation]    Vérifie que la case "Remember me" conserve l'email
    [Tags]    functional    login
    Click Element    ${SIGNIN_LINK}
    Input Text    ${USERNAME_FIELD}    ${VALID_USER}
    Select Checkbox    ${REMEMBER_ME_CHECKBOX}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASS}
    Click Button    ${SUBMIT_BUTTON}
    Click Element    ${SIGNOUT_LINK}
    Click Element    ${SIGNIN_LINK}
    Textfield Value Should Be    ${USERNAME_FIELD}    ${VALID_USER}

Test 1004: Should Be Able To Log Out
    [Documentation]    Vérifie que la déconnexion fonctionne
    [Tags]    functional    logout
    Login To CRM    ${VALID_USER}    ${VALID_PASS}
    Click Element    ${SIGNOUT_LINK}
    Page Should Contain   Signed Out

Test 1005: Customers Page Should Display Multiple Customers
    [Documentation]    Vérifie que la page clients affiche plusieurs clients
    [Tags]    smoke    customers
    Login To CRM    ${VALID_USER}    ${VALID_PASS}
    ${count}=    Get Element Count    css:#customers tr
    Should Be True    ${count} > 1

Test 1006: Should Be Able To Add New Customer
    [Documentation]    Vérifie qu'on peut ajouter un nouveau client
    [Tags]    smoke    customers
    Login To CRM    ${VALID_USER}    ${VALID_PASS}
    Click Element    ${NEW_CUSTOMER_BUTTON}
    Fill Customer Form
    ...    email=test@test.com
    ...    firstname=John
    ...    lastname=Doe
    ...    city=TestCity
    ...    state=AL
    ...    gender=male
    ...    promo=True
    Click Button    ${SUBMIT_CUSTOMER_BUTTON}
    Wait Until Page Contains    Our Happy Customers

Test 1007: Should Be Able To Cancel Adding New Customer
    [Documentation]    Vérifie qu'on peut annuler l'ajout d'un client
    [Tags]    functional    customers
    Login To CRM    ${VALID_USER}    ${VALID_PASS}
    Click Element    ${NEW_CUSTOMER_BUTTON}
    Click Element    ${CANCEL_BUTTON}
    Page Should Contain    Our Happy Customers
