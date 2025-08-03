*** Settings ***
Library           AppiumLibrary

*** Keywords ***
Open Mobile App
    [Arguments]    ${app_path}
    Open Application    http://localhost:4723/wd/hub    platformName=Android    app=${app_path}

Close Mobile App
    Close Application
