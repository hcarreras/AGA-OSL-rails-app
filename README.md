Esta es la aplicacion de rails del [proyecto AGA-OSL](https://github.com/Samu92/AGA-OSL).

Deploy en Ubuntu

Si no tienes ni Ruby ni Rails instalado tendrás que instalar una cuantas cosas:
Primero Curl para poder instalar RVM

    $ sudo apt-get install curl

Luego RVM, un gestor de versiones de ruby

    $ \curl -L https://get.rvm.io | bash -s stable --ruby
    $ rvm install ruby
    $ rvm --default use ruby-2.1.3
    
Es necesario tener nodejs instalado para compilar el javascript de rails

    $ sudo apt-get install nodejs

Instalamos Rails

    $ gem install rails --version=4.0.12
    
Clonamos el repositorio

    $ git clone https://github.com/hcarreras/AGA-OSL-rails-app.git
    
Accedemos a el repositorio e instalamos las gemas

    $ cd AGA-OSL-rails-app.git
    $ bundle install
    
Por último podemos iniciar el servidor

    $ rails s
    
Ejemplos de uso:

CREATE:
      curl -X POST -H "Content-Type: application/json" -d "{\"data\":[\"test2\",\"no importante2\",\"borrable2\"]}"  http://localhost:3000/stock
      
UPDATE:
      curl -X PUT -H "Content-Type: application/json" -d "{\"data\":[\"azucar\",\"miel\",\"oregano\"]}"  http://localhost:3000/stock/251
      
DELETE:
      curl -X "DELETE" localhost:3000/stock/235
    
    
    
