*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${base_url}    http://api.openweathermap.org/data/2.5/forecast
${city}     Glasgow
${left_over_url}    ,uk&units=metric&appid=
${api_id}   1b9a4cf6f5eecebb884e5b6e7144cb98

*** Test Cases ***

Verify details of get request api response
    [Tags]    api
    # creating session and get request
    create session    mysession    ${base_url}
    ${response}=    get request    mysession    ?q=${city}${left_over_url}${api_id}

    # Verifying status code
    log to console    ${response.status_code}
    ${status_code}=   convert to string    ${response.status_code}
    should be equal    ${status_code}    200

    # Verifying city name
    ${body}=    convert to string    ${response.content}
    should contain    ${body}    Glasgow

    # Verifying content type in response header
    ${contentTypeValue}    get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contentTypeValue}    application/json; charset=utf-8

