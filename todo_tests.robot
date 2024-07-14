*** Settings ***
Resource          todo_resources.robot
Library           DateTime

Test Setup        Open Todo Application
Test Teardown     Close Browser

*** Test Cases ***
Add New Todo Item
    ${todo_text}=    Set Variable    Prepare Robot Framework Workshop
    Add Todo Item    ${todo_text}
    Todo Item Should Exist    ${todo_text}

Mark Todo Item As Complete
    ${todo_text}=    Set Variable    Complete Robot Framework Workshop
    Add Todo Item    ${todo_text}
    Mark Todo Item Complete    ${todo_text}
    Todo Item Should Be Completed    ${todo_text}

Delete Todo Item
    ${todo_text}=    Set Variable    Delete Robot Framework Workshop
    Add Todo Item    ${todo_text}
    Delete Todo Item    ${todo_text}
    Todo Item Should Not Exist    ${todo_text}

Verify Date Date Display
    ${displayed_date}=    Get Text    id:current-date
    ${current_date}=    Get Current Date    result_format=%m/%d/%Y
    Should Be Equal    ${displayed_date}    ${current_date}