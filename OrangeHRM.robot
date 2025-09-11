*** Settings ***
Library           SeleniumLibrary
Library           RPA
Library           Collections
Suite Setup       Open Browser To OrangeHRM
Suite Teardown    Close Browser

*** Variables ***
${EXCEL_FILE}     C:/Users/Amaima/Downloads/OrangeHRM.xlsx
${LOGIN_URL}      https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}        Chrome

# Locators
${USERNAME_FIELD}        xpath://input[@name='username']
${PASSWORD_FIELD}        xpath://input[@name='password']
${LOGIN_BUTTON}          xpath://button[@type='submit']
${RECRUITMENT_MENU}      xpath://span[text()='Recruitment']
${CANDIDATES_TAB}        xpath://a[text()='Candidates']
${ADD_BUTTON}            xpath://button[text()=' Add ']
${FIRSTNAME_FIELD}       xpath://input[@name='firstName']
${MIDDLENAME_FIELD}      xpath://input[@name='middleName']
${LASTNAME_FIELD}        xpath://input[@name='lastName']
${EMAIL_FIELD}           xpath://input[@type='email']
${VACANCY_DROPDOWN}      xpath:(//div[@class='oxd-select-text-input'])[1]
${VACANCY_OPTIONS}       xpath://div[@role='option']/span
${SAVE_BUTTON}           xpath://button[@type='submit']

*** Test Cases ***
Add Candidate From Excel
    [Documentation]    Read login and candidate data from Excel and add candidate to OrangeHRM
    Open Excel And Read Data
    Login To OrangeHRM
    Go To Candidates Tab
    Add New Candidate

*** Keywords ***
Open Browser To OrangeHRM
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s

Open Excel And Read Data
    Open Workbook    ${EXCEL_FILE}
    ${username}=     Read Cell Value    sheetname=Login    row=2    column=1
    ${password}=     Read Cell Value    sheetname=Login    row=2    column=2
    Set Suite Variable    ${username}
    Set Suite Variable    ${password}

    ${first_name}=   Read Cell Value    sheetname=AddCandidates    row=2    column=1
    ${middle_name}=  Read Cell Value    sheetname=AddCandidates    row=2    column=2
    ${last_name}=    Read Cell Value    sheetname=AddCandidates    row=2    column=3
    ${email}=        Read Cell Value    sheetname=AddCandidates    row=2    column=4
    ${vacancy}=      Read Cell Value    sheetname=AddCandidates    row=2    column=5

    Set Suite Variable    ${first_name}
    Set Suite Variable    ${middle_name}
    Set Suite Variable    ${last_name}
    Set Suite Variable    ${email}
    Set Suite Variable    ${vacancy}
    Close Workbook

Login To OrangeHRM
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Text    ${PASSWORD_FIELD}    ${password}
    Click Element    ${LOGIN_BUTTON}
    Wait Until Element Is Visible    ${RECRUITMENT_MENU}    timeout=10s

Go To Candidates Tab
    Click Element    ${RECRUITMENT_MENU}
    Wait Until Element Is Visible    ${CANDIDATES_TAB}
    Click Element    ${CANDIDATES_TAB}
    Wait Until Element Is Visible    ${ADD_BUTTON}

Add New Candidate
    Click Element    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${FIRSTNAME_FIELD}

    Input Text    ${FIRSTNAME_FIELD}      ${first_name}
    Input Text    ${MIDDLENAME_FIELD}     ${middle_name}
    Input Text    ${LASTNAME_FIELD}       ${last_name}
    Input Text    ${EMAIL_FIELD}          ${email}

    Click Element    ${VACANCY_DROPDOWN}
    Wait Until Element Is Visible    ${VACANCY_OPTIONS}
    ${options}=    Get WebElements    ${VACANCY_OPTIONS}
    :FOR    ${option}    IN    @{options}
    \    ${text}=    Get Text    ${option}
    \    Run Keyword If    '${text}' == '${vacancy}'    Click Element    ${option}    AND    Exit For Loop

    Click Element    ${SAVE_BUTTON}
    Wait Until Page Contains Element    xpath://div[contains(text(), 'Successfully Saved')]    timeout=10s

