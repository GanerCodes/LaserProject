const API = '/api';

const api = async data => {
    const resp = await fetch(API, {
        "method": "POST",
        "body": JSON.stringify(data),
        "headers": {
            "Content-type": "application/json; charset=UTF-8"
        }
    });
    const json = resp.json();
    json["status"] = resp.status;
    return json;
};