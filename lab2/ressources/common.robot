*** Settings ***
Library           SeleniumLibrary
Variables         ../po/variable.py

*** Keywords ***
Open CRM Website
    [Arguments]    ${browser}=chrome
    Open Browser    ${URL}    ${browser}
    Maximize Browser Window
    Set Selenium Speed    0.5 seconds
    Set Selenium Timeout    10 seconds

Close CRM Website
    Close All Browsers

Login To CRM
    [Arguments]    ${username}    ${password}
    Click Element    ${SIGNIN_LINK}
    Wait Until Page Contains    Sign In
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Button    ${SUBMIT_BUTTON}
    Wait Until Page Contains    Our Happy Customers

Logout From CRM
    Click Element    ${SIGNOUT_LINK}
    Wait Until Page Contains    Sign In

Fill Customer Form
    [Arguments]    ${email}    ${firstname}    ${lastname}    ${city}    ${state}    ${gender}    ${promo}=False
    Input Text    ${EMAIL_FIELD}    ${email}
    Input Text    ${FIRST_NAME_FIELD}    ${firstname}
    Input Text    ${LAST_NAME_FIELD}    ${lastname}
    Input Text    ${CITY_FIELD}    ${city}
    Select From List By Value    ${STATE_DROPDOWN}    ${state}
    Run Keyword If    '${gender}' == 'male'    Click Element    ${GENDER_MALE_RADIO}
    ...    ELSE    Click Element    ${GENDER_FEMALE_RADIO}
    Run Keyword If    ${promo}    Select Checkbox    ${PROMO_CHECKBOX}

Cancel Customer Form
    Click Element    ${CANCEL_BUTTON}
    Wait Until Page Contains    ${CUSTOMERS_HEADER}

Submit Customer Form
    Click Button    ${SUBMIT_CUSTOMER_BUTTON}
    Wait Until Page Contains    ${SUCCESS_MESSAGE}
