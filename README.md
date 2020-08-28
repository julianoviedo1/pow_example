# README

# Como levantar la app en localhost
# rails server 

# Setup inicial de la app
# rails new pow_proyect --database postgresql
# cd pow_proyect
# veo si le quiero agregar devise y lo instalo en caso de que si
# luego db:create db:migrate

# Descripción breve de la arquitectura de App
# Modelos: User y Places (un user busca varios places)
# Controllers: Places -> busca info de la api con parametros predeterminados
# Flights -> busca los lugares de places los lista en un form para que el usuario busque la info que quiera.
# Views -> home e index de flight 

