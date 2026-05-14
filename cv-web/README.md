# CV Web — Daniel Bueno

Hoja de vida web estática (HTML + CSS + JS, sin build). Lista para correr en
local desde el celular o desplegarse gratis en GitHub Pages, Vercel, Netlify
o cualquier hosting estático.

## Estructura

```
cv-web/
├── index.html      # Contenido y estructura
├── styles.css      # Estilos (responsive + print)
├── script.js       # Año dinámico y botón de imprimir/PDF
└── README.md
```

No hay dependencias, no hay paso de build, no hace falta Node ni Python a menos
que quieras servirla localmente.

## Verla en local (desde el celular o el PC)

Cualquier servidor estático sirve. Opciones:

**Python 3 (viene preinstalado en muchos entornos):**

```bash
cd cv-web
python3 -m http.server 8080
```

Luego abre en el navegador del propio dispositivo:

```
http://localhost:8080
```

Para verla desde otro dispositivo en la misma red Wi-Fi, usa la IP local del
equipo que está sirviendo, por ejemplo `http://192.168.1.20:8080`.

**Alternativas:**

- `npx serve cv-web` (Node)
- Extensión "Live Server" en VS Code
- Termux en Android: `pkg install python` y luego el comando de arriba

## Imprimir como PDF

Click en el botón **"Descargar PDF"** del header → el navegador abre el diálogo
de impresión. Elige *"Guardar como PDF"*. El CSS tiene una sección `@media
print` que limpia los colores oscuros y deja el documento bien formateado
para impresión.

## Desplegar gratis (3 opciones)

### Opción A · GitHub Pages (la más sencilla si ya está en GitHub)

1. Sube los cambios al repo.
2. En GitHub: *Settings → Pages*.
3. *Source:* `Deploy from a branch`, branch `main` (o la que uses) y carpeta
   `/cv-web`.
4. Espera 1-2 minutos. La URL queda como
   `https://<usuario>.github.io/<repo>/`.

> Si quieres que la raíz del sitio apunte directo al CV, mueve el contenido de
> `cv-web/` a la raíz del repo o crea un repo dedicado.

### Opción B · Vercel (drag &amp; drop, sin cuenta de Git)

1. Entra a [vercel.com/new](https://vercel.com/new).
2. Arrastra la carpeta `cv-web` a la zona de subida.
3. *Deploy* → te queda una URL `https://<nombre>.vercel.app`.

### Opción C · Netlify Drop

1. Entra a [app.netlify.com/drop](https://app.netlify.com/drop).
2. Arrastra la carpeta `cv-web`.
3. URL inmediata `https://<nombre>.netlify.app`.

Las tres son gratis y soportan dominio personalizado si lo necesitas más
adelante.

## Personalización rápida

- **Colores:** edita las variables CSS al inicio de `styles.css`
  (`--accent`, `--bg`, etc.).
- **Texto:** todo el contenido vive en `index.html`. No hay backend ni base
  de datos.
- **Iconos:** son SVG inline (Feather Icons), puedes cambiarlos sin instalar
  nada.
