# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="NetBSD macro processor"
HOMEPAGE="https://www.netbsd.org"
COMMIT_ID="8128e820d30c6d966bf3424f58f81f651bc31a09"
SRC_URI="https://github.com/matijaskala/${PN}/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

BDEPEND="dev-util/byacc
	sys-devel/flex"
DEPEND="dev-libs/libbsd"
RDEPEND="${DEPEND}
	userland_GNU? ( !sys-devel/m4 )
	!sys-freebsd/freebsd-ubin"

S=${WORKDIR}/${PN}-${COMMIT_ID}

src_prepare() {
	default

	tc-export CC
}
