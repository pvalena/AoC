
// Const
const std = @import("std");

const split = std.mem.split;
const fmt = std.fmt;
const io = std.io;
const debug = std.debug;
const assert = debug.assert;

const stdout = io.getStdOut().writer();

// Types
const Array = std.ArrayList;

// Gvar
//var bw = io.bufferedWriter(stdout);
//const bw_stdout = bw.writer();
//    try bw.flush(); // don't forget to flush!
var dbg = false;

// Helpers
fn deb(comptime s: anytype, d: anytype, comptime t: anytype) void {
    if (!dbg) return;

//  for (std.meta.fields(@TypeOf(items)) |field| {
//    const value = @field(items, field.name); 
//
//  }

    debug.print(s ++ ": {" ++ t ++ "}\n", .{d});
}

fn puts(d: anytype) void {
    stdout.print("{s}\n", .{d}) catch {};
}

fn putd(d: anytype) void {
    if (dbg) debug.print("{s}\n", .{d});
}

fn err(comptime l: anytype, d: anytype) !void {
    dbg = true;
    putd("");

    const s = "Error[" ++ l ++ "]";

    deb(s, d, "any");

    putd("");

    return error.err;
}

fn res(d: anytype, comptime t: anytype) void {

    stdout.print("\n => {" ++ t ++ "}\n\n", .{d}) catch |e| {
        err("res", @errorName(e)) catch {};
    };
}

// Logic
fn ini(al: anytype, tf: anytype, np: *u64) ![]u8 {

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

const T = enum {
    unk,
    set,
    fre,
};

const D = struct {
    f: Array(T),
    c: Array(T),
    s: Array(u64),
    x: Array(u64),

    fn init(al: anytype) D {
        var self: D = undefined;

        self.f = Array(T).init(al);
        self.c = Array(T).init(al);
        self.s = Array(u64).init(al);
        self.x = Array(u64).init(al);

        return self;
    }
    fn deinit(self: anytype) void {
        self.f.deinit();
        self.c.deinit();
        self.s.deinit();
        self.x.deinit();
    }
};

//fn D(comptime T: type) type {
//    fn init(al: anytype, v: []u8) D {
//        return .{
//            .f = v,
//            .s = Array(u64).init(al),
//        };
//    }
//};

fn par(al: anytype, d: []u8) !Array(D) {

    // Return
    var a = Array(D).init(al);

    // Line
    var ls = split(u8, d, "\n");

    while (ls.next()) |l| {
        if (l.len == 0) continue;

        var x = D.init(al);

        // Elems
        var ws = split(u8, l, " ");
        var i: u64 = 0;

        while (ws.next()) |w| {
            defer i += 1;
            if (w.len == 0) continue;

            x = try dat(x, w, i);
        }
        try a.append(x);
    }

    return a;
}

fn dat(y: anytype, w: anytype, i: anytype) !D {

    var x = y;

    if (i == 0) {
        var f = true;

        for (0..5) |m| {
            for (w) |v| {
                const t = switch(v) {
                    '#' => T.set,
                    '?' => T.unk,
                    '.' => T.fre,

                    else => return error.type
                };

                if (!(f and t == T.fre)) {
                    try x.f.append(t);
                    try x.c.append(T.fre);

                    f = false;
                }
            }

            if (m < 4) {
                try x.f.append(T.unk);
                try x.c.append(T.fre);
            }
        }

        return x;
    }

    for (0..5) |_| {
        var ns = split(u8, w, ",");

        while (ns.next()) |n| {
            if (n.len == 0) continue;

            if (n[0] >= '0' and n[0] <= '9') {
                const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
                    err("Invalid int", n) catch {};

                    return e;
                };

    //            deb("Number", v, "d");

                try x.s.append(v);
                try x.x.append(v);

            } else {
                try err("Invalid number", n);

            }
        }
    }

    return x;
}

fn run(d: anytype, n: anytype) !u64 {

    var r: u64 = 0;

//    const b = 1;
    const b = 1000_000;
    const odbg = dbg;

    const m = 1;
    try stdout.print("r: {}, {}\n\n", .{m*n, m*(n+1)});

    for (d.items, 0..) |x, i| {

//        try err("n", n);

        if (!( i >= m*n and i < m*(n+1) )) continue;

        const f = x.f.items;
        const c = x.c.items;
        const s = x.s.items;
        const z = x.x.items;

        assert(f.len > 0);
        assert(c.len > 0);
        assert(s.len > 0);
        assert(z.len > 0);

//        out("run", f, s);

        var v: u64 = 0;

        dbg = if (i >= b and odbg) true else false;

        try bum(f, c, s, z, &v);
//        try rcs(f, c, 0, s, 0, 0, &v, T.unk);

        r += v;

        try stdout.print("v: {}, {}\n\n", .{i, v});

//        puts("v", v, "");
//        if (dbg) debug.print("\n", .{});

        if (i >= b) break;
    }

    return r;
}

