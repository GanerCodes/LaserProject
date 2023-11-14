const [𝕋, 𝔽] = [true, false];
const ASCII_CHARS_STANDARD = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

const print = (...x) => console.log(...x) || x[0]
const all = A => A.every(x=>x);
const sort = (A,f,r=𝔽) => A.sort((a,b) => (r ? 1 : -1)*(b > a ? 1 : -1))
const range = (a, b) => [...Array(b-a).keys()].map(i => i+a);
const sleep = s => new Promise(r => setTimeout(r, 1000 * s));
const enobj = Object.entries;
const strfmt = (str, args) => {
    for (const [k, v] of Object.entries(args))
        str = str.replace(new RegExp("\\{" + k + "\\}", "gi"), v);
    return str; };
const makeid = (length, chars=ASCII_CHARS_STANDARD) => 
    range(0, length)
        .map(_=>chars.charAt(Math.floor(Math.random()*chars.length)))
        .reduce(([a,b])=>a+b, '');
const createElement = (tagName, attrs={}, ...children) => { // required for JSX
    const elm = document.createElement(tagName);
    if(attrs)
        for(const [k, v] of enobj(attrs))
            elm.setAttribute(k, v);
    if(children)
        for (const child of children)
            Array.isArray(child) ? elm.append(...child) : elm.append(child)
    return elm; };
    
const BID = (id) => document.getElementById(id);
const VAL = (id) => BID(id).value;
const QSA = (sel) => document.querySelectorAll(sel);