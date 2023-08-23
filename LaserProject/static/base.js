// Allows JSX to function + adds some easy of use tools

const [𝕋, 𝔽] = [true, false];
const ASCII_CHARS_STANDARD = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

const print = (...x) => console.log(...x) || x[0]
const all = A => A.every(x=>x);
const range = (a, b) => [...Array(b-a).keys()].map(i => i+a);
const sleep = s => new Promise(r => setTimeout(r, 1000 * s));
const strfmt = (str, args) => {
    for (const [k, v] of Object.entries(args))
        str = str.replace(new RegExp("\\{" + k + "\\}", "gi"), v);
    return str; };
const makeid = (length, chars=ASCII_CHARS_STANDARD) => 
    range(0, length)
        .map(_=>chars.charAt(Math.floor(Math.random()*chars.length)))
        .reduce(([a,b])=>a+b, '');
const createElement = (tagName, attrs={}, ...children) => {
    const elem = Object.assign(document.createElement(tagName), attrs)
    for (const child of children) {
        if (Array.isArray(child)) elem.append(...child)
        else elem.append(child)
    }
    return elem; };