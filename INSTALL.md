# Guía de Instalación Detallada - Hypr Ely-Neon SDDM

Esta guía describe cómo instalar el tema **Hypr Ely-Neon** y sus fuentes requeridas. El tema incluye un instalador automático que simplifica todo el proceso, pero también puedes realizar la instalación de forma manual.

---

## 🚀 Método Recomendado: Instalación Automática (Script)

El repositorio incluye un script `install.sh` que automatiza todos los pasos:
1. Detecta tu distribución e instala la fuente `Fira Sans` desde tus repositorios oficiales.
2. Instala automáticamente las fuentes locales `Kefa` y `Ndot55` incluidas en la carpeta `fonts/` del tema.
3. Copia el tema SDDM al directorio del sistema `/usr/share/sddm/themes/`.
4. Ofrece configurar SDDM de forma automática (haciendo copia de seguridad previa de `/etc/sddm.conf`).

### Instrucciones:

1. Clona el repositorio y entra en el directorio:
   ```bash
   git clone https://github.com/biglexj/hypr-ely-neon.git
   cd hypr-ely-neon
   ```

2. Dale permisos de ejecución al script (si no los tiene) y ejecútalo:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. Sigue las instrucciones interactivas en pantalla. ¡Eso es todo!

---

## 🛠️ Método Alternativo: Instalación Manual

Si prefieres realizar el proceso paso a paso, sigue las instrucciones a continuación.

### 1. Instalación de Fuentes Requeridas

Las fuentes `Kefa` y la familia `Ndot` **ya están incluidas en este repositorio** dentro de la carpeta `fonts/`. No necesitas descargarlas de internet.

#### A. Fira Sans (Desde repositorios)
Instala la fuente desde los repositorios oficiales de tu distribución Linux:

- **Arch Linux y derivados**:
  ```bash
  sudo pacman -S ttf-fira-sans
  ```
- **Ubuntu/Debian**:
  ```bash
  sudo apt install fonts-fira-sans
  ```
- **Fedora**:
  ```bash
  sudo dnf install fira-sans-fonts
  ```

#### B. Instalar Kefa y Ndot (Incluidas en el repositorio)
Copia las fuentes locales al directorio de fuentes del sistema:

1. Asegúrate de que el directorio TTF existe:
   ```bash
   sudo mkdir -p /usr/share/fonts/TTF
   ```

2. Copia los archivos de fuentes locales desde la carpeta del repositorio:
   ```bash
   # Copiar Kefa
   sudo cp fonts/kefa-regular/kefa-regular.ttf /usr/share/fonts/TTF/
   
   # Copiar fuentes Ndot
   sudo cp fonts/Ndot/* /usr/share/fonts/TTF/
   ```

3. Actualiza el caché de fuentes de tu sistema:
   ```bash
   sudo fc-cache -f -v
   ```

### 2. Copiar el Tema a SDDM

Copia la carpeta del tema a la ruta de temas del gestor SDDM:
```bash
sudo cp -r ../hypr-ely-neon /usr/share/sddm/themes/hypr-ely-neon
```
*(Nota: Asegúrate de ejecutar este comando desde fuera de la carpeta `hypr-ely-neon` o adapta la ruta de origen en consecuencia).*

### 3. Configurar SDDM

Para activar el tema, edita o crea el archivo `/etc/sddm.conf` y añade las siguientes líneas:
```ini
[Theme]
Current=hypr-ely-neon
```

---

## 📊 Verificación de Fuentes

Para comprobar que las fuentes se instalaron y detectaron correctamente por el sistema:
```bash
fc-list | grep -i "fira"
fc-list | grep -i "kefa"
fc-list | grep -i "ndot"
```

---

## ⚙️ Ajuste de Resolución y Pantalla

Si tu pantalla no es de resolución **2880x1800** (nativa del tema), puedes optimizar la apariencia editando el archivo `/usr/share/sddm/themes/hypr-ely-neon/theme.conf`:

1. Ajusta la resolución a la de tu pantalla actual:
   ```ini
   ScreenWidth="TU_ANCHO"
   ScreenHeight="TU_ALTO"
   ```
2. De ser necesario, escala las fuentes a tu gusto:
   ```ini
   FontSize="20"           # Tamaño de letra base
   ClockFontSize="120"     # Tamaño del reloj digital
   ```

---

## ❌ Solución de Problemas

### Fuentes no Detectadas / Reloj o Texto con Fuente Genérica
1. Asegúrate de haber ejecutado `sudo fc-cache -f -v` tras la instalación.
2. Verifica que las fuentes en `/usr/share/fonts/TTF/` tengan permisos de lectura para todos los usuarios:
   ```bash
   sudo chmod 644 /usr/share/fonts/TTF/*
   ```
3. Reinicia el gestor SDDM para aplicar los cambios (guardando tu sesión antes):
   ```bash
   sudo systemctl restart sddm
   ```

### Elementos fuera de escala o recortados
- Ajusta el valor de `FontSize` y `ClockFontSize` en `theme.conf`.
- Si los efectos visuales van lentos, desactiva o reduce el desenfoque en `theme.conf`:
  ```ini
  FullBlur="false"
  PartialBlur="false"
  ```

### El Tema no se Aplica / Pantalla Negra o fallback al Tema Clásico
1. **Falta de Dependencias de Qt5 QML**: Si tu sistema usa Qt6 por defecto (como en instalaciones modernas de Arch o CachyOS), asegúrate de haber instalado los módulos gráficos y de controles de Qt5:
   ```bash
   sudo pacman -S qt5-graphicaleffects qt5-quickcontrols2
   ```
2. **Conflicto con otros Display Managers**: Si ya reiniciaste y la pantalla de inicio no cambia, verifica que `sddm.service` sea el gestor de inicio activo en lugar de otros como `plasmalogin.service` (Plasma Login Manager):
   ```bash
   sudo systemctl disable plasmalogin.service
   sudo systemctl enable sddm.service
   ```