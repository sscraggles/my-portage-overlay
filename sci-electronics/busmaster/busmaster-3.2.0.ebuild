# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#PYTHON_COMPAT=( python{2_7,3_4,3_5} )

#inherit eutils qmake-utils distutils-r1
inherit eutils qmake-utils

DESCRIPTION="BUSMASTER is an Open Source Software tool to simulate, analyze and test data bus systems such as CAN."
HOMEPAGE="https://github.com/rbei-etas/busmaster"
SRC_URI="https://github.com/rbei-etas/busmaster/archive/v3.2.0.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="examples doc +qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

DEPEND="
	sys-devel/bison
	sys-devel/flex
	dev-libs/libxml2
	sys-devel/gettext
"

RDEPEND="${DEPEND}"

S=${WORKDIR}/SavvyCAN-161-Beta

src_prepare() {
	default
    # Modify install path
	sed -e "s|FULLPATH/icon/SavvyIcon.png|savvycan-icon|g" \
	    -e "s|FULLPATH/SavvyCAN|/usr/bin/savvycan|g" SavvyCAN.desktop > savvycan.desktop || die "sed failed to modify install path for savvycan.desktop"
}


src_configure() {
    eqmake5
}

#python_compile_all() {
src_compile() {
	default
    use doc && emake -C docs html
}

src_install() {
	#default
	install -Dm=755 SavvyCAN ${D}/usr/bin/savvycan || die
	install -Dm=755 SavvyCAN.desktop ${D}/usr/share/applications/savvycan.desktop || die

    insinto /usr/share/applications
    doins "savvycan.desktop"
    newicon icon/SavvyIcon.png "savvycan-icon.png"

    #use doc && HTML_DOCS=( docs/build/html/. )
	use doc && dohtml -r docs/build/html/.
	if use examples; then
		#dodoc -r examples/.
		mkdir -p ${D}/usr/share/doc/${P}/examples
		install -Dm=755 examples/* ${D}/usr/share/doc/${P}/examples/
	fi
}

