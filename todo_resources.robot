*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${BROWSER}    chrome

*** Keywords ***
Open Todo Application
    ${path}=    Normalize Path    ${CURDIR}/todo_app.html
    Open Browser    file://${path}    ${BROWSER}
    Wait Until Element Is Visible    id:new-todo

Add Todo Item
    [Arguments]    ${todo_text}
    Input Text    id:new-todo    ${todo_text}
    Click Button    id:add-todo
    Wait Until Page Contains Element    xpath://li/span[text()='${todo_text}']

Todo Item Should Exist
    [Arguments]    ${todo_text}
    Page Should Contain Element    xpath://li/span[text()='${todo_text}']

Mark Todo Item Complete
    [Arguments]    ${todo_text}
    Click Element    xpath://li/span[text()='${todo_text}']/preceding-sibling::input[@type='checkbox']

Todo Item Should Be Completed
    [Arguments]    ${todo_text}
    ${class}=    Get Element Attribute    xpath://li/span[text()='${todo_text}']/..    class
    Should Contain    ${class}    completed

Delete Todo Item
    [Arguments]    ${todo_text}
    Click Element    xpath://li/span[text()='${todo_text}']/following-sibling::button[text()='Delete']

Todo Item Should Not Exist
    [Arguments]    ${todo_text}
    Page Should Not Contain Element    xpath://li/span[text()='${todo_text}']