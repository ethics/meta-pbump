FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://udhcpc_without_ntp \
        file://udhcpc_with_ntp \
        "

PACKAGES =. "${PN}"

INSANE_SKIP_${PN} = "installed-vs-shipped" 

INSANE_SKIP_${PN} += "already-stripped" 

INSANE_SKIP_${PN} += "dev-so"

SYSTEMD_SERVICE_${PN} = "ntpd"

FILES_${PN} += "${sysconfdir}/init.d/ntpd \
                ${base_sbindir}/ntpq \
                ${base_sbindir}/ntpdc \
                ${base_sbindir}/ntpdate \
                ${sysconfdir}/udhcpc.d/udhcpc_without_ntp \
                ${sysconfdir}/udhcpc.d/udhcpc_with_ntp"

do_install_append() {
    echo "Copying NTP related files..."
    install -d ${D}${sysconfdir}
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${sysconfdir}/udhcpc.d
    install -d ${D}${base_sbindir}
    cp -f ${WORKDIR}/ntpd ${D}${sysconfdir}/init.d/ntpd
    cp -f ${WORKDIR}/udhcpc_without_ntp ${D}${sysconfdir}/udhcpc.d/udhcpc_without_ntp
    cp -f ${WORKDIR}/udhcpc_with_ntp ${D}${sysconfdir}/udhcpc.d/udhcpc_with_ntp
    cp -f ${WORKDIR}/ntpd ${D}${sysconfdir}/init.d/ntpd
    cp -f ${WORKDIR}/build/ntpq/ntpq ${D}${base_sbindir}
    cp -f ${WORKDIR}/build/ntpdc/ntpdc ${D}${base_sbindir}
    cp -f ${WORKDIR}/build/ntpdate/ntpdate ${D}${base_sbindir}
}

