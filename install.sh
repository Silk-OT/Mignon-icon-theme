
install_theme() {
	local -r DEST_DIR="${HOME}/.local/share/icons"
	local -r theme_color='#99C0ED'

	local -r THEME_NAME="Mignon-pastel"
	local -r THEME_DIR="${DEST_DIR}/${THEME_NAME}"

	if [ -d "${THEME_DIR}" ]; then
		rm -r "${THEME_DIR}"
	fi

	echo "Installing '${THEME_NAME}'..."

	install -d "${THEME_DIR}"

	install -m644 "src/index.theme" "${THEME_DIR}"

	# Update the name in index.theme
	sed -i "s/%NAME%/${THEME_NAME//-/ }/g" "${THEME_DIR}/index.theme"

	cp -r src/{16,22,24,32,symbolic} "${THEME_DIR}"
	mkdir -p "${THEME_DIR}/scalable"
	cp -r src/scalable/{apps,devices,mimetypes} "${THEME_DIR}/scalable"
	cp -r src/scalable/places "${THEME_DIR}/scalable/places"

	sed -i "s/#5294e2/${theme_color}/g" "${THEME_DIR}/scalable/apps/"*.svg "${THEME_DIR}/scalable/places/"default-*.svg "${THEME_DIR}/16/places/"folder*.svg
	sed -i "/\ColorScheme-Highlight/s/currentColor/${theme_color}/" "${THEME_DIR}/scalable/places/"default-*.svg "${THEME_DIR}/16/places/"folder*.svg
	sed -i "/\ColorScheme-Background/s/currentColor/#ffffff/" "${THEME_DIR}/scalable/places/"default-*.svg

	cp -r links/{16,22,24,32,scalable,symbolic} "${THEME_DIR}"
	cp -r links/16/{actions,devices,places} "${THEME_DIR}/16"
	cp -r links/22/{actions,devices,places} "${THEME_DIR}/22"
	cp -r links/24/{actions,devices,places} "${THEME_DIR}/24"
	cp -r links/symbolic/* "${THEME_DIR}/symbolic"

	ln -sr "${THEME_DIR}/16"                                                       "${THEME_DIR}/16@2x"
	ln -sr "${THEME_DIR}/22"                                                       "${THEME_DIR}/22@2x"
	ln -sr "${THEME_DIR}/24"                                                       "${THEME_DIR}/24@2x"
	ln -sr "${THEME_DIR}/32"                                                       "${THEME_DIR}/32@2x"
	ln -sr "${THEME_DIR}/scalable"                                                 "${THEME_DIR}/scalable@2x"

	gtk-update-icon-cache "${THEME_DIR}"
}
install_theme
