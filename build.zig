const builtin = @import("builtin");
const std = @import("std");

pub fn targetToTripletString(target: std.zig.CrossTarget) ![]const u8
{
    if (target.os_tag) |os| {
        if (os != .linux) {
            return error.UnsupportedOs;
        }
    }
    else {
    }

    if (target.abi) |abi| {
        if (abi != .gnu) {
            return error.UnsupportedAbi;
        }
    }
    else {
    }

    const arch = if (target.cpu_arch) |a| a else builtin.cpu.arch;
    switch (arch) {
        .x86_64 => return "x86_64-linux-gnu",
        .aarch64 => return "aarch64-linux-gnu",
        else => return error.UnsupportedArch,
    }

    return error.UnsupportedTarget;
}

pub fn build(b: *std.build.Builder) void
{
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("openssl", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.linkLibC();
    exe.install();

    addLib(exe, target, ".") catch unreachable;
}

pub fn addLib(step: *std.build.LibExeObjStep, target: std.zig.CrossTarget, comptime dir: []const u8) !void
{
    var buf: [2048]u8 = undefined;
    const tripletString = try targetToTripletString(target);

    step.addIncludeDir(dir ++ "/include");
    const includePath = try std.fmt.bufPrint(buf[0..], "{s}/include/{s}", .{dir, tripletString});
    step.addIncludeDir(includePath);

    const libPath = try std.fmt.bufPrint(buf[0..], "{s}/lib/{s}", .{dir, tripletString});
    step.addLibPath(libPath);
    step.linkSystemLibrary("ssl");
    step.linkSystemLibrary("crypto");
}