fn out(comptime l: anytype, f: anytype, s: ?[]u64) void {
    if (!dbg) return;

    debug.print(l ++ ": ", .{});
    for (f) |t| {
        const v: u8 = switch(t) {
            T.set => '#',
            T.unk => '?',
            T.fre => '.',
        };

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

fn eut(comptime l: anytype, f: anytype, s: ?[]u64) !void {
    out(l, f, s);
    try err("", null);
}

fn lin(comptime l: anytype, i: anytype) void {
    if (!dbg) return;

    debug.print(l ++ ": ", .{});

    for (0..i) |_| {
        debug.print(" ", .{});
    }

    debug.print("^ {}\n", .{i});
}

fn set(
    c: anytype, i: anytype,
    t: anytype
) !void {

    assert(i < c.len);

    _ = switch(t) {
        T.set => assert(c[i] == T.fre),
        T.fre => assert(c[i] == T.set),

        else => {
            try err("set", t);
        }
    };

    c[i] = t;
}

fn mov(
    c: anytype,
    ii: u64, ee: u64,
    o: anytype
) !void {
    var i = ii;
    var e = ee;

    if (o >= c.len) {
        try err("tar", o);
    }

    assert(c[o] == T.fre);
    assert(e < o);
    assert(i <= e);
    assert(c[e] == T.set);
    assert(c[i] == T.set);

    while (e < o) {
        e += 1;

        try set(c, e, T.set);
        try set(c, i, T.fre);

        i += 1;
    }

    e += 1;

    if (e < c.len and c[e] == T.set) {
//        lin("  e", e);

        i = e;

        while (e+1 < c.len and c[e+1] == T.set)
            e += 1;

        assert(e + 1 < c.len);
        assert(c[e+1] == T.fre);

        try mov(c, i, e, e+1);

    } else {
        out("mov", c, null);

    }
}

fn beg(
    c: anytype,
    ii: anytype

) !u64 {
    var i = ii;

    while (i > 0 and c[i-1] == T.set) {
        i -= 1;
    }

    if (c[i] != T.set) {
        try err("beg", i);
    }

    return i;
}

fn fre(
    c: anytype,
    o: anytype

) !void {
    var i = o;

    lin("fre", i);

    // Find set //
    while (i > 0 and c[i] != T.set) {
        i -= 1;
    }

    const e = i;

    if (c[e] != T.set) {
        try err("end", i);
    }

    i = try beg(c, i);
    
    try mov(c, i, e, o);
}

fn ful(
    c: anytype,
    ii: anytype

) !void {
    var i = ii;

    lin("ful", i);

    if (c[i] != T.set) {
        try err("", i);
    }

    // Start //
    const b = try beg(c, i);

    // End //
    while (i+1 < c.len and c[i+1] == T.set) {
        i += 1;
    }

    if (c[i] != T.set) {
        try err("end", i);
    }

    try mov(c, b, i, i+1);
}

fn fix(
    f: anytype, c: anytype,
) !void {
    var i: u64 = 0;

    for (f, 0..) |v, j| {
        const w = c[j];

        if (w == v or v == T.unk) continue;

        i = j;
        break;
    }

    if (c[i] == T.fre) {
        try fre(c, i);

    } else {
        try ful(c, i);

    }
}

fn bum(
    f: anytype, c: anytype,
    s: anytype, x: anytype,
    r: *u64,

) !void {

    var i: u64 = 0;
    var p = T.fre;

    for (s) |w| {
        while (f[i] == T.fre) i += 1;

        for (0..w) |_| {

            c[i] = T.set;
            i += 1;
        }
        i += 1;
    }

    out("org", f, s);
    out("bum", c, null);

    while(!val(f, c)) {
        try fix(f, c);
    }

    if (!val(f, c)) {
        try err("val", i);
    }

    // Trim left //
    for (c, 0..) |w, j| {

        const v = f[j];

        if (v == w) continue;

        if (v == T.unk and w == T.fre) {

            f[j] = w;
            continue;
        }

        break;
    }

    // Trim right //
    i = c.len - 1;

    while (true) {
        const v = f[i];
        const w = c[i];

        if (v == w) {
            if (i < 1) break;

            i -= 1;
            continue;
        }

        if (v == T.unk and w == T.set) {
            f[i] = w;

            if (i > 0) {
                i -= 1;
                continue;
            }
        }

        break;
    }

    putd("");
    out("new", f, null);

    if (!val(f, c)) {
        try err("val", i);
    }

//    if (val(f, c)) 
    r.* += 1;

    p = T.fre;

    var k: u64 = 0;

    for (c, 0..) |v, j| {

        if (v == T.set and p == T.fre) {

            if (k >= x.len) {
                out("xxx", c, x);
                lin("  k", j);
                try err("", k);
            }

            x[k] = j;
            k += 1;
        }

        p = v;
    }

    out("   ", c, x);

//    for (x, 0..) |_, t| {
//        deb("  t", t, "");
//
//        try wig(x, s, t, c, f, r);
//    }

    // Last moves + chain reaction //
    try wig(x, s, x.len-1, c, f, r, true);
}

fn wig (
    x: anytype, s: anytype,
    j: anytype,
    c: anytype, f: anytype,
    r: anytype, o: anytype

) !void {

    // Head //
    var k = x[j];

    // Tail+1 //
    var l = k + s[j];

    // Not moved //
    if (j > 0) {
        var y = [_]u64{2};
        out("   ", c, &y);

        try wig(x, s, j-1, c, f, r, false);
    }

    while (
        (l < c.len and c[l] == T.fre) and
        (l+1 == c.len or (l+1 < c.len and c[l+1] == T.fre))
    ) {
        // Walk //
        try set(c, k, T.fre);
        try set(c, l, T.set);

        const p = (
            (f[l] == T.set or f[l] == T.unk) and
            (f[k] == T.fre or f[k] == T.unk)
        );

        if (p or o) {
            var z = [_]u64{0};
            if (val(f, c)) {
                r.* += 1;
                z[0] = 1;
                out("   ", c, &z);
            }

            if (j > 0) {
                try wig(x, s, j-1, c, f, r, false);
            }
        }

        // Index //
        k += 1;
        l += 1;
    }

    // Return //
    while (
        k > x[j]
    ) {
        k -= 1;
        l -= 1;

        try set(c, k, T.set);
        try set(c, l, T.fre);
    }

//    out("gig", c, null);
}

fn val (f: anytype, c: anytype) bool {
    for (f, 0..) |v, i| {
        const w = c[i];

        if (w == v or v == T.unk) continue;

        return false;

//        _ = switch(v) {
//            T.set => {
//                if (w == T.fre) return false;
//            },
//            T.fre => {
//                if (w == T.) return false;
//            },
//            T.unk => {},
//        };
    }

    return true;
}

fn rcs(
    f: anytype, c: anytype, ii: anytype,
    s: anytype, jj: anytype,
    ll: anytype, r: *u64,
    oo: anytype

) !void {
    var i: usize = ii;
    var j: usize = jj;
    var l: u64 = ll;
    var o: T = oo;

    while (i < f.len and j < s.len) {
        const v = if (o == T.unk)
                f[i]
            else tmp: {
                defer o = T.unk;

                break :tmp o;
            };

        assert(o == T.unk);
//        deb("v", v, "");

        const w = s[j];

//        deb("rcs", .{i, j, w, l, v}, "");

        _ = switch(v) {

            T.set => {
                l += 1;

                if (l > w) return;
            },

            T.unk => {
                try rcs(f, c, i, s, j, l, r, T.set);

                o = T.fre;

                continue;
            },

            T.fre => {
//                try err("fre", v);

                if (l > 0) {
                    if (l < w) return;

                    assert(l == w);

                    l = 0;
                    j += 1;
                }
            },

            else => {
                try err(":switch", v);
            }
        };

        i += 1;
    }

    if (l > 0) {
        const w = s[j];

        if (l < w) return;

        assert(l == w);

        j += 1;
    }

    if (i == f.len and j == s.len) {
//        deb("f", .{i, f.len, j, s.len}, "");

        r.* += 1;
    }

}

fn tmain(al: anytype) !void {
    puts("");

    var n: u64 = 0;

    const d = try ini(al, "data12-t.txt", &n);

    const a = try par(al, d);

    defer a.deinit();
    defer for (a.items) |x| x.deinit();

    al.free(d);

    const r = try run(a, n);

    res(r, "d");
}

pub fn main() !void {

//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const al = are.allocator();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const al = gpa.allocator();

    try tmain(al);

}

test "main" {
    dbg = true;

    debug.print("\n", .{});

    const al = std.testing.allocator;

    try tmain(al);
}
