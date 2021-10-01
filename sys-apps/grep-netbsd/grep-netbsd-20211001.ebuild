# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs vcs-snapshot

DESCRIPTION="NetBSD regular expression matcher"
HOMEPAGE="https://www.netbsd.org"
SRC_URI="https://github.com/matijaskala/${PN}/archive/7639e023f8db97edd3a12486ace736731d9933db.tar.gz -> ${P}.tar.gz"

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
