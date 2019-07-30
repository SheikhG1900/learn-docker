# install theme link
# http://localhost:8069/web?reload#action=website_theme_install.theme_install_kanban_action&menu_id=
    
# scaffold new module
odoo scaffold new_module aw  # module name -> new module to the folder, aw.


docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo -e POSTGRES_DB=postgres --name odoo-db postgres:10
docker run -v E:\work\odoo_addons:/mnt/extra-addons -p 8069:8069 --name odoo --link odoo-db:db -t odoo

# use db in terminal
psql postgres odoo  # to connect database
sql>\dt *.*  # show tables




docker start -ia odoo #to start odoo server

