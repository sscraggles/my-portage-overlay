# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="X login service for systemd"
HOMEPAGE="https://github.com/joukewitteveen/xlogin"
EGIT_REPO_URI="git://github.com/joukewitteveen/xlogin.git"
inherit git-r3

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/systemd
	x11-apps/xinit
	sys-apps/systemd
	app-shells/bash"

RDEPEND="${DEPEND}"

DOCS=( LICENSE README )

maint_pkg_create() {
    cd "${S}"
    local ver=$(date --date="$(git log -n1 --pretty=format:%ci HEAD)" -u "+%Y.%m.%d.%H%M%S")
    local tar="${T}/${PN}-${ver}.tar.xz"
    git archive --prefix "${PN}/" HEAD | xz > "${tar}" || die "creating tar failed"
    einfo "Packaged tar now available:"
    einfo "$(du -b "${tar}")"
}

PATCHES=(
    "${FILESDIR}"/${PN}-plymouth.patch
)

src_prepare() {
	mv Makefile Makefile.old
#	sed -i -e "s:/usr/bin/bash:/bin/bash:g" Makefile || die
	default
}

#src_compile() {
#    echo " "
#}

src_install() {
	#mv Makefile Makefile.old
	install -Dm=755 <(sed -e "s|@bash@|/bin/bash|g" x-daemon.in) ${D}/usr/bin/x-daemon ||die
	install -Dm=644 x@.service ${D}/usr/lib/systemd/system/x@.service ||die
	install -Dm644 <(sed -e "s|@bash@|/bin/bash|g" xlogin@.service.in) ${D}/usr/lib/systemd/system/xlogin@.service ||die
	install -Dm755 <(sed -e "s|@bash@|/bin/bash|g" 25-xlogin.sh.in) ${D}/etc/X11/xinit/xinitrc.d/25-xlogin.sh ||die

	#emake DESTDIR="${D}" install
#	#emake prefix=/usr DESTDIR="${D}" install
#	default
	dodoc LICENSE README
}

pkg_postinst() {
	ewarn "to enable, now run"
	ewarn "$ systemctl enable xlogin@<username>"
	ewarn " "
	ewarn "See https://github.com/mjkillough/notes/blob/master/boot-experience.md#auto-login-to-x"
	#ewarn "See https://wiki.archlinux.org/index.php/Systemd/User#Automatic_login_into_Xorg_without_display_manager"
}
