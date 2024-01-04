
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

fn err(comptime l: anytype, d: anytype) !void {
    debug.print("\n", .{});

    dbg = true;
    deb("Error[" ++ l ++ "]", d, "any");

    debug.print("\n", .{});

    return error.err;
}

fn res(d: anytype, comptime t: anytype) void {

    stdout.print("\n => {" ++ t ++ "}\n\n", .{d}) catch |e| {
        err("res", @errorName(e)) catch {};
    };
    
}

// Logic
fn ini(al: anytype, tf: anytype) ![]u8 {

    var args = std.process.args();

    _ = args.skip();
    
    const f = args.next() orelse tf;

    if (f.len == 0) {
        try err("Missing Arg", "Filename");
    }

    const d = try std.fs.cwd().readFileAlloc(al, f, std.math.maxInt(usize));

//    deb("data", d, "s");

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

            // First
            if (i == 0) {
//                deb("First", w, "s");

                var r = T.fre;

                for (w) |v| {

                    const t = switch(v) {
                        '#' => T.set,
                        '?' => T.unk,
                        '.' => T.fre,

                        else => return error.type
                    };

                    defer r = t;

                    if (r != t or t != T.fre) {
                        try x.f.append(t);
                        try x.c.append(T.fre);
                    }
                }

                continue;
            }

            // Second
//            deb("Second", "", "s");

            var ns = split(u8, w, ",");

            while (ns.next()) |n| {
                if (n.len == 0) continue;

                if (n[0] >= '0' and n[0] <= '9') {
                    const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
                        err("Invalid int", n) catch {};

                        return e;
                    };

//                    deb("Number", v, "d");

                    try x.s.append(v);
                    try x.x.append(v);

                } else {
                    try err("Invalid number", n);

                }
            }
        }

        try a.append(x);

    }

    return a;
}

fn run(d: anytype) !u64 {

    var r: u64 = 0;

    for (d.items) |x| {

        const f = x.f.items;
        const c = x.c.items;
        const s = x.s.items;
        const z = x.x.items;

//        out("run", f, s);

        var v: u64 = 0;

        try bum(f, c, s, z, &v);
//        try rcs(f, c, 0, s, 0, 0, &v, T.unk);

        r += v;

        deb("v", v, "");
        if (dbg) debug.print("\n", .{});
    }

    return r;
}

fn out(comptime l: anytype, f: anytype, s: ?[]u64) void {
    if (dbg) {
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

//    out("bum", c, null);

    // Lookup //
    while(!val(f, c)) {
        
        i = 0;

        for (f, 0..) |v, j| {
            const w = c[j];

            if (w == v or v == T.unk) continue;

//            deb("j", j, "");

            i = j;

            if (v == T.fre) {
                while (i > 0 and c[i] != T.set) i -= 1;
            }

            while (i > 0 and c[i-1] == T.set) i -= 1;

            break;
        }

        if (c[i] != T.set)
            try err("i", i);

        p = T.fre;

        while (i < c.len) {

            const t = c[i];

            c[i] = p;

            p = t;

            i += 1;
        }

        if (p == T.set)
            try err("set", i);

//        out("fix", c, null);
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
    i = c.len-1;

    while (i > 0) {
        defer i -= 1;

        const v = f[i];
        const w = c[i];

        if (v == w) continue;

        if (v == T.unk and w == T.set) {

            f[i] = w;
            continue;
        }

        break;
    }

    out("new", f, s);

    if (!val(f, c)) {
        try err("val", i);
    }

    r.* += 1;

//    i = c.len-1;

    p = T.fre;

    var k: u64 = 0;

    for (c, 0..) |v, j| {

        defer p = v;

        if (v == T.set and p == T.fre) {

            defer k += 1;
            x[k] = j;
        }
    }

    out("bum", c, x);

    // wiggle //
    for (x, 0..) |_, j| {
        try wig(x, s, j, c, f, r);
    }
}

fn wig (
    x: anytype, s: anytype,
    j: anytype,
    c: anytype, f: anytype,
    r: anytype
) !void {
    var k = x[j];
    var l = k + s[j];

    while (
        l < f.len and c[l] == T.fre and
        ( (l+1 < f.len and c[l+1] == T.fre) or l+1 == f.len )        
    ) {
        c[l] = T.set;
        c[k] = T.fre;

        out("wig", c, null);

        if (val(f, c))
            r.* += 1;

        if (j > 0)
            try wig(x, s, j-1, c, f, r);

        k += 1;
        l += 1;
    }

    while (
        k > x[j]
    ) {
        k -= 1;
        l -= 1;

        c[k] = T.set;
        c[l] = T.fre;
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
//                try err(":fre", v);

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

    const d = try ini(al, "data12-t.txt");

    const a = try par(al, d);

    defer a.deinit();
    defer for (a.items) |x| x.deinit();

    al.free(d);

    const r = try run(a);

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
