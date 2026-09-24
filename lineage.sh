#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf vendor/gms
rm -rf device/realme
rm -rf kernel/realme
rm -rf vendor/realme/RM6785
rm -rf device/mediatek/sepolicy_vndr
rm -rf hardware/mediatek
rm -rf vendor/oppo/camera/

# Local TimeZone
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Dhaka /etc/localtime

# repo init rom
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-23.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone  https://github.com/akram-arc/local_manifests.git .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# Media Patches (frameworks/av)
echo ">>> Cherry picking Media patches..."
cd frameworks/av
git remote add akram-arc https://github.com/akram-arc/android_frameworks_av.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick e1324be91d82c47cd632dc0cbeaeedcfcbd11c80 1d6ac760928140d361c23b2ca2862622d9ab9e78 c8db8c1671ee9bf4f8409a5c7c565acb47dfd053 3748303946dee31bf0d3e8dfb3bc2085cb533c21
cd ../..

# Updater Patch
echo ">>> Cherry picking Updater patch..."
cd packages/apps/Updater
git remote add akram-arc https://github.com/akram-arc/android_packages_apps_Updater.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 73119d3ce53b620ce681cd089cb55a8353caaaf8
cd ../../..

# CTS patches
echo ">>> Cherry picking CTS patches..."
cd vendor/lineage
git remote add akram-arc https://github.com/akram-arc/android_vendor_lineage.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 39a3e37c772f9e3803da67625fb818494ce50d43
cd ../..

# Settings Patch
echo ">>> Cherry picking Settings patch..."
cd packages/apps/Settings/
git remote add akram-arc https://github.com/akram-arc/android_packages_apps_Settings.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 6b0b97da38e8acec8c6095710ac3f255068898c9 2cc89a375d586b0a602aafcc8f82a081ad8f91fe 0bfc9b61a34498628cc3239442a55914ccfdd668 9a689c28fef5fde050964ae9da346486ce7bb95e 52b42d8948d7ef4a754f50ac306139b9671d84b7 5af4f936f903c6c6614ec77d6faef46edc513f34 0da7adb17eb71a0302f3af488423c98e56201d58 0ee96ed07f000c913aef579d374c0870ddc7c7a2
cd ../../..

# Launcher Patch
echo ">>> Cherry picking Settings patch..."
cd packages/apps/Launcher3
git remote add akram-arc https://github.com/akram-arc/android_packages_apps_Launcher3.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick a83ee9ce71c49e860c90c7cd17accc3834811e9e a7412e9affdc139b9fd3ae1e2b6577cd7d335540 a3a822f46db4354aabba0292bcc355145c28319d
cd ../../..

# Locked lk patches
echo ">>> Cherry picking Locked lk patches..."
cd system/core
git remote add akram-arc https://github.com/akram-arc/android_system_core.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 4d55070a72e649c5d0615b84dc10183463f926a8 d72b2f13cc8906c3de6e22055de7ad8c05410ac3 52bcc2864705ea77f0eb6a6a41756d26943465cd
cd ../..

# Base patches
echo ">>> Cherry picking base patches..."
cd frameworks/base
git remote add akram-arc https://github.com/akram-arc/android_frameworks_base.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 73fa97a3518017125f126fc67040812323bfa335 792a043e670c731cea03ed1696e6149a81749b11 3f9b219c6fead188c45b80d2e383df38efb4d7fa 8c081f5968186363c3ab58023f702469dcbc8d77 447f0a62546c3f22fe8e8eb1d1e55b6ee08d9ac5 6965945a5a6ef507d3cadfb6bab2bfff11ad8395 f43a152f9f55a3e43558cb36a8e776fa652cbe73 f5f0d84eff618653249f82e8b0a3fdd76b38a90b de27dd28c5eef3157240633e8f68695382f5df2a 5662c466f039614b5beea543a50640976a096309 9dfbbc4f24a14e717673b6475b337e7563b37c9a 1b4dc39a1022b342fd47a7ca7efc11ccef4ddbb3 da1642684cf38e10224b2ecc7a37bde88e16ef55 e99759e5ac9073ed7a4b48284faf3471810876bf 3dc49bf6a0c267876d523687fab3c8a17951c5a0 11826d46ef5b65e2abe2247f80e0752c5388f550 a75a1b8e5e6fcfa4c647bc3baa422f832da0e25a 9aa6d8bf3f61731785f1d4cb42d61a229f74f010 3eb4bd01c206492c6ff08b8bd804602a14e54bcd 03b948ea313a412ffd35b2a549debc072b3c0422 f9736645d62d17b6f3fc0b9cb30944fc4a2455d2 6a0e144a0ef9781a1fa3eb674720342f66c17463 c11a994d85dc92cb2e8592df22d6b00613d010ec
cd ../..

# sdk patches
echo ">>> Cherry picking sdk patches..."
cd lineage-sdk
git remote add akram-arc https://github.com/akram-arc/android_lineage-sdk.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 56816dc1cf7a70e3e3d24bc0ca1df1eb0a13c03c 71b01f0fa9c3b412f22804d9942f53e9a80a40d8 c74fbcfb06c74910e3a767ce91c9bf300cf695fc 9145b247e9b0050375d961468ce433d697c3d550 fe58f079419a4c00677c4fc64debb0316b1c2036
cd ..

# LineageParts patches
echo ">>> Cherry picking LineageParts patches..."
cd packages/apps/LineageParts
git remote add akram-arc https://github.com/akram-arc/android_packages_apps_LineageParts.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 9f5d2711d47b250cb8ad6d3a37a33ae5b6c89559 ec1037618a79f40ef0df12e4775b1e996edcfd40 c86a2cc41b27b9011b637d3cdf72576012b133f9 ac02cb664d8caab991748822cdef6999d0f444bc
cd ../../..

# Soong patches
echo ">>> Cherry picking Soong patches..."
cd build/soong
git remote add akram-arc https://github.com/akram-arc/android_build_soong.git 2>/dev/null || true
git fetch akram-arc
git cherry-pick 8aabb97294d0caf99ec90b3677c4b81580faddf4
cd ../..


# Export
export BUILD_USERNAME=Akram 
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"


# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
breakfast RM6785

# Make cleaninstall
make installclean
echo "============="

# Build
brunch RM6785

