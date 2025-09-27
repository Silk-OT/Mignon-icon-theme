{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  kdePackages,
  hicolor-icon-theme,
  adwaita-icon-theme,
  breeze-icons,
  mint-y-icons,
}:

stdenvNoCC.mkDerivation rec {
  pname = "mignon-icon-theme";
  version = "unstable-2025-09-05";

  src = fetchFromGitHub {
    owner = "IgorFerreiraMoraes";
    repo = "Mignon-icon-theme";
    rev = "5b065dba10b0fbaec6f8e65e604f3fca193c31a4";
    hash = "sha256-Rtr6NFGVMgs1Oqu/XqHiqaWeGsuvFzdwd/kbqTntQUg=";
  };

  nativeBuildInputs = [
    gtk3
  ];

  buildInputs = [
    mint-y-icons
    hicolor-icon-theme
    adwaita-icon-theme
    breeze-icons
  ];

  propagatedBuildInputs = [ 
    mint-y-icons
    hicolor-icon-theme
    adwaita-icon-theme
    breeze-icons
  ];

  dontBuild = true;
  dontWrapQtApps = true;
  #dontCheckForBrokenSymlinks = true;
  dontDropIconThemeCache = true;

  installPhase = ''
    runHook preInstall

    theme_name="Mignon-pastel"
    theme_color='#99C0ED'
    dest="$out/share/icons/$theme_name"
    mkdir -p "$dest"

    cp -a ./src/index.theme "$dest/index.theme"
    sed -i "s/%NAME%/''${theme_name//-/ }/g" "$dest/index.theme"

    mkdir -p "$dest/scalable"
    cp -a ./src/scalable/{apps,devices,mimetypes} "$dest/scalable"
    cp -a ./src/scalable/places "$dest/scalable/places"

    sed -i "s/#5294e2/$theme_color/g" "$dest/scalable/apps/"*.svg "$dest/scalable/places/"default-*.svg
    sed -i "/\ColorScheme-Highlight/s/currentColor/$theme_color/" "$dest/scalable/places/"default-*.svg
    sed -i "/\ColorScheme-Background/s/currentColor/#ffffff/" "$dest/scalable/places/"default-*.svg

    cp -a links/scalable "$dest/"

    find "$dest" -xtype l -exec rm {} +

    ln -sr "$dest/scalable" "$dest/scalable@2x"

    runHook postInstall
  '';


  meta = with lib; {
    description = "Flat, Pastel, Cute Icons for Linux";
    homepage = "https://github.com/IgorFerreiraMoraes/Mignon-icon-theme";
    license = lib.licenses.gpl3Only;
    maintainers = with maintainers; [ Silk-OT ];
    mainProgram = "mignon-icon-theme";
    platforms = platforms.linux;
  };
}
