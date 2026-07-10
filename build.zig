const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    // lib/ : resolves iconv.c's `#include "config.h"` (quotes, same dir) and
    //        localcharset.c's `#include <config.h>` (angle brackets).
    // include/ : resolves `#include <iconv.h>` (the public, generated header).
    // libcharset/include/ : resolves localcharset.c/iconv.c's
    //        `#include "localcharset.h"` (quotes, falls back to -I since
    //        it doesn't live next to either .c file).
    mod.addIncludePath(b.path("lib"));
    mod.addIncludePath(b.path("include"));
    mod.addIncludePath(b.path("libcharset/include"));
    // Needed for BUILDING_LIBICONV-gated bits (not currently used, since
    // this build doesn't route through export.h -- see lib/config.h).
    mod.addCMacro("BUILDING_LIBICONV", "1");
    mod.addCMacro("LIBDIR", "\"\"");

    mod.addCSourceFiles(.{
        .root = b.path("lib"),
        .files = &.{ "iconv.c", "compat.c" },
        .flags = &.{ "-std=gnu99", "-w" },
    });
    mod.addCSourceFiles(.{
        .root = b.path("libcharset/lib"),
        .files = &.{"localcharset.c"},
        .flags = &.{ "-std=gnu99", "-w" },
    });

    const lib = b.addLibrary(.{
        .name = "iconv",
        .linkage = .static,
        .root_module = mod,
    });
    lib.installHeader(b.path("include/iconv.h"), "iconv.h");
    b.installArtifact(lib);
}
