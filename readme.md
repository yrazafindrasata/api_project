# project_CRM




#### Init
Dans la classe ServiceApi, changer l'adresse ip de la variable "uri" avec l'adresse ip du contenair de dreamfactory, afin de pouvoir appeler l'api

```bash
docker-compose up -d
docker-compose exec --user=application web bash
composer install

```
homepage pour selectionner l'utilisateur: http://127.0.0.1/user