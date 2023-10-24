const API = '/api';

const api = async data => {
    const resp = await fetch(API, {
        "method": "POST",
        "body": JSON.stringify(data),
        "headers": {
            "Content-type": "application/json; charset=UTF-8"
        }
    });
    let json = await resp.json();
    json["status"] = resp.status;
    print(`API with "${JSON.stringify(data)}" → "${JSON.stringify(json)}"`)
    return json;
};