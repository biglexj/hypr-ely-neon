#!/bin/bash

# Hypr Ely-Neon Theme - Script de Instalación Automatizada
# Biglex J - 2026

# Colores para output con estilo Cyberpunk
PINK='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Mostrar un hermoso banner de bienvenida
echo -e "${PINK}"
echo "  _   _                  _   _                      "
echo " | | | | _   _  _ __  _ | | | |  ___   ___   _ __   "
echo " | |_| || | | || '_ \| || |_| | / _ \ / _ \ | '_ \  "
echo " |  _  || |_| || |_) || ||  _  ||  __/| (_) || | | |"
echo " |_| |_| \__, || .__/ |_||_| |_| \___| \___/ |_| |_|"
echo "         |___/ |_|                                  "
echo -e "${NC}"
echo -e "${CYAN}🌟 Hypr Ely-Neon SDDM Theme - Instalador Automático 🌟${NC}"
echo -e "${CYAN}====================================================${NC}"

# Detecta el directorio del script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Verificar privilegios de root (auto-elevación)
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}🔑 Este script necesita permisos de administrador para instalar componentes de sistema.${NC}"
    echo -e "${YELLOW}Solicitando permisos con sudo...${NC}"
    exec sudo bash "$0" "$@"
fi

echo -e "${GREEN}✅ Ejecutando como superusuario.${NC}"

# 1. Instalar Fira Sans desde repositorios de distribución
install_fira_sans() {
    echo -e "\n${CYAN}📦 [1/4] Instalando Fira Sans desde el repositorio de tu distribución...${NC}"
    if command -v pacman &> /dev/null; then
        echo -e "${YELLOW}Detectado: Arch Linux (pacman)${NC}"
        pacman -S --needed --noconfirm ttf-fira-sans qt5-graphicaleffects qt5-quickcontrols2
    elif command -v apt-get &> /dev/null; then
        echo -e "${YELLOW}Detectado: Debian/Ubuntu (apt)${NC}"
        apt-get update
        apt-get install -y fonts-fira-sans || apt-get install -y fonts-firacode
    elif command -v dnf &> /dev/null; then
        echo -e "${YELLOW}Detectado: Fedora (dnf)${NC}"
        dnf install -y fira-sans-fonts
    elif command -v zypper &> /dev/null; then
        echo -e "${YELLOW}Detectado: openSUSE (zypper)${NC}"
        zypper install -y fira-sans-fonts
    else
        echo -e "${RED}❌ No se pudo determinar el gestor de paquetes. Por favor, instala 'Fira Sans' manualmente.${NC}"
    fi
}

install_fira_sans

# 2. Copiar fuentes locales (Kefa y Ndot)
install_local_fonts() {
    echo -e "\n${CYAN}📂 [2/4] Copiando fuentes locales (Kefa y Ndot) a /usr/share/fonts/TTF/...${NC}"
    
    # Crear directorio si no existe
    mkdir -p /usr/share/fonts/TTF
    
    if [ -d "$SCRIPT_DIR/fonts" ]; then
        # Copiar todas las fuentes recursivamente a la carpeta de fuentes TTF del sistema
        find "$SCRIPT_DIR/fonts" -type f \( -name "*.ttf" -o -name "*.otf" \) -exec cp -v {} /usr/share/fonts/TTF/ \;
        
        echo -e "${BLUE}🔄 Actualizando el caché de fuentes del sistema...${NC}"
        fc-cache -f -v > /dev/null
        echo -e "${GREEN}✅ Fuentes instaladas y caché actualizado correctamente.${NC}"
    else
        echo -e "${RED}❌ Error: No se encontró la carpeta 'fonts' en $SCRIPT_DIR/fonts.${NC}"
    fi
}

install_local_fonts

