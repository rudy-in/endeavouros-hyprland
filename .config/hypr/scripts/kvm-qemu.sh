#!/bin/sh

# Check virtualization environment
case "$(systemd-detect-virt)" in
  kvm | qemu)
    export WLR_RENDERER_ALLOW_SOFTWARE=1
    export XCURSOR_SIZE=24
    export QT_QPA_PLATFORM,wayland
    export WLR_NO_HARDWARE_CURSORS, 1
    export QT_QPA_PLATFORM,wayland
    ;;
esac
