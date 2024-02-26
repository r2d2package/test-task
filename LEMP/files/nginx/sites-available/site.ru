server {
        listen  *:80;
		server_name site.ru www.site.ru;
 
	access_log /var/www/site.ru/logs/nginx/access.log;
	error_log /var/www/site.ru/logs/nginx/error.log;
	root /var/www/site.ru/doc_root;
	index index.php; 
	location ~ /\.(svn|git|hg) {
		deny all;
	}

location / {
try_files $uri /index.php;
}
######site.ru	
	location ~* ^.+\.(htm|html|css|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|js|swf|ttf)$ {
                access_log /var/www/site.ru/logs/nginx/img.log;
		expires max;
		access_log on;
		}

	location ~ \.php$ {
		proxy_pass	http://127.0.0.1:81; # apache
		proxy_redirect	off;
 
		proxy_set_header   Host			$host;
		proxy_set_header   X-Real-IP		$remote_addr;
		proxy_set_header   X-Forwarded-For	$remote_addr;
		proxy_set_header   X-Forwarded-Proto	$scheme;

		client_max_body_size	64m;
		client_body_buffer_size	1280k;

		proxy_connect_timeout	90;
		proxy_send_timeout	90;
		proxy_read_timeout	90;

		proxy_buffer_size	4k;
		proxy_buffers		4 32k;
		proxy_busy_buffers_size	64k;
		proxy_temp_file_write_size 64k;
		}


location /phpmyadmin {
  root /usr/share/;
  index index.php;

   location ~ ^/(doc|sql|setup)/ {
    deny all;
  }

 
  location ~ ^.+\.php$ {
		 proxy_pass      http://127.0.0.1:81; # apache
                proxy_redirect  off;

                proxy_set_header   Host                 $host;
                proxy_set_header   X-Real-IP            $remote_addr;
                proxy_set_header   X-Forwarded-For      $remote_addr;
                proxy_set_header   X-Forwarded-Proto    $scheme;

                client_max_body_size    64m;
                client_body_buffer_size 1280k;

                proxy_connect_timeout   90;
                proxy_send_timeout      90;
                proxy_read_timeout      90;

                proxy_buffer_size       4k;
                proxy_buffers           4 32k;
                proxy_busy_buffers_size 64k;
                proxy_temp_file_write_size 64k;

  }

  # Load media from correct root
  location ~  ^.+\.(jpg|jpeg|gif|css|png|js|ico|html|xml|txt)$ {
	  root /usr/share/;
	}

}





}
