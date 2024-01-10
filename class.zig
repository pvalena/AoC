
// Const
pub const std = @import("std");

pub const split = std.mem.split;
pub const fmt = std.fmt;
pub const io = std.io;
pub const debug = std.debug;
pub const assert = debug.assert;
pub const stdout = io.getStdOut().writer();

// Types
pub const Array = std.ArrayList;

// Gvar
//pub var bw = io.bufferedWriter(stdout);
//pub const bw_stdout = bw.writer();
//    try bw.flush(); // don't forget to flush!
pub var dbg = false;

// Helpers
pub fn deb(comptime s: anytype, d: anytype, comptime t: anytype) void {
    if (!dbg) return;

//  for (std.meta.fields(@TypeOf(items)) |field| {
//    const value = @field(items, field.name); 
//
//  }

    debug.print(s ++ ": {" ++ t ++ "}\n", .{d});
}

//fn puts(d: anytype) void {
pub fn puts(d: anytype) void {
    stdout.print("{s}\n", .{d}) catch {};
}

pub fn putd(d: anytype) void {
    if (dbg) debug.print("{s}\n", .{d});
}

pub fn err(comptime l: anytype, d: anytype) !void {
    dbg = true;
    putd("");

    const s = "Error[" ++ l ++ "]";

    deb(s, d, "any");

    putd("");

    return error.err;
}

pub fn res(d: anytype, comptime t: anytype) void {
    stdout.print("\n => {" ++ t ++ "}\n\n", .{d}) catch |e| {
        err("res", @errorName(e)) catch {};
    };
}

pub fn ini(al: anytype, tf: anytype, np: *u64) ![]u8 {

    var args = std.process.args();

    _ = args.skip();
    
    const f = args.next() orelse tf;

    if (f.len == 0) {
        try err("Missing Arg: Filename", null);
    }

    const d = try std.fs.cwd().readFileAlloc(al, f, std.math.maxInt(usize));

//    deb("data", d, "s");

    const a = args.next();

    if (a) |n| {
        const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
            err("Invalid int", n) catch {};

            return e;
        };

        np.* = v;

        deb("Number", v, "d");
    }

    return d;
}
