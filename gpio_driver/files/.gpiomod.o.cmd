cmd_/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o := aarch64-rpi-linux-gcc -Wp,-MMD,/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/.gpiomod.o.d -nostdinc -isystem /home/abdo/yocto/poky/nti_build/tmp/deploy/sdk/abozaid/sysroots/x86_64-pokysdk-linux/usr/lib/aarch64-rpi-linux/gcc/aarch64-rpi-linux/11.5.0/include -I/home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include -I./arch/arm64/include/generated -I/home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include -I./include -I/home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi -I/home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi -I./include/generated/uapi -include /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler-version.h -include /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kconfig.h -include /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler_types.h -D__KERNEL__ -mlittle-endian -DCC_USING_PATCHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT= -fmacro-prefix-map=/home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/= -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Wno-format-security -std=gnu89 -mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=1 -Wno-psabi -mabi=lp64 -fno-asynchronous-unwind-tables -fno-unwind-tables -mbranch-protection=pac-ret+leaf -Wa,-march=armv8.5-a -DARM64_ASM_ARCH='"armv8.5-a"' -DKASAN_SHADOW_SCALE_SHIFT= -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-address-of-packed-member -O2 -fno-allow-store-data-races -Wframe-larger-than=2048 -fstack-protector-strong -Wimplicit-fallthrough=5 -Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-stack-clash-protection -fpatchable-function-entry=2 -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -Wno-stringop-truncation -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized -Wno-alloc-size-larger-than -fno-strict-overflow -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wno-packed-not-aligned --sysroot=/home/abdo/yocto/poky/nti_build/tmp/deploy/sdk/abozaid/sysroots/cortexa53-rpi-linux -mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=1344  -DMODULE  -DKBUILD_BASENAME='"gpiomod"' -DKBUILD_MODNAME='"gpiomod"' -D__KBUILD_MODNAME=kmod_gpiomod -c -o /home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o /home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.c

source_/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o := /home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.c

