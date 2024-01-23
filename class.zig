
// Const
pub const std = @import("std");

pub const fmt = std.fmt;
pub const io = std.io;
pub const mem = std.mem;
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

pub fn gen(comptime T: anytype) type {
    const N = Array(T);

    return struct {
//        var al: G.allocator();

        al: mem.Allocator,
        d: Array(N),
        l: *N,

        pub fn init(al: anytype) @This() {
            var s: @This() = undefined;

            s.al = al;
            s.d = Array(N).init(al);
          
            return s;
        }

        pub fn items(sl: anytype) []N {
            return sl.d.items;
        }

        pub fn h(sl: anytype) usize {
            return sl.d.items.len;
        }

        pub fn w(sl: anytype) usize {
            return sl.l.items.len;
        }

        pub fn new(sl: anytype) !void {
            const l = N.init(sl.al);

            try sl.d.append(l);

            const i = sl.d.items;

            sl.l = &i[i.len-1];
        }

        pub fn add(sl: anytype, v: anytype) !void {
            try sl.l.append(v);
        }

        pub fn get(sl: anytype, ii: anytype, cc: anytype) T {

            const i: usize = @intCast(ii);
            const c: usize = @intCast(cc);

            return sl.d.items[i].items[c];
        }

        pub fn set(
            sl: anytype, ii: anytype, jj: anytype,
            t: anytype
        ) !void {

            const i: usize = @intCast(ii);
            const j: usize = @intCast(jj);

            const c = sl.d.items;
        
            assert(i < c.len);

            const r = c[i].items;

            assert(j < r.len);

            const x = r[j];

            _ = switch(t) {
                T.set => assert(x == T.fre),
                T.fre => assert(x == T.set),

                else => {
                    try err("set", t);
                }
            };

            r[j] = t;
        }

        pub fn deinit(sl: anytype) void {
            for (sl.d.items) |i| {
                i.deinit();

            }
            sl.d.deinit();
        }
    };
}

pub fn num(v: anytype) !u64 {
    var n: u64 = undefined;

    if (v[0] >= '0' and v[0] <= '9') {
        n = fmt.parseUnsigned(u64, v, 10) catch |e| {
            err("Invalid int", v) catch {};

            return e;
        };
    } else {
        try err("Invalid number", v);

    }

    return n;
}

pub fn split(d: anytype, s: anytype) mem.SplitIterator(u8,.sequence) {
    return std.mem.split(u8, d, s);
}

pub fn eql(d: anytype, s: anytype) bool {
    return std.mem.eql(u8, d, s);
}
