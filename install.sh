#!/usr/bin/env bash

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

	mkdir -p "${THEME_DIR}/scalable"
	cp -r src/scalable/{apps,devices,mimetypes} "${THEME_DIR}/scalable"
	cp -r src/scalable/places "${THEME_DIR}/scalable/places"

	sed -i "s/#5294e2/${theme_color}/g" "${THEME_DIR}/scalable/apps/"*.svg "${THEME_DIR}/scalable/places/"default-*.svg
	sed -i "/\ColorScheme-Highlight/s/currentColor/${theme_color}/" "${THEME_DIR}/scalable/places/"default-*.svg
	sed -i "/\ColorScheme-Background/s/currentColor/#ffffff/" "${THEME_DIR}/scalable/places/"default-*.svg

	cp -r links/scalable "${THEME_DIR}"

	ln -sr "${THEME_DIR}/scalable"                                                 "${THEME_DIR}/scalable@2x"

	gtk-update-icon-cache "${THEME_DIR}"
}
install_theme
