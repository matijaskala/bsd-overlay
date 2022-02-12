# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="A stream editor from NetBSD"
HOMEPAGE="https://www.netbsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/41d4f5334703f522cbf4684b1c5abd7e6f7f2a64.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="userland_GNU"
RESTRICT="mirror"

DEPEND="dev-libs/libbsd"
RDEPEND="${DEPEND}
	!sys-apps/sed-netbsd
	!sys-apps/sed"

src_prepare() {
	default

	tc-export CC
}
