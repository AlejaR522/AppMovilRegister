# AppMovil – Login y Registro

Maquetación interactiva de un flujo de autenticación móvil hecha con **Flutter**, a partir de un diseño en Figma. No hay backend: los datos se simulan en memoria.

**Diseño de referencia:** 
(https://www.figma.com/design/auqlin8ZFmcTs8deTsAgYi/Login-y-Registro-%E2%80%93-App-m%C3%B3vil?node-id=0-1&p=f)

**Autora:** Alejandra Ruiz
**Curso:** Aplicaciones Móviles – Desarrollo de Software

---

## Pantallas

| # | Pantalla | Ruta | Archivo |
|---|----------|------|---------|
| 1 | Login | `/` | `lib/screens/login_screen.dart` |
| 2 | Registro | `/register` | `lib/screens/register_screen.dart` |
| 3 | Recuperar contraseña | `/forgot-password` | `lib/screens/forgot_password_screen.dart` |
| 4 | Código de verificación | `/verification` | `lib/screens/verification_code_screen.dart` |
| 5 | Nueva contraseña | `/new-password` | `lib/screens/new_password_screen.dart` |
| 6 | Home | `/home` | `lib/screens/home_screen.dart` |

## Flujo de navegación

- **Login** → Home (con datos válidos), Recuperar contraseña o Registro.
- **Registro** → Home (con datos válidos). El botón atrás y "Inicia sesión" vuelven a Login.
- **Recuperar contraseña** → Código de verificación (con un correo válido).
- **Código de verificación** → Nueva contraseña (al completar los 4 dígitos). El botón atrás vuelve a Recuperar contraseña.
- **Nueva contraseña** → Login con mensaje de éxito (si se cumplen todos los requisitos).
- **Home** → Login (cerrar sesión).
- Los botones **Google** y **Apple** muestran el mensaje "Funcionalidad no disponible".

## Funcionalidades

- Validación de formato de correo con mensaje de error bajo el input.
- Campos obligatorios: ningún formulario se envía vacío.
- Mostrar u ocultar la contraseña con el ícono del ojo.
- Registro: la contraseña y su confirmación deben coincidir, y el botón solo funciona con los términos aceptados.
- Código de verificación: una casilla por dígito (solo números), el foco avanza y retrocede solo, y el contador de 45 segundos corre en tiempo real con opción de reenviar al llegar a cero.
- Nueva contraseña: los 3 requisitos (8 caracteres, una mayúscula, un número) cambian de estado mientras se escribe.
- El correo escrito en Login, Registro o Recuperar contraseña se muestra en las pantallas siguientes.
- Botones deshabilitados mientras el formulario no es válido.

## Componentes reutilizables

Se escriben una sola vez en `lib/widgets/` y se usan en varias pantallas:

- `custom_input.dart`: input con ojo para contraseña y mensaje de error.
- `custom_button.dart`: botón primario (degradado) y secundario (blanco).
- `code_box.dart`: casilla de un dígito para el código.
- `back_button_box.dart`: botón cuadrado de "atrás".
- `decor_shape.dart`: burbujas, aros y cuadros decorativos del fondo.
- `gradient_icon_box.dart`: cuadro o círculo con degradado e ícono.

## Estructura del proyecto

```
lib/
├── main.dart                 # Punto de entrada y rutas
├── theme/
│   └── app_colors.dart       # Colores y degradados
├── utils/
│   └── validators.dart       # Validaciones de correo y contraseña
├── screens/                  # Una pantalla por archivo
└── widgets/                  # Componentes reutilizables
```

---

## Versiones utilizadas

| Herramienta | Versión |
|-------------|---------|
| Flutter (canal stable) | 3.47.2 |
| Dart | 3.13.2 |
| DevTools | 2.60.0 |
| Sistema operativo | Windows 11 25H2 |
| Android SDK | 36.0.0 |
| Java (JDK de Android Studio) | OpenJDK 21.0.10 |
| Visual Studio Community | 2026 (18.11.0) |
| Navegador de prueba | Google Chrome 155 |

Para comprobar las tuyas: `flutter --version` y `flutter doctor`.

## Cómo ejecutar el proyecto

### Requisitos previos

1. Tener instalado el [SDK de Flutter](https://docs.flutter.dev/get-started/install) y agregado al `PATH`.
2. Tener Git instalado.
3. Tener Google Chrome (para ejecutar en web). Para Android se necesita además Android Studio con un emulador o un celular con depuración USB.

Comprueba que todo esté bien:

```bash
flutter doctor
```

> Si `flutter doctor` indica que faltan licencias de Android, ejecuta `flutter doctor --android-licenses` y acepta con `y`.

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/AlejaR522/AppMovilRegister.git

# 2. Entrar a la carpeta del proyecto
cd AppMovilRegister

# 3. Descargar las dependencias
flutter pub get

# 4. Ejecutar en Chrome
flutter run -d chrome
```

Otras formas de ejecutarlo:

```bash
flutter run -d windows     # aplicación de escritorio en Windows
flutter run                # dispositivo o emulador Android conectado
flutter devices            # lista los dispositivos disponibles
```

Mientras la app corre en la terminal: `r` recarga los cambios, `R` reinicia y `q` cierra.

### Ver el diseño en formato móvil

El diseño de referencia es de **390 × 844 px**. En Chrome, con la app abierta, presiona `F12` y luego `Ctrl + Shift + M` para activar el modo dispositivo y elegir un tamaño de celular.

## Notas

- No hay backend ni base de datos: no se comprueba si un correo ya existe y los datos se pierden al cerrar la app.
- En el teclado de Android, borrar con una casilla de código ya vacía puede no regresar a la casilla anterior; borrar una casilla con dígito sí lo hace. En Chrome y Windows funciona completo.
