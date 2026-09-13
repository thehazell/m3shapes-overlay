# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 multilib

DESCRIPTION="Qt6 QML plugin providing Material Design 3 shapes with morph animation"
HOMEPAGE="https://github.com/soramanew/m3shapes"
EGIT_REPO_URI="https://github.com/soramanew/m3shapes.git"
EGIT_BRANCH="main"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="examples"

# Core lib needs Qt Core only; the QML plugin itself needs Quick/Qml/Gui.
DEPEND="
	dev-qt/qtbase:6[gui]
	dev-qt/qtdeclarative:6
"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/qtshadertools:6"

src_configure() {
	local mycmakeargs=(
		# Upstream's CMakeLists installs the QML module at a path that is
		# itself prefixed with "usr/" (INSTALL_QMLDIR defaults to
		# "usr/lib/qt6/qml") and treats it as relative to
		# CMAKE_INSTALL_PREFIX. Gentoo's cmake.eclass sets that prefix to
		# ${EPREFIX}/usr by default, which would combine into
		# ${EPREFIX}/usr/usr/lib.../qml. Point the prefix at the root
		# instead so the upstream-relative "usr/..." path lands correctly,
		# and use get_libdir so this works on both lib and lib64 profiles.
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/"
		-DINSTALL_QMLDIR="usr/$(get_libdir)/qt6/qml"
		-DM3SHAPES_BUILD_EXAMPLES=$(usex examples)
	)

	cmake_src_configure
}