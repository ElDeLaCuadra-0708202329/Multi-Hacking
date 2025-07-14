#!/bin/bash

# NOMBRE DEL SCRIPT: 'Captura.sh'

# CREADOR: el_de_la_cuadra
# TIPO: Herramienta
# LANZAMIENTO: 08-07-2025

creador="el_de_la_cuadra"
hora=$(date)




# COLORES NORMALES
rojo="\e[1;31m"
verde="\e[1;32m"
morado="\e[1;35m"
amarillo="\e[1;33m"
cyan="\e[1;34m"
azul="\e[1;36m"
gris="\e[1;37m"
reset="\e[0m"

# COLORES LUMINOSOS.
rojo_b="\e[0;31m"
verde_b="\e[0;32m"
gris_b="\e[0;37m"
morado_b="\e[0;35m"

# COLORES PARPADEANTES.
rojo_p="\e[5;1;31m"
verde_p="\e[5;1;32m"
morado_p="\e[5;1;35m"
amarillo_p="\e[5;1;33m"
cyan_p="\e[5;1;34m"
azul_p="\e[5;1;36m"
gris_p="\e[5;1;37m"

# COLORES DE FONDO.
rojo_f="\e[1;37;41m"
verde_f="\e[1;37;42m"
morado_f="\e[1;37;45m"
amarillo_f="\e[1;37;43m"
cyan_f="\e[1;37;44m"
azul_f="\e[1;37;46m"
gris_f="\e[1;30;47m"

# COLORES SUBRAYADOS
rojo_s="\e[4;1;31m"
verde_s="\e[4;1;32m"
morado_s="\e[4;1;35m"
amarillo_s="\e[4;1;33m"
cyan_s="\e[4;1;34m"
azul_s="\e[4;1;36m"
gris_s="\e[4;1;37m"
amarillo_sb="\e[4;0;33m"

# Conceder permisos de super usuario.
if [ $(id -u) -ne 0 ]; then
       echo -e "${gris}Para ejecutar esta herramienta debe ser super usuario (${rojo_p}!${reset}${gris})${reset}"

exit

fi

# Imprimir banner.
Imprimir_banner() {
         clear
         echo -e "${verde}+ ${amarillo_f}Creditos:${reset}${gris}(${reset} ${morado_s}$creador${reset} ${gris})   ${verde}* ${amarillo_f}Date:${reset}${gris}(${reset} ${morado_s}$hora${reset} ${gris})${reset}"
         echo ""
         figlet "Hacking Redes"
         echo -e "${gris}(${verde}i${gris}) Bienvenido${reset}"
         echo ""
         echo -e "${gris}"
}

# Ejecutar script.
Imprimir_banner
read -p "Vuelve a colocar el (BSSID)=(" bssid
sleep 1
echo -e "${gris}"
read -p "Introduce el numero de (CH)=(" chan
sleep 1
mkdir $bssid/
echo ""
echo -e "${gris}(${amarillo_p}*${reset}${gris})Iniciando Captura De Paquetes...${reset}"
sleep 3
airodump-ng -c $chan --bssid $bssid -w $bssid wlan0mon && mv *.cap $bssid/ && rm *.csv && rm *.netxml
echo -e "${rojo}"
read -p "Presione Control + c Para Finalizar."
echo -e "${reset}"
sleep 1
exit & exit

