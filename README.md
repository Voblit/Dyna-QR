# dyna qr

A simple, self-hosted dynamic QR code and redirect manager built with **D** and **vibe.d**. None of that proprietary bitly or tinyurl nonsense

## what it does
* **Dynamic Redirects:** Change where a short link points to later without having to reprint or regenerate your QR code.
* **Password Protected:** Updating an existing link requires the correct password, which is hashed.
* **Instant QR & Download:** lets you download teh 
* **Celebration:** :> 

## what's inside
* **Backend:** Dlang, `vibe.d`, JSON fs (`public/links.json`).
* **Frontend:** Vanilla HTML/CSS/JS, `qrcode.js`, and `canvas-confetti`.

## setup

1. Make sure you have the [D programming language](https://dlang.org/) and DUB package manager installed.
2. Clone or download this repository.
3. Run the server locally:

```bash
dub run
```
requested by ``ElkMountain`` on the ##chat channel in the Libera IRC network.
