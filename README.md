# 💰 mejor_cdt_app

Aplicación móvil en Flutter para simular inversiones tipo CDT de manera personalizada por usuario.

## 🚀 Descripción general

Esta app permite crear un usuario con nombre y correo electrónico, y automáticamente se generarán inversiones aleatorias asociadas desde el backend.

### ✨ Funcionalidades principales

- ✅ Registro de usuario (nombre + correo).
- 🔐 Mantenimiento de sesión hasta que se cierre manualmente.
- 💡 Backend en FastAPI que **genera inversiones únicas por usuario**.
- 🗄️ Base de datos online para persistencia global.
- 🔁 Si no hay conexión a internet, se usa la base de datos local para mostrar la información guardada.
- 📆 Se muestra la **última vez que hubo conexión**.
- 🔔 Cuando no hay conexión y se intenta actualizar, se muestra un *snackbar* informativo.
- ⏱️ Solo se permite hacer nuevas peticiones al backend si ha pasado **más de una hora** desde la última sincronización.
- 📊 Acceso rápido a una pantalla de inversión con resumen y datos consolidados.
- 🏦 Base de datos con las siguientes tablas:
  - `usuarios`
  - `inversiones`
  - `bancos`

---

## 🛠️ Tecnologías utilizadas

- **Flutter** 3.22.1 • [Ver repositorio oficial](https://github.com/flutter/flutter.git)
  - Framework revision: `a14f74ff3a` (2024-05-22)
- **Dart** 3.4.1
- **DevTools** 2.34.3
- **State management:** Flutter BLoC (`flutter_bloc`)
- **Base de datos local:** SQLite (`sqflite`)
- **HTTP requests:** `http`
- **Internacionalización:** `intl`

---

## 📦 Instalación y ejecución

### 1. Clona el repositorio
```bash
git clone https://github.com/tu_usuario/mejor_cdt_app.git
cd mejor_cdt_app
