String transformarFoto(url) {
  //replace substring of the given string
  return url.replaceAll(
      "http://localhost/API-REST-PHP/", "http://10.0.2.2:80/API-REST-PHP/");
}
