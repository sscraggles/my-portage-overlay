# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="SocketCAN userspace utilities and tools: asc2log, bcmserver, canbusload, can-calc-bit-timing, candump, canfdtest, cangen, cangw, canlogserver, canplayer, cansend, cansniffer, isotpdump, isotprecv, isotpperf, isotpsend, isotpserver, isotpsniffer, isotptun, log2asc, log2long, slcan_attach, slcand and slcanpty "
HOMEPAGE="https://github.com/linux-can/can-utils"
EGIT_REPO_URI="https://github.com/linux-can/can-utils.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-devel/autoconf
	sys-devel/libtool"

RDEPEND="${DEPEND}"

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


