provider "docker" {

}

resource "docker_volume" "mysql_data" {
  name = "mysql_data"
}

resource "docker_container" "mysql" {
  name  = "mysql"
  image = "mysql"
  env = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=wordpresspassword"
  ]
  volumes {
    volume_name    = docker_volume.mysql_data.name
    container_path = "/Users/pylejeune/terraform/docker-wordpress/lib/mysql"
  }
  ports {
    internal = 3306
    external = 3306
  }
  restart = "always"
}

resource "docker_image" "wordpress" {
  name         = "wordpress:latest"
  keep_locally = false
}

resource "docker_container" "wordpress" {
  image = docker_image.wordpress.image_id
  name  = "wordpress"
  env = [
    "WORDPRESS_DB_HOST=mysql:3306",
    "WORDPRESS_DB_USER=wordpress",
    "WORDPRESS_DB_PASSWORD=wordpresspassword",
    "WORDPRESS_DB_NAME=wordpress"
  ]
  ports {
    internal = 80
    external = 8080
  }
  restart = "always"
}