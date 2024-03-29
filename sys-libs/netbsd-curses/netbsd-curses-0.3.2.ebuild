# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal

DESCRIPTION="netbsd-libcurses portable edition"
HOMEPAGE="https://github.com/sabotage-linux/netbsd-curses"
SRC_URI="http://ftp.barfooze.de/pub/sabotage/tarballs/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
IUSE="+doc static-libs"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"

BDEPEND="app-alternatives/awk"
RDEPEND="sys-libs/ncurses:0/1"

src_prepare() {
	default

	multilib_copy_sources
	tc-export CC
}

multilib_src_compile() {
	emake PREFIX="${EPREFIX}/usr"

	./tic/tic -ax -o terminfo.cdb terminfo/terminfo || die
}

multilib_src_install() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" DESTDIR="${D}" \
		$(usex static-libs install-libs install-dynlibs) \
		$(usex doc install-manpages "") \
		install-headers install-progs install-pcs

	insinto /usr/share
	doins terminfo.cdb

	dodoc README.md

	# fix file collisions with attr
	if use doc; then
		rm "${ED%/}/usr/share/man/man3/attr_get.3" || die
		rm "${ED%/}/usr/share/man/man3/attr_set.3" || die
	fi
}