# 3. Copiar el tema a la carpeta de SDDM
install_sddm_theme() {
    THEME_DEST="/usr/share/sddm/themes/hypr-ely-neon"
    echo -e "\n${CYAN}🎨 [3/4] Instalando el tema SDDM en: $THEME_DEST...${NC}"
    
    # Crear carpeta madre si no existe
    mkdir -p /usr/share/sddm/themes
    
    # Limpiar versión previa si existe
    if [ -d "$THEME_DEST" ]; then
        echo -e "${YELLOW}Eliminando versión previa instalada...${NC}"
        rm -rf "$THEME_DEST"
    fi
    
    mkdir -p "$THEME_DEST"
    
    # Copiar los recursos necesarios para el funcionamiento
    cp -r "$SCRIPT_DIR/Assets" "$THEME_DEST/"
    cp -r "$SCRIPT_DIR/Backgrounds" "$THEME_DEST/"
    cp -r "$SCRIPT_DIR/Components" "$THEME_DEST/"
    cp -r "$SCRIPT_DIR/fonts" "$THEME_DEST/"
    cp "$SCRIPT_DIR/Main.qml" "$THEME_DEST/"
    cp "$SCRIPT_DIR/metadata.desktop" "$THEME_DEST/"
    cp "$SCRIPT_DIR/theme.conf" "$THEME_DEST/"
    
    if [ -f "$SCRIPT_DIR/theme.conf.user" ]; then
        cp "$SCRIPT_DIR/theme.conf.user" "$THEME_DEST/"
    fi
    
    echo -e "${GREEN}✅ Tema copiado exitosamente a $THEME_DEST.${NC}"
}

install_sddm_theme

# 4. Configurar SDDM
configure_sddm() {
    echo -e "\n${CYAN}⚙️ [4/4] Configuración de SDDM...${NC}"
    
    # Preguntar de forma interactiva si desea activar el tema
    read -p "¿Deseas activar 'hypr-ely-neon' como el tema actual de tu SDDM? (S/n): " active_theme
    active_theme=${active_theme:-S}
    
    if [[ "$active_theme" =~ ^[SsYy]$ ]]; then
        # Asegurar directorio de configuración
        mkdir -p /etc
        
        # Respaldo si sddm.conf ya existe
        if [ -f /etc/sddm.conf ]; then
            echo -e "${YELLOW}Creando copia de seguridad: /etc/sddm.conf.bak${NC}"
            cp /etc/sddm.conf /etc/sddm.conf.bak
        fi
        
        # Agregar o actualizar la sección [Theme] y Current
        if [ -f /etc/sddm.conf ] && grep -q "^\[Theme\]" /etc/sddm.conf; then
            if grep -q "^Current=" /etc/sddm.conf; then
                sed -i 's/^Current=.*/Current=hypr-ely-neon/' /etc/sddm.conf
            else
                sed -i '/^\[Theme\]/a Current=hypr-ely-neon' /etc/sddm.conf
            fi
        else
            echo -e "\n[Theme]\nCurrent=hypr-ely-neon" >> /etc/sddm.conf
        fi
        
        echo -e "${GREEN}✅ Configuración completada. Se ha configurado 'hypr-ely-neon' en /etc/sddm.conf.${NC}"
        
        # NO deshabilitar plasmalogin — en KDE Plasma 6 es el display manager oficial
        echo -e "${BLUE}🔄 Asegurando que plasmalogin esté activo como gestor de inicio...${NC}"
        if ! systemctl is-enabled sddm.service &>/dev/null; then
            systemctl enable sddm.service
        fi
        echo -e "${GREEN}✅ Configuración del tema completada. plasmalogin sigue siendo el gestor de inicio.${NC}"
    else
        echo -e "${YELLOW}ℹ️ Instalación del tema completada sin modificar la configuración activa de SDDM.${NC}"
    fi
}

configure_sddm

echo -e "\n${PINK}🎉 ¡Felicitaciones! La instalación de Hypr Ely-Neon SDDM Theme ha finalizado exitosamente. 🎉${NC}"
echo -e "${CYAN}Disfruta de la nueva estética neon/cyberpunk en tu inicio de sesión. 🚀${NC}\n"
