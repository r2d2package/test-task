server {
	listen *:80;
	root /var/www/site-2.ru/doc_root;
	index index.php index.html index.htm index.nginx-debian.html;
	server_name site-2.ru www.site-2.ru;

	access_log /var/www/site-2.ru/logs/nginx/access.log nixys;
	error_log /var/www/site-2.ru/logs/nginx/error.log;


	location / {
		try_files $uri $uri/ =404;
	}
#########site-2.ru php-info
       location ~ \.php$ {
               include snippets/fastcgi-php.conf;
               fastcgi_pass unix:/var/run/php/php8.1-fpm-site-2.ru.sock;
        }



	location /fgm {
		alias /var/www/site-2.ru/filegator;
		location ~* ^.+\.(js|css|html|htm|png|jpg|jpeg|gif|ico)$ {
			access_log /var/www/site-2.ru/logs/nginx/img.log;
			access_log    on;
			log_not_found    off;
			expires 1M;
			}
		location ~ \.php$ {
			include fastcgi_params;
			fastcgi_param SCRIPT_FILENAME $request_filename;
			fastcgi_split_path_info ^(.+\.php)(/.+)$;
			fastcgi_index index.php;
			fastcgi_pass unix:/var/run/php/php8.1-fpm-site-2.ru.sock;
                 }
	}

	location /phpmyadmin {
		root /usr/share/;
		index index.php;

		location ~ ^/phpmyadmin/(doc|sql|setup)/ {
			deny all;
		}		



		location ~* ^.+\.(js|css|html|htm|png|jpg|jpeg|gif|ico)$ {
                access_log /var/www/site-2.ru/logs/nginx/img.log;
                access_log    on;
                log_not_found    off;
                expires 1M;
              }
	location ~ \.php$ {
	        include fastcgi_params;
	        fastcgi_param SCRIPT_FILENAME $request_filename;
	        fastcgi_split_path_info ^(.+\.php)(/.+)$;
	        fastcgi_index index.php;
		fastcgi_pass unix:/var/run/php/php8.1-fpm-site-2.ru.sock;
		}
	}



}

