
link_directories (${DEPS_LIBRARY_DIRS} ${CMAKE_CURRENT_BINARY_DIR}/../../lib)
add_definitions (${DEPS_CFLAGS} "-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\"")


set(G_NAME google)

vala_precompile(OAUTH_G_PLUGIN_VALA_C ${G_NAME}
    google.vala
PACKAGES
    ${DEPS_PACKAGES}
OPTIONS
    ${GLOBAL_VALAC_OPTIONS}
)

add_library(${G_NAME} MODULE ${OAUTH_G_PLUGIN_VALA_C})
target_link_libraries (${G_NAME} ${DEPS_LIBRARIES})
add_dependencies(${G_NAME} ${PLUGNAME})

install(TARGETS ${G_NAME} DESTINATION ${PLUGIN_DIR}/generic-oauth-plugins/)
install(FILES 32/online-account-google.svg DESTINATION ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/32x32/apps)
install(FILES 48/online-account-google.svg DESTINATION ${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/48x48/apps)
install(FILES google.provider DESTINATION ${ACCOUNTS_DIR}/providers/)
install(FILES google-calendar.service DESTINATION ${ACCOUNTS_DIR}/services/)
install(FILES google-contacts.service DESTINATION ${ACCOUNTS_DIR}/services/)
install(FILES google-drive.service DESTINATION ${ACCOUNTS_DIR}/services/)
install(FILES google-photos.service DESTINATION ${ACCOUNTS_DIR}/services/)
install(FILES google-gmail.service DESTINATION ${ACCOUNTS_DIR}/services/)
