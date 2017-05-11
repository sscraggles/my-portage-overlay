# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="MegaTunix is a tuning application. It supports some of the available DIY EFI Fuel injection solutions including many MegaSquirt products and LibreEMS."
HOMEPAGE="https://github.com/djandruczyk/MegaTunix"
EGIT_REPO_URI="https://github.com/djandruczyk/MegaTunix.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples doc"

REQUIRED_USE=""

DEPEND="
	x11-libs/gtk+:2
	x11-libs/pango
	media-libs/fontconfig
	media-libs/freetype
	dev-libs/glib
	dev-libs/atk
	x11-libs/gtkglext
	gnome-base/libglade
	dev-libs/libxml2
	x11-libs/gtkglarea
"

RDEPEND="${DEPEND}"

#S=${WORKDIR}/wefwewerwer

maint_pkg_create() {
    cd "${S}"
    local ver=$(date --date="$(git log -n1 --pretty=format:%ci HEAD)" -u "+%Y.%m.%d.%H%M%S")
    local tar="${T}/${PN}-${ver}.tar.xz"
    git archive --prefix "${PN}/" HEAD | xz > "${tar}" || die "creating tar failed"
    einfo "Packaged tar now available:"
    einfo "$(du -b "${tar}")"
}

src_configure() {
    ./autogen.sh
    ./configure --prefix=/usr
}
