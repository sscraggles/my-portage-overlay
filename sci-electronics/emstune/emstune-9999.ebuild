# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 qmake-utils

DESCRIPTION="EMSTune is the tuning application for the EMStudio suite.  It is compatible with LibreEMS out of the box, with plugins for Megasquirt and DynamicEFI/GMECU."
HOMEPAGE="https://github.com/malcom2073/emstune"
EGIT_REPO_URI="https://github.com/malcom2073/emstune.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples doc"

REQUIRED_USE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtserialport:5
	dev-qt/qtwebkit:5
	dev-qt/qtsvg:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	app-accessibility/flite
	dev-libs/openssl
	virtual/libudev
	dev-qt/qtquickcontrols
	>=media-libs/freeglut-3.0
"

RDEPEND="${DEPEND}"

#S=${WORKDIR}/wefwewerwer

maint_pkg_create() {
    cd "${S}"
    local ver=$(date --date="$(git log -n1 --pretty=format:%ci HEAD )" -u "+%Y.%m.%d.%H%M%S")
    local tar="${T}/${PN}-${ver}.tar.xz"
    git archive --prefix "${PN}/" HEAD  -b unstable| xz > "${tar}" || die "creating tar failed"
    einfo "Packaged tar now available:"
    einfo "$(du -b "${tar}")"
}

src_configure() {
	#QT_SELECT=5 qmake -recursive
	#sed -i -e "s|usr/local|usr|g" core/Makefile || die
	#sed -i -e "s|usr/local|usr|g" core/core.pro || die
	#eqmake5 PREFIX=/usr -recursive
	sed -i -e "s|usr/local|usr|g" -e "s|declarative||g" core/core.pro || die
	eqmake5 -recursive
}

src_compile() {
	default
}

src_install() {
	default
}
