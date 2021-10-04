# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="Standard BSD utilities"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://github.com/matijaskala/${PN}/archive/f203729ebf69bcc253d6061b1ead2065ecc4961e.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/libbsd"
RDEPEND="${DEPEND}
	!sys-apps/coreutils
	!sys-apps/net-tools[hostname]
	!sys-apps/util-linux[kill]
	!sys-apps/which
	!sys-process/procps[kill]"

src_prepare() {
	default

	tc-export CC
	use elibc_musl && export LDLIBS+=" -lfts"
}

src_install() {
	default

	rm -f "${D}"/usr/bin/groups || die
	rm -f "${D}"/usr/share/man/man1/groups.1 || die
}
