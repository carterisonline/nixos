{ pkgs }:

pkgs.gnomeExtensions.buildShellExtension {
  uuid = "auto-screen-brightness@popov895.ukr.net";
  name = "Auto Screen Brightness";
  pname = "auto-screen-brightness";
  description = "Automatically switch the screen brightness depending on the power supply status";
  link = "https://extensions.gnome.org/extension/7311/auto-screen-brightness/";
  version = 18;
  sha256 = "1i1q5l3bh51j2ggvg6mm81f8rgihs9dgmcx324m8j0zkzf41jdb8";
  metadata = "ewogICJfZ2VuZXJhdGVkIjogIkdlbmVyYXRlZCBieSBTd2VldFRvb3RoLCBkbyBub3QgZWRpdCIsCiAgImRlc2NyaXB0aW9uIjogIkF1dG9tYXRpY2FsbHkgc3dpdGNoIHRoZSBzY3JlZW4gYnJpZ2h0bmVzcyBkZXBlbmRpbmcgb24gdGhlIHBvd2VyIHN1cHBseSBzdGF0dXMiLAogICJkb25hdGlvbnMiOiB7CiAgICAiY3VzdG9tIjogImh0dHBzOi8vZ2l0aHViLmNvbS9wb3Bvdjg5NS9wb3Bvdjg5NSIKICB9LAogICJuYW1lIjogIkF1dG8gU2NyZWVuIEJyaWdodG5lc3MiLAogICJzZXNzaW9uLW1vZGVzIjogWwogICAgInVubG9jay1kaWFsb2ciLAogICAgInVzZXIiCiAgXSwKICAic2V0dGluZ3Mtc2NoZW1hIjogIm9yZy5nbm9tZS5zaGVsbC5leHRlbnNpb25zLmF1dG8tc2NyZWVuLWJyaWdodG5lc3MiLAogICJzaGVsbC12ZXJzaW9uIjogWwogICAgIjQ1IiwKICAgICI0NiIsCiAgICAiNDciCiAgXSwKICAidXJsIjogImh0dHBzOi8vZ2l0aHViLmNvbS9wb3Bvdjg5NS9hdXRvLXNjcmVlbi1icmlnaHRuZXNzIiwKICAidXVpZCI6ICJhdXRvLXNjcmVlbi1icmlnaHRuZXNzQHBvcG92ODk1LnVrci5uZXQiLAogICJ2ZXJzaW9uIjogMTgKfQ==";
}
