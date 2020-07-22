# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit portability

DESCRIPTION="BSD licensed ELF toolchain"
HOMEPAGE="https://elftoolchain.sourceforge.net"
SRC_URI="mirror://sourceforge/elftoolchain/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!dev-libs/elfutils
	!dev-libs/libelf"
BDEPEND="sys-apps/groff
	sys-apps/lsb-release
	virtual/pmake"

src_compile() {
	$(get_bmake) -C common || die
	$(get_bmake) -C libelf || die
}

src_install() {
	$(get_bmake) -C common DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die
	$(get_bmake) -C libelf DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die
}
