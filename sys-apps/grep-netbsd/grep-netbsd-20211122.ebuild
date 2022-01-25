# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="NetBSD regular expression matcher"
HOMEPAGE="https://www.netbsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/15cfbe98d358ddc3a2019579fb05b100b8ee217b.tar.gz -> ${P}.tar.gz"

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
	use elibc_musl && export LDLIBS+=" -lfts"
}
