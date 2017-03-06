# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qt4-r2 cmake-utils git-r3

DESCRIPTION="A Qt4 interface to the museekd daemon."
HOMEPAGE="http://www.museek-plus.org/"
EGIT_REPO_URI="git://github.com/eLvErDe/museek-plus.git"
#EGIT_REPO_URI="https://github.com/hallsofmirrors/museek-plus.git"
#EGIT_REPO_URI="https://github.com/alcoheca/museek-plus.git"

GIT_ECLASS="git-r3"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtscript:4
	dev-qt/qtgui:4
	dev-qt/qtcore:4
	dev-qt/designer:4
	dev-libs/libxml2
	dev-cpp/libxmlpp:2.6
	<=dev-libs/libevent-2.0.22:0/0
"

DEPEND="${RDEPEND}"


#S="${WORKDIR}/${PN}"
#S="${WORKDIR}/museek-plus"

DOCS=( README COPYING LICENSE TODO )

PATCHES=(
	"${FILESDIR}"/${PN}-hallsofmirrors.patch
	"${FILESDIR}"/${PN}-flv0.patch
)

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_MANDIR=/usr/share/man 
        -DMUCOUS=0 -DNO_MUSEEKD=1 -DNO_MUSCAN=1 -DNO_SETUP=1 -DNO_PYMUCIPHER=1 
        -DPREFIX=/usr -Wno-dev
	)
#	mycmakeargs=(
#		-DMUSEEKD=0 -DMUSETUP=0 -DMUSCAN=0 -DMUCOUS=0 -DMURMUR=0
#		-DPYMUCIPHER=0 -DPYTHON_BINDINGS=0 -DPYTHON_CLIENTS=0
#		-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_MANDIR=/usr/share/man 
#        -DPREFIX=/usr -Wno-dev
#	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

