VERSION=0.1
BUILD=1
TARGET=sbin/leech
MATCH_TEST_TARGET=sbin/leech-match-test
XSL=share/leech/leech.xsl
CONFIG_FILES=config/default config/foods config/downloads
BUILD_DIR=pkg_build
IPK_TARGET=leech_${VERSION}-${BUILD}_all.ipk
DEB_TARGET=leech_${VERSION}-${BUILD}_all.deb

default: executable ipk deb

executable:
	chmod +x "${TARGET}"

clean:
	rm -fr "${BUILD_DIR}"
	rm -f "${IPK_TARGET}"
	rm -f "${DEB_TARGET}"

deb:
	mkdir -p "${BUILD_DIR}"
	
	# control
	mkdir -p "${BUILD_DIR}/DEBIAN"
	cp build/deb/control build/deb/conffiles "${BUILD_DIR}/DEBIAN/"
	
	# data
	mkdir -p "${BUILD_DIR}/etc/leech"
	mkdir -p "${BUILD_DIR}/usr/sbin"
	mkdir -p "${BUILD_DIR}/usr/share/leech"
	
	cp ${CONFIG_FILES} "${BUILD_DIR}/etc/leech/"
	cp "${TARGET}" "${MATCH_TEST_TARGET}" "${BUILD_DIR}/usr/sbin/"
	cp "${XSL}" "${BUILD_DIR}/usr/share/leech/"
	chmod +x "${BUILD_DIR}/usr/${TARGET}"
	chmod +x "${BUILD_DIR}/usr/${MATCH_TEST_TARGET}"
	
	# deb
	fakeroot dpkg -b "${BUILD_DIR}" "${DEB_TARGET}"
	
	# cleanup
	rm -fr "${BUILD_DIR}"

ipk:
	mkdir -p "${BUILD_DIR}"
	echo "2.0" > "${BUILD_DIR}/debian-binary"
	
	# control.tar.gz
	mkdir -p "${BUILD_DIR}/IPKG"
	cp build/ipkg/control build/ipkg/conffiles "${BUILD_DIR}/IPKG/"
	fakeroot tar zcvf "${BUILD_DIR}/control.tar.gz" -C "${BUILD_DIR}/IPKG" control conffiles
	
	# data.tar.gz
	mkdir -p "${BUILD_DIR}/usr/sbin" "${BUILD_DIR}/usr/share/leech" "${BUILD_DIR}/etc/leech"
	cp ${CONFIG_FILES} "${BUILD_DIR}/etc/leech/"
	cp "${TARGET}" "${MATCH_TEST_TARGET}" "${BUILD_DIR}/usr/sbin/"
	cp "${XSL}" "${BUILD_DIR}/usr/share/leech/"
	chmod +x "${BUILD_DIR}/usr/${TARGET}"
	chmod +x "${BUILD_DIR}/usr/${MATCH_TEST_TARGET}"
	fakeroot tar zcvf "${BUILD_DIR}/data.tar.gz" -C "${BUILD_DIR}" usr/ etc/
	
	# leech.ipk
	fakeroot tar zcvf "${IPK_TARGET}" -C "${BUILD_DIR}" debian-binary control.tar.gz data.tar.gz
	
	# cleanup
	rm -fr "${BUILD_DIR}"