deps_/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o := \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler_types.h \
    $(wildcard include/config/HAVE_ARCH_COMPILER_H) \
    $(wildcard include/config/CC_HAS_ASM_INLINE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler_attributes.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler-gcc.h \
    $(wildcard include/config/RETPOLINE) \
    $(wildcard include/config/ARCH_USE_BUILTIN_BSWAP) \
    $(wildcard include/config/KCOV) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/compiler.h \
    $(wildcard include/config/CFI_CLANG) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/module.h \
    $(wildcard include/config/MODULES) \
    $(wildcard include/config/SYSFS) \
    $(wildcard include/config/MODULES_TREE_LOOKUP) \
    $(wildcard include/config/LIVEPATCH) \
    $(wildcard include/config/STACKTRACE_BUILD_ID) \
    $(wildcard include/config/MODULE_SIG) \
    $(wildcard include/config/GENERIC_BUG) \
    $(wildcard include/config/KALLSYMS) \
    $(wildcard include/config/SMP) \
    $(wildcard include/config/TRACEPOINTS) \
    $(wildcard include/config/TREE_SRCU) \
    $(wildcard include/config/BPF_EVENTS) \
    $(wildcard include/config/DEBUG_INFO_BTF_MODULES) \
    $(wildcard include/config/JUMP_LABEL) \
    $(wildcard include/config/TRACING) \
    $(wildcard include/config/EVENT_TRACING) \
    $(wildcard include/config/FTRACE_MCOUNT_RECORD) \
    $(wildcard include/config/KPROBES) \
    $(wildcard include/config/HAVE_STATIC_CALL_INLINE) \
    $(wildcard include/config/PRINTK_INDEX) \
    $(wildcard include/config/MODULE_UNLOAD) \
    $(wildcard include/config/CONSTRUCTORS) \
    $(wildcard include/config/FUNCTION_ERROR_INJECTION) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/list.h \
    $(wildcard include/config/DEBUG_LIST) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/types.h \
    $(wildcard include/config/HAVE_UID16) \
    $(wildcard include/config/UID16) \
    $(wildcard include/config/ARCH_DMA_ADDR_T_64BIT) \
    $(wildcard include/config/PHYS_ADDR_T_64BIT) \
    $(wildcard include/config/64BIT) \
    $(wildcard include/config/ARCH_32BIT_USTAT_F_TINODE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/types.h \
  arch/arm64/include/generated/uapi/asm/types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/int-ll64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/int-ll64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/bitsperlong.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitsperlong.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/bitsperlong.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/posix_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/stddef.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/stddef.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/posix_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/posix_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/poison.h \
    $(wildcard include/config/ILLEGAL_POINTER_VALUE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/const.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/const.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/const.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kernel.h \
    $(wildcard include/config/PREEMPT_VOLUNTARY) \
    $(wildcard include/config/PREEMPT_DYNAMIC) \
    $(wildcard include/config/PREEMPT_) \
    $(wildcard include/config/DEBUG_ATOMIC_SLEEP) \
    $(wildcard include/config/MMU) \
    $(wildcard include/config/PROVE_LOCKING) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/stdarg.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/align.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/limits.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/limits.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/limits.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/linkage.h \
    $(wildcard include/config/ARCH_USE_SYM_ANNOTATIONS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/stringify.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/export.h \
    $(wildcard include/config/MODVERSIONS) \
    $(wildcard include/config/MODULE_REL_CRCS) \
    $(wildcard include/config/HAVE_ARCH_PREL32_RELOCATIONS) \
    $(wildcard include/config/TRIM_UNUSED_KSYMS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/compiler.h \
    $(wildcard include/config/TRACE_BRANCH_PROFILING) \
    $(wildcard include/config/PROFILE_ALL_BRANCHES) \
    $(wildcard include/config/STACK_VALIDATION) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/rwonce.h \
    $(wildcard include/config/LTO) \
    $(wildcard include/config/AS_HAS_LDAPR) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/rwonce.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kasan-checks.h \
    $(wildcard include/config/KASAN_GENERIC) \
    $(wildcard include/config/KASAN_SW_TAGS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kcsan-checks.h \
    $(wildcard include/config/KCSAN) \
    $(wildcard include/config/KCSAN_IGNORE_ATOMICS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/linkage.h \
    $(wildcard include/config/ARM64_BTI_KERNEL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bitops.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bits.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/bits.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/build_bug.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/typecheck.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/kernel.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/sysinfo.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/bitops.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/builtin-__ffs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/builtin-ffs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/builtin-__fls.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/builtin-fls.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/ffz.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/fls64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/find.h \
    $(wildcard include/config/GENERIC_FIND_FIRST_BIT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/sched.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/hweight.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/arch_hweight.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/const_hweight.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/atomic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/atomic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/atomic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/barrier.h \
    $(wildcard include/config/ARM64_PSEUDO_NMI) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/barrier.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/cmpxchg.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/lse.h \
    $(wildcard include/config/ARM64_LSE_ATOMICS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/atomic_ll_sc.h \
    $(wildcard include/config/CC_HAS_K_CONSTRAINT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/jump_label.h \
    $(wildcard include/config/HAVE_ARCH_JUMP_LABEL_RELATIVE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/jump_label.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/insn.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/insn-def.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/alternative.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/alternative-macros.h \
  arch/arm64/include/generated/asm/cpucaps.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/init.h \
    $(wildcard include/config/STRICT_KERNEL_RWX) \
    $(wildcard include/config/STRICT_MODULE_RWX) \
    $(wildcard include/config/LTO_CLANG) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/atomic_lse.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/atomic/atomic-arch-fallback.h \
    $(wildcard include/config/GENERIC_ATOMIC64) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/atomic/atomic-long.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/atomic/atomic-instrumented.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/instrumented.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/instrumented-atomic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/lock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/instrumented-lock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/non-atomic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/le.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/byteorder.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/byteorder/little_endian.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/byteorder/little_endian.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/swab.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/swab.h \
  arch/arm64/include/generated/uapi/asm/swab.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/swab.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/byteorder/generic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bitops/ext2-atomic-setbit.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kstrtox.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/log2.h \
    $(wildcard include/config/ARCH_HAS_ILOG2_U32) \
    $(wildcard include/config/ARCH_HAS_ILOG2_U64) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/math.h \
  arch/arm64/include/generated/asm/div64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/div64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/minmax.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/panic.h \
    $(wildcard include/config/PANIC_TIMEOUT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/printk.h \
    $(wildcard include/config/MESSAGE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_QUIET) \
    $(wildcard include/config/EARLY_PRINTK) \
    $(wildcard include/config/PRINTK) \
    $(wildcard include/config/DYNAMIC_DEBUG) \
    $(wildcard include/config/DYNAMIC_DEBUG_CORE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kern_levels.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/cache.h \
    $(wildcard include/config/ARCH_HAS_CACHE_LINE_SIZE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/cache.h \
    $(wildcard include/config/KASAN_HW_TAGS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/cputype.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/sysreg.h \
    $(wildcard include/config/BROKEN_GAS_INST) \
    $(wildcard include/config/ARM64_PA_BITS_52) \
    $(wildcard include/config/ARM64_4K_PAGES) \
    $(wildcard include/config/ARM64_16K_PAGES) \
    $(wildcard include/config/ARM64_64K_PAGES) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kasan-tags.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ratelimit_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/param.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/param.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/param.h \
    $(wildcard include/config/HZ) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/param.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/spinlock_types.h \
    $(wildcard include/config/PREEMPT_RT) \
    $(wildcard include/config/DEBUG_LOCK_ALLOC) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/spinlock_types_raw.h \
    $(wildcard include/config/DEBUG_SPINLOCK) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/spinlock_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/qspinlock_types.h \
    $(wildcard include/config/NR_CPUS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/qrwlock_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/lockdep_types.h \
    $(wildcard include/config/PROVE_RAW_LOCK_NESTING) \
    $(wildcard include/config/PREEMPT_LOCK) \
    $(wildcard include/config/LOCKDEP) \
    $(wildcard include/config/LOCK_STAT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rwlock_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/once_lite.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/static_call_types.h \
    $(wildcard include/config/HAVE_STATIC_CALL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/stat.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/stat.h \
    $(wildcard include/config/COMPAT) \
  arch/arm64/include/generated/uapi/asm/stat.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/stat.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/time.h \
    $(wildcard include/config/POSIX_TIMERS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/math64.h \
    $(wildcard include/config/ARCH_SUPPORTS_INT128) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/math64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/time64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/time64.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/time.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/time_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/time32.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/timex.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/timex.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/timex.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/arch_timer.h \
    $(wildcard include/config/ARM_ARCH_TIMER_OOL_WORKAROUND) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/hwcap.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/hwcap.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/cpufeature.h \
    $(wildcard include/config/ARM64_PAN) \
    $(wildcard include/config/ARM64_SW_TTBR0_PAN) \
    $(wildcard include/config/ARM64_SVE) \
    $(wildcard include/config/ARM64_CNP) \
    $(wildcard include/config/ARM64_PTR_AUTH) \
    $(wildcard include/config/ARM64_MTE) \
    $(wildcard include/config/ARM64_DEBUG_PRIORITY_MASKING) \
    $(wildcard include/config/ARM64_BTI) \
    $(wildcard include/config/ARM64_TLB_RANGE) \
    $(wildcard include/config/ARM64_PA_BITS) \
    $(wildcard include/config/ARM64_HW_AFDBM) \
    $(wildcard include/config/ARM64_AMU_EXTN) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bug.h \
    $(wildcard include/config/BUG_ON_DATA_CORRUPTION) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/bug.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/asm-bug.h \
    $(wildcard include/config/DEBUG_BUGVERBOSE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/brk-imm.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/bug.h \
    $(wildcard include/config/BUG) \
    $(wildcard include/config/GENERIC_BUG_RELATIVE_POINTERS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/instrumentation.h \
    $(wildcard include/config/DEBUG_ENTRY) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/smp.h \
    $(wildcard include/config/UP_LATE_INIT) \
    $(wildcard include/config/DEBUG_PREEMPT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/errno.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/errno.h \
  arch/arm64/include/generated/uapi/asm/errno.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/errno.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/errno-base.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/cpumask.h \
    $(wildcard include/config/CPUMASK_OFFSTACK) \
    $(wildcard include/config/HOTPLUG_CPU) \
    $(wildcard include/config/DEBUG_PER_CPU_MAPS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/threads.h \
    $(wildcard include/config/BASE_SMALL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bitmap.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/string.h \
    $(wildcard include/config/BINARY_PRINTF) \
    $(wildcard include/config/FORTIFY_SOURCE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/string.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/string.h \
    $(wildcard include/config/ARCH_HAS_UACCESS_FLUSHCACHE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/smp_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/llist.h \
    $(wildcard include/config/ARCH_HAVE_NMI_SAFE_CMPXCHG) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/preempt.h \
    $(wildcard include/config/PREEMPT_COUNT) \
    $(wildcard include/config/TRACE_PREEMPT_TOGGLE) \
    $(wildcard include/config/PREEMPTION) \
    $(wildcard include/config/PREEMPT_NOTIFIERS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/preempt.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/thread_info.h \
    $(wildcard include/config/THREAD_INFO_IN_TASK) \
    $(wildcard include/config/GENERIC_ENTRY) \
    $(wildcard include/config/HAVE_ARCH_WITHIN_STACK_FRAMES) \
    $(wildcard include/config/HARDENED_USERCOPY) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/restart_block.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/current.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/thread_info.h \
    $(wildcard include/config/SHADOW_CALL_STACK) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/memory.h \
    $(wildcard include/config/ARM64_VA_BITS) \
    $(wildcard include/config/KASAN_SHADOW_OFFSET) \
    $(wildcard include/config/KASAN) \
    $(wildcard include/config/VMAP_STACK) \
    $(wildcard include/config/DEBUG_VIRTUAL) \
    $(wildcard include/config/EFI) \
    $(wildcard include/config/ARM_GIC_V3_ITS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sizes.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/page-def.h \
    $(wildcard include/config/ARM64_PAGE_SHIFT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mmdebug.h \
    $(wildcard include/config/DEBUG_VM) \
    $(wildcard include/config/DEBUG_VM_PGFLAGS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/memory_model.h \
    $(wildcard include/config/FLATMEM) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP) \
    $(wildcard include/config/SPARSEMEM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/pfn.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/stack_pointer.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/smp.h \
    $(wildcard include/config/ARM64_ACPI_PARKING_PROTOCOL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/percpu.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/percpu.h \
    $(wildcard include/config/HAVE_SETUP_PER_CPU_AREA) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/percpu-defs.h \
    $(wildcard include/config/DEBUG_FORCE_WEAK_PER_CPU) \
    $(wildcard include/config/AMD_MEM_ENCRYPT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/clocksource/arm_arch_timer.h \
    $(wildcard include/config/ARM_ARCH_TIMER) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/timecounter.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/timex.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/time32.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/time.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/compat.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/compat.h \
    $(wildcard include/config/COMPAT_FOR_U64_ALIGNMENT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched.h \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_NATIVE) \
    $(wildcard include/config/SCHED_INFO) \
    $(wildcard include/config/SCHEDSTATS) \
    $(wildcard include/config/FAIR_GROUP_SCHED) \
    $(wildcard include/config/RT_GROUP_SCHED) \
    $(wildcard include/config/RT_MUTEXES) \
    $(wildcard include/config/UCLAMP_TASK) \
    $(wildcard include/config/UCLAMP_BUCKETS_COUNT) \
    $(wildcard include/config/KMAP_LOCAL) \
    $(wildcard include/config/SCHED_CORE) \
    $(wildcard include/config/CGROUP_SCHED) \
    $(wildcard include/config/BLK_DEV_IO_TRACE) \
    $(wildcard include/config/PREEMPT_RCU) \
    $(wildcard include/config/TASKS_RCU) \
    $(wildcard include/config/TASKS_TRACE_RCU) \
    $(wildcard include/config/PSI) \
    $(wildcard include/config/MEMCG) \
    $(wildcard include/config/COMPAT_BRK) \
    $(wildcard include/config/CGROUPS) \
    $(wildcard include/config/BLK_CGROUP) \
    $(wildcard include/config/PAGE_OWNER) \
    $(wildcard include/config/EVENTFD) \
    $(wildcard include/config/STACKPROTECTOR) \
    $(wildcard include/config/ARCH_HAS_SCALED_CPUTIME) \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_GEN) \
    $(wildcard include/config/NO_HZ_FULL) \
    $(wildcard include/config/POSIX_CPUTIMERS) \
    $(wildcard include/config/POSIX_CPU_TIMERS_TASK_WORK) \
    $(wildcard include/config/KEYS) \
    $(wildcard include/config/SYSVIPC) \
    $(wildcard include/config/DETECT_HUNG_TASK) \
    $(wildcard include/config/IO_URING) \
    $(wildcard include/config/AUDIT) \
    $(wildcard include/config/AUDITSYSCALL) \
    $(wildcard include/config/DEBUG_MUTEXES) \
    $(wildcard include/config/TRACE_IRQFLAGS) \
    $(wildcard include/config/UBSAN) \
    $(wildcard include/config/UBSAN_TRAP) \
    $(wildcard include/config/BLOCK) \
    $(wildcard include/config/COMPACTION) \
    $(wildcard include/config/TASK_XACCT) \
    $(wildcard include/config/CPUSETS) \
    $(wildcard include/config/X86_CPU_RESCTRL) \
    $(wildcard include/config/FUTEX) \
    $(wildcard include/config/PERF_EVENTS) \
    $(wildcard include/config/NUMA) \
    $(wildcard include/config/NUMA_BALANCING) \
    $(wildcard include/config/RSEQ) \
    $(wildcard include/config/TASK_DELAY_ACCT) \
    $(wildcard include/config/FAULT_INJECTION) \
    $(wildcard include/config/LATENCYTOP) \
    $(wildcard include/config/KUNIT) \
    $(wildcard include/config/FUNCTION_GRAPH_TRACER) \
    $(wildcard include/config/UPROBES) \
    $(wildcard include/config/BCACHE) \
    $(wildcard include/config/SECURITY) \
    $(wildcard include/config/BPF_SYSCALL) \
    $(wildcard include/config/GCC_PLUGIN_STACKLEAK) \
    $(wildcard include/config/X86_MCE) \
    $(wildcard include/config/KRETPROBES) \
    $(wildcard include/config/ARCH_HAS_PARANOID_L1D_FLUSH) \
    $(wildcard include/config/ARCH_TASK_STRUCT_ON_STACK) \
    $(wildcard include/config/DEBUG_RSEQ) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/sched.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/pid.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rculist.h \
    $(wildcard include/config/PROVE_RCU_LIST) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rcupdate.h \
    $(wildcard include/config/TINY_RCU) \
    $(wildcard include/config/TASKS_RCU_GENERIC) \
    $(wildcard include/config/RCU_STALL_COMMON) \
    $(wildcard include/config/RCU_NOCB_CPU) \
    $(wildcard include/config/TASKS_RUDE_RCU) \
    $(wildcard include/config/TREE_RCU) \
    $(wildcard include/config/DEBUG_OBJECTS_RCU_HEAD) \
    $(wildcard include/config/PROVE_RCU) \
    $(wildcard include/config/ARCH_WEAK_RELEASE_ACQUIRE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/irqflags.h \
    $(wildcard include/config/IRQSOFF_TRACER) \
    $(wildcard include/config/PREEMPT_TRACER) \
    $(wildcard include/config/DEBUG_IRQFLAGS) \
    $(wildcard include/config/TRACE_IRQFLAGS_SUPPORT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/irqflags.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/ptrace.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/ptrace.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/sve_context.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bottom_half.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/lockdep.h \
    $(wildcard include/config/DEBUG_LOCKING_API_SELFTESTS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/processor.h \
    $(wildcard include/config/KUSER_HELPERS) \
    $(wildcard include/config/ARM64_FORCE_52BIT) \
    $(wildcard include/config/HAVE_HW_BREAKPOINT) \
    $(wildcard include/config/ARM64_PTR_AUTH_KERNEL) \
    $(wildcard include/config/ARM64_TAGGED_ADDR_ABI) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/processor.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/vdso/processor.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/hw_breakpoint.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/virt.h \
    $(wildcard include/config/KVM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/sections.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/sections.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/kasan.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/mte-kasan.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/mte-def.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/pgtable-types.h \
    $(wildcard include/config/PGTABLE_LEVELS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/pgtable-nopud.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/pgtable-nop4d.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/pgtable-hwdef.h \
    $(wildcard include/config/ARM64_CONT_PTE_SHIFT) \
    $(wildcard include/config/ARM64_CONT_PMD_SHIFT) \
    $(wildcard include/config/ARM64_VA_BITS_52) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/pointer_auth.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/prctl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/random.h \
    $(wildcard include/config/ARCH_RANDOM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/once.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/random.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/ioctl.h \
  arch/arm64/include/generated/uapi/asm/ioctl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/ioctl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/ioctl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/irqnr.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/irqnr.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/prandom.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/percpu.h \
    $(wildcard include/config/NEED_PER_CPU_EMBED_FIRST_CHUNK) \
    $(wildcard include/config/NEED_PER_CPU_PAGE_FIRST_CHUNK) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/siphash.h \
    $(wildcard include/config/HAVE_EFFICIENT_UNALIGNED_ACCESS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/archrandom.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/arm-smccc.h \
    $(wildcard include/config/ARM64) \
    $(wildcard include/config/HAVE_ARM_SMCCC) \
    $(wildcard include/config/ARM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/spectre.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/fpsimd.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/sigcontext.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rcutree.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/wait.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/spinlock.h \
  arch/arm64/include/generated/asm/mmiowb.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/mmiowb.h \
    $(wildcard include/config/MMIOWB) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/spinlock.h \
  arch/arm64/include/generated/asm/qspinlock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/qspinlock.h \
  arch/arm64/include/generated/asm/qrwlock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/qrwlock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rwlock.h \
    $(wildcard include/config/PREEMPT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/INLINE_SPIN_LOCK) \
    $(wildcard include/config/INLINE_SPIN_LOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK_BH) \
    $(wildcard include/config/UNINLINE_SPIN_UNLOCK) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/GENERIC_LOCKBREAK) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/INLINE_READ_LOCK) \
    $(wildcard include/config/INLINE_WRITE_LOCK) \
    $(wildcard include/config/INLINE_READ_LOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_LOCK_BH) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_READ_TRYLOCK) \
    $(wildcard include/config/INLINE_WRITE_TRYLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_BH) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQRESTORE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/wait.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/refcount.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sem.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/sem.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ipc.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/uidgid.h \
    $(wildcard include/config/MULTIUSER) \
    $(wildcard include/config/USER_NS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/highuid.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rhashtable-types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mutex.h \
    $(wildcard include/config/MUTEX_SPIN_ON_OWNER) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/osq_lock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/debug_locks.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/workqueue.h \
    $(wildcard include/config/DEBUG_OBJECTS_WORK) \
    $(wildcard include/config/FREEZER) \
    $(wildcard include/config/WQ_WATCHDOG) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/timer.h \
    $(wildcard include/config/DEBUG_OBJECTS_TIMERS) \
    $(wildcard include/config/NO_HZ_COMMON) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ktime.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/jiffies.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/jiffies.h \
  include/generated/timeconst.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/vdso/ktime.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/timekeeping.h \
    $(wildcard include/config/GENERIC_CMOS_UPDATE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/clocksource_ids.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/debugobjects.h \
    $(wildcard include/config/DEBUG_OBJECTS) \
    $(wildcard include/config/DEBUG_OBJECTS_FREE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/ipc.h \
  arch/arm64/include/generated/uapi/asm/ipcbuf.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/ipcbuf.h \
  arch/arm64/include/generated/uapi/asm/sembuf.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/sembuf.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/shm.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/page.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/personality.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/personality.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/getorder.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/shm.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/hugetlb_encode.h \
  arch/arm64/include/generated/uapi/asm/shmbuf.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/shmbuf.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/shmparam.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/shmparam.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/plist.h \
    $(wildcard include/config/DEBUG_PLIST) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/hrtimer.h \
    $(wildcard include/config/HIGH_RES_TIMERS) \
    $(wildcard include/config/TIME_LOW_RES) \
    $(wildcard include/config/TIMERFD) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/hrtimer_defs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rbtree.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rbtree_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/seqlock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ww_mutex.h \
    $(wildcard include/config/DEBUG_RT_MUTEXES) \
    $(wildcard include/config/DEBUG_WW_MUTEX_SLOWPATH) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rtmutex.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/timerqueue.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/seccomp.h \
    $(wildcard include/config/SECCOMP) \
    $(wildcard include/config/HAVE_ARCH_SECCOMP_FILTER) \
    $(wildcard include/config/SECCOMP_FILTER) \
    $(wildcard include/config/CHECKPOINT_RESTORE) \
    $(wildcard include/config/SECCOMP_CACHE_DEBUG) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/seccomp.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/seccomp.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/unistd.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/unistd.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/unistd.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/seccomp.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/unistd.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/nodemask.h \
    $(wildcard include/config/HIGHMEM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/numa.h \
    $(wildcard include/config/NODES_SHIFT) \
    $(wildcard include/config/NUMA_KEEP_MEMINFO) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/resource.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/resource.h \
  arch/arm64/include/generated/uapi/asm/resource.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/resource.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/resource.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/latencytop.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/prio.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/signal_types.h \
    $(wildcard include/config/OLD_SIGACTION) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/signal.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/signal.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/signal.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/signal.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/signal.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/signal-defs.h \
  arch/arm64/include/generated/uapi/asm/siginfo.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/siginfo.h \
  arch/arm64/include/generated/uapi/asm/siginfo.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/syscall_user_dispatch.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mm_types_task.h \
    $(wildcard include/config/ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH) \
    $(wildcard include/config/SPLIT_PTLOCK_CPUS) \
    $(wildcard include/config/ARCH_ENABLE_SPLIT_PMD_PTLOCK) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/task_io_accounting.h \
    $(wildcard include/config/TASK_IO_ACCOUNTING) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/posix-timers.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/alarmtimer.h \
    $(wildcard include/config/RTC_CLASS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/task_work.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/rseq.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kcsan.h \
  arch/arm64/include/generated/asm/kmap_size.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/kmap_size.h \
    $(wildcard include/config/DEBUG_KMAP_LOCAL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/task_stack.h \
    $(wildcard include/config/STACK_GROWSUP) \
    $(wildcard include/config/DEBUG_STACK_USAGE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/magic.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/stat.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/buildid.h \
    $(wildcard include/config/CRASH_CORE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mm_types.h \
    $(wildcard include/config/HAVE_ALIGNED_STRUCT_PAGE) \
    $(wildcard include/config/USERFAULTFD) \
    $(wildcard include/config/SWAP) \
    $(wildcard include/config/HAVE_ARCH_COMPAT_MMAP_BASES) \
    $(wildcard include/config/MEMBARRIER) \
    $(wildcard include/config/AIO) \
    $(wildcard include/config/MMU_NOTIFIER) \
    $(wildcard include/config/TRANSPARENT_HUGEPAGE) \
    $(wildcard include/config/HUGETLB_PAGE) \
    $(wildcard include/config/IOMMU_SUPPORT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/auxvec.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/auxvec.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/auxvec.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rwsem.h \
    $(wildcard include/config/RWSEM_SPIN_ON_OWNER) \
    $(wildcard include/config/DEBUG_RWSEMS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/err.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/completion.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/swait.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/uprobes.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/page-flags-layout.h \
  include/generated/bounds.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/sparsemem.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/mmu.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kmod.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/umh.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/gfp.h \
    $(wildcard include/config/ZONE_DMA) \
    $(wildcard include/config/ZONE_DMA32) \
    $(wildcard include/config/ZONE_DEVICE) \
    $(wildcard include/config/PM_SLEEP) \
    $(wildcard include/config/CONTIG_ALLOC) \
    $(wildcard include/config/CMA) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mmzone.h \
    $(wildcard include/config/FORCE_MAX_ZONEORDER) \
    $(wildcard include/config/MEMORY_ISOLATION) \
    $(wildcard include/config/ZSMALLOC) \
    $(wildcard include/config/MEMORY_HOTPLUG) \
    $(wildcard include/config/PAGE_EXTENSION) \
    $(wildcard include/config/DEFERRED_STRUCT_PAGE_INIT) \
    $(wildcard include/config/HAVE_MEMORYLESS_NODES) \
    $(wildcard include/config/SPARSEMEM_EXTREME) \
    $(wildcard include/config/HAVE_ARCH_PFN_VALID) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/pageblock-flags.h \
    $(wildcard include/config/HUGETLB_PAGE_SIZE_VARIABLE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/page-flags.h \
    $(wildcard include/config/ARCH_USES_PG_UNCACHED) \
    $(wildcard include/config/MEMORY_FAILURE) \
    $(wildcard include/config/PAGE_IDLE_FLAG) \
    $(wildcard include/config/THP_SWAP) \
    $(wildcard include/config/KSM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/local_lock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/local_lock_internal.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/memory_hotplug.h \
    $(wildcard include/config/ARCH_HAS_ADD_PAGES) \
    $(wildcard include/config/HAVE_ARCH_NODEDATA_EXTENSION) \
    $(wildcard include/config/MEMORY_HOTREMOVE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/notifier.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/srcu.h \
    $(wildcard include/config/TINY_SRCU) \
    $(wildcard include/config/SRCU) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rcu_segcblist.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/srcutree.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rcu_node_tree.h \
    $(wildcard include/config/RCU_FANOUT) \
    $(wildcard include/config/RCU_FANOUT_LEAF) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/topology.h \
    $(wildcard include/config/USE_PERCPU_NUMA_NODE_ID) \
    $(wildcard include/config/SCHED_SMT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/arch_topology.h \
    $(wildcard include/config/GENERIC_ARCH_TOPOLOGY) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/topology.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/topology.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sysctl.h \
    $(wildcard include/config/SYSCTL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/sysctl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/elf.h \
    $(wildcard include/config/ARCH_USE_GNU_PROPERTY) \
    $(wildcard include/config/ARCH_HAVE_ELF_PROT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/elf.h \
    $(wildcard include/config/COMPAT_VDSO) \
  arch/arm64/include/generated/asm/user.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/user.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/elf.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/elf-em.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/fs.h \
    $(wildcard include/config/READ_ONLY_THP_FOR_FS) \
    $(wildcard include/config/FS_POSIX_ACL) \
    $(wildcard include/config/CGROUP_WRITEBACK) \
    $(wildcard include/config/IMA) \
    $(wildcard include/config/FILE_LOCKING) \
    $(wildcard include/config/FSNOTIFY) \
    $(wildcard include/config/FS_ENCRYPTION) \
    $(wildcard include/config/FS_VERITY) \
    $(wildcard include/config/EPOLL) \
    $(wildcard include/config/UNICODE) \
    $(wildcard include/config/QUOTA) \
    $(wildcard include/config/FS_DAX) \
    $(wildcard include/config/MIGRATION) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/wait_bit.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kdev_t.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/kdev_t.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/dcache.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rculist_bl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/list_bl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bit_spinlock.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/lockref.h \
    $(wildcard include/config/ARCH_USE_CMPXCHG_LOCKREF) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/stringhash.h \
    $(wildcard include/config/DCACHE_WORD_ACCESS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/hash.h \
    $(wildcard include/config/HAVE_ARCH_HASH) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/path.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/list_lru.h \
    $(wildcard include/config/MEMCG_KMEM) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/shrinker.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/radix-tree.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/xarray.h \
    $(wildcard include/config/XARRAY_MULTI) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kconfig.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/capability.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/capability.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/semaphore.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/fcntl.h \
    $(wildcard include/config/ARCH_32BIT_OFF_T) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/fcntl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/uapi/asm/fcntl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/asm-generic/fcntl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/openat2.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/migrate_mode.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/percpu-rwsem.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rcuwait.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/signal.h \
    $(wildcard include/config/SCHED_AUTOGROUP) \
    $(wildcard include/config/BSD_PROCESS_ACCT) \
    $(wildcard include/config/TASKSTATS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/signal.h \
    $(wildcard include/config/PROC_FS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/jobctl.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/task.h \
    $(wildcard include/config/HAVE_EXIT_THREAD) \
    $(wildcard include/config/ARCH_WANTS_DYNAMIC_TASK_STRUCT) \
    $(wildcard include/config/HAVE_ARCH_THREAD_STRUCT_WHITELIST) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/uaccess.h \
    $(wildcard include/config/SET_FS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/fault-inject-usercopy.h \
    $(wildcard include/config/FAULT_INJECTION_USERCOPY) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/uaccess.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/kernel-pgtable.h \
    $(wildcard include/config/RANDOMIZE_BASE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/mte.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/bitfield.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/extable.h \
    $(wildcard include/config/BPF_JIT) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/cred.h \
    $(wildcard include/config/DEBUG_CREDENTIALS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/key.h \
    $(wildcard include/config/KEY_NOTIFICATIONS) \
    $(wildcard include/config/NET) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/assoc_array.h \
    $(wildcard include/config/ASSOCIATIVE_ARRAY) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/user.h \
    $(wildcard include/config/WATCH_QUEUE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/percpu_counter.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ratelimit.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rcu_sync.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/delayed_call.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/uuid.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/uuid.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/errseq.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ioprio.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/rt.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/iocontext.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/ioprio.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/fs_types.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mount.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/mnt_idmapping.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/fs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/quota.h \
    $(wildcard include/config/QUOTA_NETLINK_INTERFACE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/dqblk_xfs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/dqblk_v1.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/dqblk_v2.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/dqblk_qtree.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/projid.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/uapi/linux/quota.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/nfs_fs_i.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kobject.h \
    $(wildcard include/config/UEVENT_HELPER) \
    $(wildcard include/config/DEBUG_KOBJECT_RELEASE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sysfs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kernfs.h \
    $(wildcard include/config/KERNFS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/idr.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kobject_ns.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kref.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/moduleparam.h \
    $(wildcard include/config/ALPHA) \
    $(wildcard include/config/IA64) \
    $(wildcard include/config/PPC64) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/rbtree_latch.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/error-injection.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/error-injection.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/tracepoint-defs.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/static_key.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/cfi.h \
    $(wildcard include/config/CFI_CLANG_SHADOW) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/module.h \
    $(wildcard include/config/ARM64_MODULE_PLTS) \
    $(wildcard include/config/DYNAMIC_FTRACE) \
    $(wildcard include/config/ARM64_ERRATUM_843419) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/module.h \
    $(wildcard include/config/HAVE_MOD_ARCH_SPECIFIC) \
    $(wildcard include/config/MODULES_USE_ELF_REL) \
    $(wildcard include/config/MODULES_USE_ELF_RELA) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/device.h \
    $(wildcard include/config/ENERGY_MODEL) \
    $(wildcard include/config/GENERIC_MSI_IRQ_DOMAIN) \
    $(wildcard include/config/PINCTRL) \
    $(wildcard include/config/GENERIC_MSI_IRQ) \
    $(wildcard include/config/DMA_OPS) \
    $(wildcard include/config/DMA_DECLARE_COHERENT) \
    $(wildcard include/config/DMA_CMA) \
    $(wildcard include/config/SWIOTLB) \
    $(wildcard include/config/ARCH_HAS_SYNC_DMA_FOR_DEVICE) \
    $(wildcard include/config/ARCH_HAS_SYNC_DMA_FOR_CPU) \
    $(wildcard include/config/ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) \
    $(wildcard include/config/DMA_OPS_BYPASS) \
    $(wildcard include/config/OF) \
    $(wildcard include/config/DEVTMPFS) \
    $(wildcard include/config/SYSFS_DEPRECATED) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/dev_printk.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/energy_model.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/cpufreq.h \
    $(wildcard include/config/CPU_FREQ) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/topology.h \
    $(wildcard include/config/SCHED_DEBUG) \
    $(wildcard include/config/SCHED_MC) \
    $(wildcard include/config/CPU_FREQ_GOV_SCHEDUTIL) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/idle.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/sched/sd_flags.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/ioport.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/klist.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/pm.h \
    $(wildcard include/config/VT_CONSOLE_SLEEP) \
    $(wildcard include/config/PM) \
    $(wildcard include/config/PM_CLK) \
    $(wildcard include/config/PM_GENERIC_DOMAINS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/overflow.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/device/bus.h \
    $(wildcard include/config/ACPI) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/device/class.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/device/driver.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/device.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/pm_wakeup.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/io.h \
    $(wildcard include/config/HAS_IOPORT_MAP) \
    $(wildcard include/config/PCI) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/io.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/pgtable.h \
    $(wildcard include/config/HIGHPTE) \
    $(wildcard include/config/GUP_GET_PTE_LOW_HIGH) \
    $(wildcard include/config/HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) \
    $(wildcard include/config/HAVE_ARCH_SOFT_DIRTY) \
    $(wildcard include/config/ARCH_ENABLE_THP_MIGRATION) \
    $(wildcard include/config/ARCH_HAS_PTE_DEVMAP) \
    $(wildcard include/config/HAVE_ARCH_HUGE_VMAP) \
    $(wildcard include/config/X86_ESPFIX64) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/pgtable.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/proc-fns.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/pgtable-prot.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/tlbflush.h \
    $(wildcard include/config/ARM64_WORKAROUND_REPEAT_TLBI) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/fixmap.h \
    $(wildcard include/config/ACPI_APEI_GHES) \
    $(wildcard include/config/ARM_SDE_INTERFACE) \
    $(wildcard include/config/UNMAP_KERNEL_AT_EL0) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/boot.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/fixmap.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/pgtable_uffd.h \
    $(wildcard include/config/HAVE_ARCH_USERFAULTFD_WP) \
  arch/arm64/include/generated/asm/early_ioremap.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/early_ioremap.h \
    $(wildcard include/config/GENERIC_EARLY_IOREMAP) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/io.h \
    $(wildcard include/config/GENERIC_IOMAP) \
    $(wildcard include/config/GENERIC_IOREMAP) \
    $(wildcard include/config/VIRT_TO_BUS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/pci_iomap.h \
    $(wildcard include/config/NO_GENERIC_PCI_IOPORT_MAP) \
    $(wildcard include/config/GENERIC_PCI_IOMAP) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/logic_pio.h \
    $(wildcard include/config/INDIRECT_PIO) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/fwnode.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/vmalloc.h \
    $(wildcard include/config/KASAN_VMALLOC) \
    $(wildcard include/config/HAVE_ARCH_HUGE_VMALLOC) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/arch/arm64/include/asm/vmalloc.h \
    $(wildcard include/config/PTDUMP_DEBUGFS) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/slab.h \
    $(wildcard include/config/DEBUG_SLAB) \
    $(wildcard include/config/FAILSLAB) \
    $(wildcard include/config/HAVE_HARDENED_USERCOPY_ALLOCATOR) \
    $(wildcard include/config/SLAB) \
    $(wildcard include/config/SLUB) \
    $(wildcard include/config/SLOB) \
    $(wildcard include/config/CC_IS_GCC) \
    $(wildcard include/config/CLANG_VERSION) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/percpu-refcount.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/kasan.h \
    $(wildcard include/config/KASAN_STACK) \
    $(wildcard include/config/KASAN_INLINE) \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/linux/delay.h \
  arch/arm64/include/generated/asm/delay.h \
  /home/abdo/yocto/poky/nti_build/tmp/work-shared/raspberrypi3-64/kernel-source/include/asm-generic/delay.h \
  include/generated/uapi/linux/version.h \
  /home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.h \

/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o: $(deps_/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o)

$(deps_/home/abdo/yocto/layers/meta-abozaid/recipes-kernel/gpio_driver/files/gpiomod.o):
