
// Const
pub const std = @import("std");

pub const split = std.mem.split;
pub const fmt = std.fmt;
pub const io = std.io;
pub const debug = std.debug;
pub const assert = debug.assert;
pub const stdout = io.getStdOut().writer();
pub const tst = std.time.timestamp;

// Types
pub const Array = std.ArrayList;

// Gvar
//pub var bw = io.bufferedWriter(stdout);
//pub const bw_stdout = bw.writer();
//    try bw.flush(); // don't forget to flush!
pub var dbg = false;

// Helpers
pub fn deb(comptime s: anytype, d: anytype) void {
    if (!dbg) return;

//  for (std.meta.fields(@TypeOf(items)) |field| {
//    const value = @field(items, field.name); 
//
//  }

    debug.print(s ++ ": {any}\n", .{d});
}

pub fn puts(comptime ll: anytype, d: anytype) void {
    
    const l = if (ll.len > 0) ll ++ ": " else ll;

    debug.print(l ++ "{s}\n", .{d});
}

pub fn putd(comptime ll: anytype, d: anytype) void {

    const l = if (ll.len > 0) ll ++ ": " else ll;

    debug.print(l ++ "{d}\n", .{d});
}

pub fn err(comptime l: anytype, d: anytype) !void {
    dbg = true;

    const s = "\nError[" ++ l ++ "]";

    deb(s, d);

    debug.print("\n", .{});

    return error.err;
}

pub fn res(d: anytype) void {
    stdout.print("\n => {}\n\n", .{d}) catch {};
}

pub fn ini(al: anytype, tf: anytype, np: *u64) ![]u8 {

    var args = std.process.args();

    _ = args.skip();
    
    const f = args.next() orelse tf;

    if (f.len == 0) {
        try err("Missing Arg: Filename", null);
    }

    const d = try std.fs.cwd().readFileAlloc(al, f, std.math.maxInt(usize));

//    puts("data", d);

    const a = args.next();

    if (a) |n| {
        const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
            err("Invalid int", n) catch {};

            return e;
        };

        np.* = v;
    }

    return d;
}

pub fn lin(comptime l: anytype, i: anytype) void {

    if (!dbg) return;

    if (l.len < 3) {
        const k = 3 - l.len;

        for (0..k) |_| debug.print(" ", .{});
    }
    debug.print(l ++ ": ", .{});

    for (0..i) |_| {
        debug.print(" ", .{});
    }

    debug.print("^ {}\n", .{i});
}


pub fn eut(comptime l: anytype, f: anytype, s: ?[]i64,
    c: anytype
) !void {
    dbg = true;

    out(l, f, s, c);
    try err("", null);
}

pub fn eut2(comptime l: anytype, f: anytype, s: ?[]i64,
    c: anytype
) !void {
    dbg = true;

    out2(l, f, s, c);
    try err("", null);
}

pub fn out(comptime l: anytype, f: anytype, s: ?[]i64, c: anytype) void {
    if (!dbg) return;

    if (l.len < 3) {
        const k = 3 - l.len;

        for (0..k) |_| debug.print(" ", .{});
    }
    debug.print(l ++ ": ", .{});

    for (f.items) |t| {

        const v = c(t);

        debug.print("{c}", .{v});
    }

    if (s) |ss| {
        debug.print(" <- ", .{});

        for (ss) |v| {
            debug.print("{} ", .{v});
        }
    }
    debug.print("\n", .{});
}

pub fn out2(comptime l: anytype, d: anytype, s: anytype, c: anytype) void {
    if (!dbg) return;

    var f: bool = true;

    for (d.items()) |r| {

        if (f) {
            out(l, r, s, c);
            f = false;

        } else {
            out("", r, null, c);

        }

    }

    debug.print("\n", .{});
}

pub fn pr(comptime f: anytype, s: anytype) void {
    stdout.print(f, s) catch {};
}
