# scaffold new module
odoo scaffold new_module aw  # module name -> new module to the folder, aw.


docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name odoo-db postgres:10
docker run -v E:\work\odoo_addons:/mnt/extra-addons -p 8069:8069 --name odoo --link odoo-db:db -t odoo
