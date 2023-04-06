function prompt {
  $host.UI.write("green", $host.UI.RawUI.BackgroundColor, "PS ");
  $host.UI.writeline("yellow", $host.UI.RawUI.BackgroundColor, (get-location).Path);
  "> "
}