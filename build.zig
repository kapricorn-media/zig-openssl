const std = @import("std");

pub fn build(b: *std.build.Builder) void
{
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("openssl", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.linkLibC();
    exe.install();

    addLib(exe, ".");
}

pub fn addLib(step: *std.build.LibExeObjStep, comptime dir: []const u8) void
{
    step.addIncludeDir(dir ++ "include");
    step.addIncludeDir(dir ++ "include/x86_64-linux-gnu");
    const fullPath = "C:\\Users\\Jose Rico\\Documents\\Development\\zig-openssl";
    step.addSystemIncludeDir(fullPath ++ "\\include");
    step.addSystemIncludeDir(fullPath ++ "\\include\\x86_64-linux-gnu");
    step.addLibPath(dir ++ "lib/x86_64-linux-gnu");
}
