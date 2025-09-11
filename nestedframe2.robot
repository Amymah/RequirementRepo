*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Handle Nested Iframes
    Open Browser   https://testpages.eviltester.com/styled/frames/frames-test.html    chrome
    Maximize Browser Window
    Set Selenium Speed    -0.3s

    Select Frame    xpath=//frame[@name="left"]
    ${l_frame}  Get Text    xpath=//h1[text()='Left']
    Log To Console    frame name is:${l_frame}
    Unselect Frame

    Select Frame    xpath=//frame[@name="middle"]
    ${M_frame}  Get Text    xpath=//h1[text()='Middle']
    Log To Console    frame name is:${M_frame}
    Unselect Frame

    Select Frame    xpath=//frame[@name="right"]
    ${R_frame}  Get Text    xpath=//h1[text()='Right']
    Log To Console    frame name is:${R_frame}
    Unselect Frame

    Unselect Frame

    Close Browser
