# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Upstream has never cut a tag, so this snapshot pins a known-good commit
# from the main branch instead of tracking it live. Bump COMMIT (and the
# _p<date> in ${PV}) when you want a newer snapshot.
COMMIT="32ad9ce328bb77ed349b40a3be10ee9ea610b8ab"

inherit cmake multilib

DESCRIPTION="Qt6 QML plugin providing Material Design 3 shapes with morph animation"
HOMEPAGE="https://github.com/soramanew/m3shapes"
SRC_URI="https://github.com/soramanew/m3shapes/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND="
	dev-qt/qtbase:6[gui]
	dev-qt/qtdeclarative:6
"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/qtshadertools:6"

src_configure() {
	local mycmakeargs=(
		# See the 9999 ebuild for why the prefix and QML dir are set this way.
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/"
		-DINSTALL_QMLDIR="usr/$(get_libdir)/qt6/qml"
		-DM3SHAPES_BUILD_EXAMPLES=$(usex examples)
	)

	cmake_src_configure
}