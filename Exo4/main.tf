provider "local" {
}

variable "movies_name" {
  description = "movies and their comments"
  type = list(object({
    name = string
    comment = string
  }))
  default = [
    { name = "Inception", comment = "a movie in dream" },
    { name = "Interstellar", comment = "a movie in space" },
    { name = "The Matrix", comment = "a movie in computer" }
  ]
}

resource "local_file" "movies_file" {
  filename = "${path.module}/Movies.txt"
  content = join("\n", [for movie in var.movies_name : "${movie.name}: ${movie.comment}"])
}
