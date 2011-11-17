#!/bin/bash - 
#=========================================================
#          FILE:  kernel_clean4tags.sh
#   DESCRIPTION:  
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#      REVISION:  ---
#         EMAIL: armx86@gmail.com
#       CREATED: 17.11.2011
#     COPYRIGHT: Copyright (c) 2011, Yang Zhang
#=========================================================

mv arch/x86 ./
rm -rf arch/
mkdir arch
mv x86 arch
rm -rf block crypto firmware samples sound virt
cd drivers
rm -rf accessibility  clocksource  leds       media     mtd       parisc    power      s390  spi        thermal  video     zorro
rm -rf block      connector    gpu    ieee802154  memstick  parport   pps        sbus  ssb        tty      virtio
rm -rf amba           bluetooth  edac      hid    infiniband  macintosh  message   nfc       ps3        scsi  staging    vlynq
rm -rf ata            cdrom      eisa      hwmon  input       Makefile   mfd       nubus     pcmcia    rapidio    sfi   target     usb      w1
rm -rf atm            char       crypto       firewire  i2c    isdn        mca        misc      of        regulator  sh    tc         uwb      watchdog
rm -rf auxdisplay     clk        firmware  ide    Kconfig     md         mmc       pnp       rtc        sn    telephony  vhost    xen

