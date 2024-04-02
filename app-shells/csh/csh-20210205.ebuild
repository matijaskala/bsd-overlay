# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Classic UNIX shell with C like syntax"
HOMEPAGE="https://www.netbsd.org"
COMMIT_ID="90e966381e6cd0f434ef24a799dbf181cded55cf"
SRC_URI="https://github.com/matijaskala/csh/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

src_install() {
	into /
	dobin csh

	doman csh.1
}
