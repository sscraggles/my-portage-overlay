# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qt5-build

DESCRIPTION="Serial bus abstraction library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~hppa ~ppc64 ~x86"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}
	virtual/libudev:=
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/qtserialbus-opensource-src-5.7.1

src_prepare() {
	# make sure we link against libudev
#	sed -i -e 's/:contains(QT_CONFIG,\s*libudev)//' \
#		src/serialbus/serialbus-lib.pri || die

	qt5-build_src_prepare
}
