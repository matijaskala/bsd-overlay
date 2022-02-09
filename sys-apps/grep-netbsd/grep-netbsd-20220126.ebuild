# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="NetBSD regular expression matcher"
HOMEPAGE="https://www.netbsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/b794ff62368d480cbba95ca526082e65fe6fd44e.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="elibc_musl"
RESTRICT="mirror"

COMMON_DEPEND="elibc_musl? ( sys-libs/fts-standalone )"
DEPEND="${COMMON_DEPEND}
	dev-libs/libbsd"
RDEPEND="${COMMON_DEPEND}
	!sys-apps/grep
	!sys-freebsd/freebsd-ubin"

src_prepare() {
	default

	tc-export CC
	sed -i "/LDLIBS/s@..shell.*\$@$(usex elibc_musl -lfts '')@" Makefile || die
}
