*** Settings ***
Library           AppiumLibrary
Variables         ../po/locator.py
Variables         ../po/variable.py

*** Test Cases ***
Test Invalid Login
    [Documentation]    Test de connexion avec des identifiants invalides
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    automationName=${AUTOMATION_NAME}
    Sleep    2s    # Attendre que l'application soit chargée
    
    # Récupérer les champs de connexion
    ${username_field}=    Get Webelements    class=${USERNAME_FIELD_CLASS}
    ${password_field}=    Get Webelements    class=${PASSWORD_FIELD_CLASS}
    
    # Remplir le champ username avec un nom d'utilisateur invalide
    Click Element    ${username_field}[${USERNAME_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${username_field}[${USERNAME_FIELD_INDEX}]    invalid_user
    Sleep    1s
    
    # Remplir le champ password avec un mot de passe invalide
    Click Element    ${password_field}[${PASSWORD_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${password_field}[${PASSWORD_FIELD_INDEX}]    invalid_password
    Sleep    1s
    
    # Vérifier que le champ username contient bien le texte saisi
    Element Should Contain Text    ${username_field}[${USERNAME_FIELD_INDEX}]    invalid_user
    
    # Cliquer sur le bouton login
    Click Element    ${LOGIN_BUTTON}
    Sleep    3s
    
    # Vérifier que le message d'erreur est affiché (le bouton d'ajout de produit ne devrait pas être visible)
    Run Keyword And Expect Error    *    Page Should Contain Element    ${ADD_PRODUIT_BUTTON}
    Sleep    2s
    
    [Teardown]    Close Application
