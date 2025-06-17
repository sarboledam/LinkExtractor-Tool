#!/bin/bash

# LinkExtractor Tool - Installation Script
# Universidad Católica de Manizales
# Especialización en Ciberseguridad 2025

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Banner
echo -e "${BLUE}"
echo "╔══════════════════════════════════════════════════╗"
echo "║        LinkExtractor Tool Installer v1.0                          ║"
echo "║         Universidad Católica de Manizales                         ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${NC}"

# Function to print colored messages
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Check OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        OS="windows"
    else
        OS="unknown"
    fi
    print_info "Sistema operativo detectado: $OS"
}

# Check Python
check_python() {
    print_info "Verificando instalación de Python..."
    
    if command -v python3 &> /dev/null; then
        PYTHON_CMD="python3"
        PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
        print_success "Python $PYTHON_VERSION encontrado"
    elif command -v python &> /dev/null; then
        PYTHON_VERSION=$(python -c 'import sys; print(sys.version_info[0])')
        if [ "$PYTHON_VERSION" -eq 3 ]; then
            PYTHON_CMD="python"
            print_success "Python 3 encontrado"
        else
            print_error "Se requiere Python 3.6 o superior"
            exit 1
        fi
    else
        print_error "Python no está instalado"
        print_info "Por favor instala Python 3.6 o superior desde https://www.python.org"
        exit 1
    fi
}

# Create virtual environment
create_venv() {
    print_info "Creando entorno virtual..."
    
    if [ -d "venv" ]; then
        print_warning "El entorno virtual ya existe"
        read -p "¿Deseas recrearlo? (s/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Ss]$ ]]; then
            rm -rf venv
            $PYTHON_CMD -m venv venv
            print_success "Entorno virtual recreado"
        fi
    else
        $PYTHON_CMD -m venv venv
        print_success "Entorno virtual creado"
    fi
}

# Install dependencies
install_deps() {
    print_info "Instalando dependencias..."
    
    # Activate virtual environment
    if [[ "$OS" == "windows" ]]; then
        source venv/Scripts/activate 2>/dev/null || source venv/bin/activate
    else
        source venv/bin/activate
    fi
    
    # Upgrade pip
    pip install --upgrade pip > /dev/null 2>&1
    
    # Install requirements
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
        if [ $? -eq 0 ]; then
            print_success "Todas las dependencias instaladas"
        else
            print_error "Error al instalar dependencias"
            exit 1
        fi
    else
        print_warning "requirements.txt no encontrado, instalando manualmente..."
        pip install requests beautifulsoup4 lxml
    fi
}

# Test installation
test_installation() {
    print_info "Verificando instalación..."
    
    $PYTHON_CMD -c "import requests, bs4" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        print_success "Instalación verificada correctamente"
    else
        print_error "Error al importar módulos"
        exit 1
    fi
}

# Create directories
create_dirs() {
    print_info "Creando estructura de directorios..."
    
    dirs=("output" "logs")
    for dir in "${dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            print_success "Directorio creado: $dir"
        fi
    done
}

# Main
main() {
    echo -e "${GREEN}Iniciando instalación de LinkExtractor Tool...${NC}"
    echo
    
    detect_os
    check_python
    create_venv
    install_deps
    test_installation
    create_dirs
    
    echo
    echo -e "${GREEN}╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║        ¡Instalación completada con éxito!                         ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${YELLOW}Para usar la herramienta:${NC}"
    echo
    echo "1. Activa el entorno virtual:"
    echo -e "   ${BLUE}source venv/bin/activate${NC} (Linux/macOS)"
    echo -e "   ${BLUE}venv\\Scripts\\activate${NC} (Windows)"
    echo
    echo "2. Ejecuta la herramienta:"
    echo -e "   ${BLUE}python LinkExtractor-Tool.py${NC}"
    echo
    echo -e "${GREEN}¡Feliz hacking ético!${NC}"
}

# Run
main