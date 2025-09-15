*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Handle Nested Iframes
    Open Browser   https://the-internet.herokuapp.com/nested_frames    chrome
    Maximize Browser Window
    Set Selenium Speed    .3s
    Sleep    6s

    Select Frame    xpath=//frame[@src="/frame_top"]

    Select Frame    xpath=//frame[@src="/frame_middle"]

    ${middle_text}   Get Text    xpath=//div[@id="content"]
    Log To Console    the middle inner frame text is:${middle_text}

    Unselect Frame

    Unselect Frame

    Close Browser

