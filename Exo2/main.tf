provider "local" {
}

variable "movie_name" {
  type    = string
  default = "Baba"
}

resource "local_file" "film_file" {
  filename = "film.txt"
  content  = var.movie_name
}

output "movie_file_create" {
  value = "Movie file created: ${local_file.film_file.filename}"
}