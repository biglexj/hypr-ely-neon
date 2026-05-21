# hypr-ely-neon Theme SDDM

Un tema personalizado para SDDM (Simple Desktop Display Manager) con un diseño moderno y minimalista.

![Vista previa](preview.png)

## 🔗 Repositorios y Recursos

### Repositorios
- **GitHub**: [biglexj/hypr-ely-neon](https://github.com/biglexj/hypr-ely-neon.git)

### Fuentes Requeridas
| Fuente | Enlace de Descarga | Usos en el Tema |
|--------|-------------------|-----------------|
| Fira Sans | [mozilla/Fira](https://github.com/mozilla/Fira) | • Campo de usuario<br>• Campo de fecha<br>• Elementos generales |
| Kefa | [Kefa Font](https://www.freefontdownload.org/en/kefa-regular.font) | • Mensaje de bienvenida |
| Ndot 55 | [Nothing Font](https://github.com/xeji01/nothingfont.git) | • Reloj digital<br>• Campo de contraseña |

### Configuración de Fuentes
El tema utiliza diferentes fuentes para distintos elementos:
```ini
HeaderTextFont="Kefa"         # Mensaje de bienvenida
ClockFont="Ndot55"            # Reloj digital
DateFont="Fira Sans"          # Fecha
UserFieldFont="Fira Sans"     # Campo de usuario
PasswordFieldFont="Ndot55"    # Campo de contraseña
GeneralFont="Fira Sans"       # Elementos generales
```

## ⚠️ Advertencia de Compatibilidad

Este tema ha sido probado y optimizado para las siguientes resoluciones:
- 2880x1800 (Resolución nativa de prueba)

**Nota**: No se garantiza el funcionamiento correcto en otras resoluciones. Podrían ser necesarios ajustes manuales en `theme.conf` para adaptarlo a tu pantalla.

## 🔧 Requisitos

### Fuentes Requeridas
Para que el tema funcione correctamente, necesitas instalar las siguientes fuentes:

- **Fira Sans** - Fuente principal para campos de texto y elementos generales
- **Kefa** - Fuente para el mensaje de bienvenida
- **Ndot55** - Fuente para el reloj digital y campo de contraseña

### Dependencias
- SDDM 0.19.0 o superior
- Qt 5.15.0 o superior
- Módulos de Qt5 QML requeridos (necesarios para renderizar los controles y efectos de desenfoque):
  - **Arch Linux / CachyOS**: `qt5-graphicaleffects` y `qt5-quickcontrols2`
  - **Ubuntu / Debian**: `qml-module-qtquick-controls2` y `qml-module-qtgraphicaleffects`
  - **Fedora**: `qt5-qtquickcontrols2` y `qt5-qtgraphicaleffects`
- [Opcional] Teclado virtual de Qt

## 📥 Instalación

### 🚀 Método Automático (Recomendado)
Para una instalación súper rápida y automática que se encarga de descargar e instalar fuentes, copiar el tema y configurar SDDM:

1. Clona el repositorio y entra al directorio:
```bash
git clone https://github.com/biglexj/hypr-ely-neon.git
cd hypr-ely-neon
```

2. Ejecuta el script de instalación:
```bash
chmod +x install.sh
./install.sh
```

### 🛠️ Método Manual
Si prefieres realizar la instalación paso a paso, por favor consulta nuestra [Guía de Instalación Detallada (INSTALL.md)](INSTALL.md).

## ⚙️ Personalización

El tema puede personalizarse editando el archivo `theme.conf`. Las principales opciones incluyen:

- Imagen de fondo
- Posición del formulario (izquierda/centro/derecha)
- Efecto de desenfoque
- Colores y fuentes
- Formato de hora y fecha

## 🎨 Características

- Diseño moderno y limpio
- Soporte para múltiples usuarios
- Reloj digital personalizado
- Selector de sesión
- Botones de sistema (apagar, reiniciar, suspender)
- Efecto de desenfoque configurable
- Teclado virtual (opcional)
- Traducciones personalizables

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor, asegúrate de probar tus cambios en diferentes resoluciones y documentar cualquier modificación.

## 📜 Licencia

Este tema está basado en SDDM Sugar Candy y está licenciado bajo GPLv3.

## ⚠️ Problemas Conocidos

- El tema está optimizado para 2880x1800. En otras resoluciones, podrías necesitar ajustar:
  - Tamaños de fuente en `theme.conf`
  - Dimensiones de elementos en los archivos QML
  - Posición de elementos en la interfaz
- **Conflicto de Display Manager**: En distribuciones como CachyOS, es posible que el sistema use `plasmalogin.service` (Plasma Login Manager) u otro gestor por defecto. Si el tema no se aplica tras reiniciar, asegúrate de deshabilitar dicho servicio y habilitar `sddm.service` para que SDDM se ejecute. El script de instalación automática ya gestiona esto por ti si decides activar el tema de forma interactiva.

## 🙏 Agradecimientos

- SDDM basado en Breeze-Chameleon - Por el tema base
- Comunidad de KDE - Por SDDM