cd net
rm -rf 3c501.c       atp.c            davinci_mdio.c  fec_mpc52xx_phy.c  Kconfig                       ps3_gelic_wireless.h  smc91x.c              tg3.h
rm -rf 3c501.h       atp.h            de600.c         forcedeth.c        korina.c         ne2.c                 pxa168_eth.c          smc91x.h              tile
rm -rf 3c503.c       au1000_eth.c     de600.h         fs_enet            ks8842.c         ne2k-pci.c            qla3xxx.c             smc-mca.c           
rm -rf 3c503.h       au1000_eth.h     de620.c         fsl_pq_mdio.c      ks8851.c         ne3210.c              qla3xxx.h             smc-ultra32.c      
rm -rf 3c505.c       ax88796.c        de620.h         fsl_pq_mdio.h      ks8851.h         ne.c                  qlcnic                smc-ultra.c           tokenring
rm -rf 3c505.h       b44.c            declance.c      gianfar.c          ks8851_mll.c     ne-h8300.c            qlge                  smsc911x.c            tsi108_eth.c
rm -rf 3c507.c       b44.h            defxx.c         gianfar_ethtool.c  ksz884x.c                  r6040.c               smsc911x.h            tsi108_eth.h
rm -rf 3c509.c       bcm63xx_enet.c   defxx.h         gianfar.h          lance.c          netxen                r8169.c               smsc9420.c            tulip
rm -rf 3c515.c       bcm63xx_enet.h   depca.c         gianfar_sysfs.c    lasi_82596.c                 rionet.c              smsc9420.h            
rm -rf 3c523.c       benet            depca.h         greth.c            lib82596.c       ni5010.c              rrunner.c             sni_82596.c           typhoon.c
rm -rf 3c523.h       bfin_mac.c       dl2k.c          greth.h            lib8390.c        ni5010.h              rrunner.h             sonic.c               typhoon.h
rm -rf 3c527.c       bfin_mac.h       dl2k.h          hamachi.c          LICENSE.SRC      ni52.c                s2io.c                sonic.h               ucc_geth.c
rm -rf 3c527.h       bmac.c           dm9000.c        hamradio           ll_temac.h       ni52.h                s2io.h                Space.c               ucc_geth_ethtool.c
rm -rf 3c59x.c       bmac.h           dm9000.h        hp100.c            ll_temac_main.c  ni65.c                s2io-regs.h           spider_net.c          ucc_geth.h
rm -rf 7990.c        bna              dnet.c          hp100.h            ll_temac_mdio.c  ni65.h                s6gmac.c              spider_net_ethtool.c  usb
rm -rf 7990.h        bnx2.c           dnet.h          hp.c               lne390.c         niu.c                 sb1000.c              spider_net.h         
rm -rf 8139cp.c      bnx2_fw.h        dummy.c         hplance.c                niu.h                 sb1250-mac.c          starfire.c            via-rhine.c
rm -rf 8139too.c     bnx2.h                      hplance.h          lp486e.c         ns83820.c             sc92031.c             stmmac                via-velocity.c
rm -rf        bnx2x                      hp-plus.c          mac8390.c        octeon                seeq8005.c            stnic.c               via-velocity.h
rm -rf 8390.c                            hydra.c            mac89x0.c        pasemi_mac.c          seeq8005.h            sun3_82586.c          virtio_net.c
rm -rf 8390.h        bsd_comp.c       e2100.c         ibmlana.c          macb.c           pasemi_mac_ethtool.c  sfc                   sun3_82586.h          vmxnet3
rm -rf 8390p.c       caif             eepro.c         ibmlana.h          macb.h           pasemi_mac.h          sgiseeq.c             sun3lance.c           vxge
rm -rf a2065.c       can              eexpress.c      ibm_newemac        mace.c           pch_gbe               sgiseeq.h             sunbmac.c             
rm -rf a2065.h       cassini.c        eexpress.h      ibmveth.c          mace.h           pci-skeleton.c        sh_eth.c              sunbmac.h             wd.c
rm -rf ac3200.c      cassini.h        ehea            ibmveth.h          macmace.c        pcmcia                sh_eth.h              sundance.c            wimax
rm -rf acenic.c      chelsio          enc28j60.c      ifb.c              macsonic.c       pcnet32.c             sis190.c              sungem.c              wireless
rm -rf acenic.h      cnic.c           enc28j60_hw.h                                              sis900.c              sungem.h              xen-netfront.c
rm -rf amd8111e.c    cnic_defs.h      enic                          macvtap.c        plip.c                sis900.h              sungem_phy.c          xilinx_emaclite.c
rm -rf amd8111e.h    cnic.h           epic100.c       ioc3-eth.c         Makefile                    skfp                  sungem_phy.h          xtsonic.c
rm -rf apne.c        cnic_if.h        eql.c           ipg.c              mdio.c                    skge.c                sunhme.c              yellowfin.c
rm -rf appletalk     cpmac.c          es3210.c        ipg.h              meth.c                    skge.h                sunhme.h              znet.c
rm -rf arcnet        cris             eth16i.c        irda               meth.h                       sky2.c                sunlance.c            zorro8390.c
rm -rf ariadne.c     cs89x0.c         ethoc.c         iseries_veth.c     mii.c                        sky2.h                sunqe.c
rm -rf ariadne.h     cs89x0.h         ewrk3.c                        mipsnet.c                       slhc.c                sunqe.h
rm -rf arm           cxgb3            ewrk3.h                       mlx4                            slip.c                sunvnet.c
rm -rf at1700.c      cxgb4            fealnx.c                    mv643xx_eth.c             slip.h                sunvnet.h
rm -rf atarilance.c  cxgb4vf          fec.c           ixp2000            mvme147.c                        smc911x.c             tc35815.c
rm -rf atl1c         davinci_cpdma.c  fec.h           jazzsonic.c        myri10ge         ps3_gelic_net.c       smc911x.h             tehuti.c
rm -rf atl1e         davinci_cpdma.h  fec_mpc52xx.c   jme.c              myri_sbus.c      ps3_gelic_net.h       smc9194.c             tehuti.h
rm -rf atlx          davinci_emac.c   fec_mpc52xx.h   jme.h              myri_sbus.h      ps3_gelic_wireless.c  smc9194.h             tg3.c     wan

cd ../../net    
rm -rf atm         compat.c  decnet        ipx      key   mac80211   phonet  rxrpc     sunrpc        x25
rm -rf ax25        caif    dns_resolver  ieee802154  irda     l2tp  Makefile   netrom   rds     xfrm
rm -rf 9p         batman-adv  can     dcb       dsa           iucv     lapb  nonet.c  rfkill  sctp      tipc          wimax
rm -rf appletalk  bluetooth   ceph    dccp      econet        Kconfig  llc   rose      TUNABLE       wireles

cd ../
echo "generating tags"
ctags -R
echo "generating cscope files"
cscope -Rbkq
