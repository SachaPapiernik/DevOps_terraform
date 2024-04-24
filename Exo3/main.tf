variable "movies_name" {
  description = "Map of movies and their comments"
  type        = map(string)
  default     = {
    "Inception" = "a movie in dream"
    "Interstellar" = "a movie in space"
    "The Matrix" = "a movie in computer"
  }
}

resource "local_file" "movie_file" {
  content  = <<EOF
Film: Inception
Commentaire: ${var.movies_name["Inception"]}

Film: Interstellar
Commentaire: ${var.movies_name["Interstellar"]}

Film: The Matrix
Commentaire: ${var.movies_name["The Matrix"]}
EOF
  filename = "${path.module}/Movies.txt"
}
