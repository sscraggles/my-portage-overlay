# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="Webcamoid is a full featured webcam capture application."
HOMEPAGE="https://webcamoid.github.io/"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
RDEPEND="
	dev-qt/qtsvg:5
	media-sound/pulseaudio
	media-tv/v4l-utils
	media-video/ffmpeg
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtmultimedia:5
"

DEPEND="${RDEPEND}"


DOCS=( THANKS TODO README.md ChangeLog COPYING AUTHORS )

src_configure() {
    #eqmake5 PREFIX="${D}"/usr Webcamoid.pro
    eqmake5 Webcamoid.pro
}

src_install() {
    emake INSTALL_ROOT="${D}" install
}
