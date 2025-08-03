*** Settings ***
Library           AppiumLibrary
Variables           ../po/locator.py
Variables           ../po/variable.py


*** Test Cases ***
Complete Product Flow
    [Documentation]    Test complet: Connexion puis ajout et vérification d'un produit
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    automationName=${AUTOMATION_NAME}
    Sleep    2s    # Attendre que l'application soit chargée
    ${username_field}=    Get Webelements    class=${USERNAME_FIELD_CLASS}
    ${password_field}=    Get Webelements    class=${PASSWORD_FIELD_CLASS}
    
    # Remplir le champ username
    Click Element    ${username_field}[${USERNAME_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${username_field}[${USERNAME_FIELD_INDEX}]    donero
    Sleep    1s
    
    # Remplir le champ password
    Click Element    ${password_field}[${PASSWORD_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${password_field}[${PASSWORD_FIELD_INDEX}]    ewedon
    Sleep    1s
    
    # Vérifier uniquement le champ username (le password est masqué)
    Element Should Contain Text    ${username_field}[${USERNAME_FIELD_INDEX}]    donero
    
    # Cliquer sur le bouton login
    Click Element    ${LOGIN_BUTTON}
    Sleep    5s
    Element Should Be Visible    ${ADD_PRODUIT_BUTTON}
    
    # Partie ajout de produit
    Wait Until Element Is Visible    ${ADD_PRODUIT_BUTTON}
    Sleep    2s
    
    # Récupérer tous les champs du formulaire
    ${form_fields}=    Get Webelements    class=${USERNAME_FIELD_CLASS}
    
    # Remplir le champ Titre
    Click Element    ${form_fields}[${TITRE_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${form_fields}[${TITRE_FIELD_INDEX}]    Rain Jacket Women Windbreaker
    Sleep    1s
    
    # Remplir le champ Prix
    Click Element    ${form_fields}[${PRIX_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${form_fields}[${PRIX_FIELD_INDEX}]    29.99
    Sleep    1s
    
    # Remplir le champ Description
    Click Element    ${form_fields}[${DESCRIPTION_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${form_fields}[${DESCRIPTION_FIELD_INDEX}]    Lightweight water-resistant windbreaker jacket for women
    Sleep    1s
    
    # Remplir le champ Catégorie
    Click Element    ${form_fields}[${CATEGORIE_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${form_fields}[${CATEGORIE_FIELD_INDEX}]    women's clothing
    Sleep    1s
    
    # Remplir le champ URL de l'image
    Click Element    ${form_fields}[${IMAGE_URL_FIELD_INDEX}]
    Sleep    1s
    Input Text    ${form_fields}[${IMAGE_URL_FIELD_INDEX}]    https://fakestoreapi.com/img/2.jpg
    Sleep    1s
    
    # Cliquer sur le bouton Ajouter
    Click Element    ${ADD_PRODUIT_BUTTON}
    Sleep    3s
    
    # Vérifier que la liste des produits est affichée
    Element Should Be Visible    ${PRODUCT_LIST_TITLE}
    Sleep    5s
    
    # Premier scroll vers le bas
    Swipe By Percent    50    90    50    10    1000
    Sleep    3s
    # Deuxième scroll vers le bas
    Swipe By Percent    50    90    50    10    1000
    Sleep    5s
    
    # Cliquer sur le produit dans la liste
    Click Element    ${PRODUCT_TO_CLICK}
    Sleep    4s
    
    # Vérifier que la popup du produit est visible
    Element Should Be Visible    ${POPUP_PRODUCT_ITEM}
    Sleep    2s
    
    Close Application