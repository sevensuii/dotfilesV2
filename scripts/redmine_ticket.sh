#!/bin/bash
# ejecutar 
# sudo ln -s $HOME/git_repos/dotfiles/scripts/redmine_ticket.sh /usr/local/bin/redmine
# para poder ejecutar el comando desde donde quiera, incluso con rofi

# Establece los valores por defecto
filename=""
editor='phpstorm'
rutaRedmine="$HOME/Documentos/redmine_doc/"

if [[ "$1" == "-n" ]]; then
  # Si se pasó el flag -n
  shift # Desplaza los argumentos una posición a la izquierda
  filename="$1.md" # Obtiene el nombre del archivo a crear sin RM
else
  # Si no se pasó el flag -n
  filename="RM$1.md" # Obtiene el nombre del archivo a crear con RM
fi

# Verifica si el archivo ya existe
if [[ -e "$filename" ]]; then
  echo "El archivo $rutaRedmine$filename ya existe."
else
  touch "$rutaRedmine$filename" # Crea el archivo vacío
  echo "Archivo $rutaRedmine$filename creado exitosamente."
fi

$editor $rutaRedmine$filename
