provider "local" {
}

resource "local_file" "film_file" {
  filename = "film.txt"
  content  = "GoldenEyes"
}