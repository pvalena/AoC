
// Import //
const R = @import("class.zig");

const std = R.std;

const fmt = R.fmt;
const io = R.io;
const mem = R.mem;
const debug = R.debug;
const assert = R.assert;
const stdout = R.stdout;
const tst = R.tst;

const spl = R.spl;
const eql = R.eql;
const swp = R.swp;

const ini = R.ini;
const res = R.res;

const deb = R.deb;
const putd = R.putd;
const puts = R.puts;
const err = R.err;
const pr = R.pr;
const dpr = R.dpr;

const lin = R.lin;
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;

const Array = R.Array;
const HashMap = R.HashMap;

const gen = R.gen;
const num = R.num;


// Globals //
const dbg = &R.dbg;


// Data //
//const N3 = Array(Array(T));
//const D3 = struct {
//    al: mem.Allocator,
//    d: Array(N3),
//    l: *N3,
//    w: u64,
//    h: u64,
//
//    fn init(al: anytype) D {
//        var s: D = undefined;
//
//        s.al = al;
//        s.d = Array(N3).init(al);
//
//        s.h = 0;
//        s.w = 0;
//        
//        return s;
//    }
//
//    fn new(sl: anytype) !void {
//        const l = N3.init(sl.al);
//
//        try sl.d.append(l);
//
//        const i = sl.d.items;
//
//        sl.h = i.len;
//
//        sl.l = &i[i.len-1];
//    }
//
//    fn row(sl: anytype) !*N {
//        const n = N.init(sl.al);
//
//        try sl.l.append(n);
//
//        const i = sl.l.items;
//
//        if (i.len > sl.w) sl.w = i.len;
//
//        return &i[i.len-1];
//    }
//
//    fn get(sl: anytype, j: anytype, c: anytype, k: anytype) T {
//        return sl.d.items[j].items[c].items[k];
//    }
//
//    fn deinit(sl: anytype) void {
//        for (sl.d.items) |i| {
//            
//            for (i.items) |j| {
//
//                j.deinit();
//
//            }
//            i.deinit();
//
//        }
//        sl.d.deinit();
//    }
//};


// Types //
const T = enum {
    fre,
    vsp,
    hsp,
    mil,
    mir,
};

// IO //
fn dec(v: anytype) !T {
    return switch(v) {
        '.' => T.fre,
        '/' => T.mir,
        '\\' => T.mil,
        '-' => T.hsp,
        '|' => T.vsp,

        else => return error.type
    };
}
fn con(t: anytype) u8 {
    return switch(t) {
        T.fre => '.',
        T.mir => '/',
        T.mil => '\\',
        T.hsp => '-',
        T.vsp => '|',
    };
}

// Structure //
const Ti = T;
const Di = gen(Ti);


// Input //
fn par(al: anytype, d: []u8) !Di {

    // Multi-Data
    var a = Di.init(al);
//    try a.new();

    // Line
    var ls = spl(d, "\n");

    while (ls.next()) |l| {
        if (l.len == 0) {

//            if (a.l.items.len > 0) {
//                try a.new();
//            }
        
            continue;
        }

        // Elems
        var ws = spl(l, " ");
        var i: u64 = 0;

        while (ws.next()) |w| {
            defer i += 1;

//            puts("w", w);

            if (w.len == 0) {
                try err("zero", l);
                continue;
            }

            try a.new();
//            try a.add(w);
            try dat(a, w, i);
        }
    }

    return a;
}

fn dat(x: anytype, w: anytype, i: anytype) !void {

    if (i == 0) {
        for (w) |v| {
//            try err("Entry", v);
            const t = try dec(v);

            try x.add(t);
        }

        return;
    }

    try err("Invalid entry", w);
//    _ = i;
//    _ = x;

//    return;

//    var ns = spl(w, ",");

//    while (ns.next()) |n| {
//        if (n.len == 0) continue;

//        if (n[0] >= '0' and n[0] <= '9') {
//            const v = fmt.parseUnsigned(u64, n, 10) catch |e| {
//                err("Invalid int", n) catch {};
//
//                return e;
//            };
//        } else {
//            try err("Invalid number", n);
//
//        }
//    }
}


// Logic //
const K = [2]i64;
//const B = gen(L);

const L = struct {
    p: K,
    d: K
};

fn run(al: anytype, d: anytype, b: anytype) !u64 {

//    const w = d.items()[0].items;
//    const x = d.items();
    const x = d;

//    var r: u64 = 0;
//    r += 0;

//    Timestamp
//    const t = tst();

    // energized //
    var a = HashMap(K, bool).init(al);
    defer a.deinit();

    // visited //
    var s = HashMap(L, bool).init(al);
    defer s.deinit();

    // active lasers //
    var l = Array(L).init(al);
    defer l.deinit();

    // new lasers //
    var n = Array(L).init(al);
    defer n.deinit();

    var z: L = undefined;
    z.p = .{ 0, 0};
    z.d = .{ 1, 0};

    try l.append(z);
    try a.put(z.p, true);

    while (l.items.len > 0) {
        for (l.items, 0..) |v, i| {

    //        puts("v", v);
    //        try err("v", .{i, v});

    //        const z = x.items;
    //        if (x.h == 0) continue;

    //        if (i % n == 0) {
    //            const o = dbg.*;
    //            dbg.* = true;

            if (s.contains(v))
                continue;

            try s.putNoClobber(v, true);
            const w = try lop(x, v, &a);

            for (w) |k| {
                if (k.p[0] >= 0) {
                    try n.append(k);
                }
            }

            if (dbg.* and b > 0 and i >= b-1) {
                break;
            }
        }

        swp(&n, &l);

        n.clearRetainingCapacity();
    }

    phk("a", a);

    pra(x, s);

//    try err("lop", a.count());

    return a.count();
}

fn lop(x: anytype, ll: anytype, aa: anytype) ![2]L {

    var a = aa;
    var l = ll;

    const p: K = .{ l.p[0] + l.d[0], l.p[1] + l.d[1] };

    var z: [2]L = undefined;
    z[0].p = .{-1, 0};
    z[1].p = .{-1, 0};

    if (p[0] < 0 or p[1] < 0) return z;
    if (p[0] >= x.h() or p[1] >= x.w()) return z;
    
    // go //
    try a.put(p, true);

    const v = x.get(p[0], p[1]);

//    dpr("lop: {c}, {any}, {any}\n", .{con(v), p, l.d});
    deb("lop", .{v, p, l.d});

    _ = switch(v) {
        T.fre => {
            pas(&z, p, l);
        },

        T.mir => {
            swp(&l.d[0], &l.d[1]);

            l.d[0] = -l.d[0];
            l.d[1] = -l.d[1];

            pas(&z, p, l);
        },

        T.mil => {
            swp(&l.d[0], &l.d[1]);
            pas(&z, p, l);

        },

        T.vsp => {
            if (l.d[0] == 0) {
                z[0].p = p;
                z[0].d = .{-1, 0};

                z[1].p = p;
                z[1].d = .{ 1, 0};

            } else {
                pas(&z, p, l);

            }
        },

        T.hsp => {
            if (l.d[1] == 0) {
                z[0].p = p;
                z[0].d = .{0, -1};

                z[1].p = p;
                z[1].d = .{0,  1};

            } else {
                pas(&z, p, l);
            }
        },
    };

    return z;
}

fn pas(z: anytype, p: anytype, l: anytype) void {
    z.*[0].p = p;
    z.*[0].d = l.d;
}

//fn fin(a: anytype) u64 {
//
//    var e: u64 = 0;
//
//    for (a.items()) |r| {
//        for (r.items) |l| {
//
//            if (l) e += 1;
//        }
//    }
//
//    return e;
//}
//


// Draw //
fn phk(comptime l: anytype, a: anytype) void {

    if (!dbg.*) return;

    dpr("\n" ++ l ++ "[k]: ", .{});

    var k = a.keyIterator();

    while (k.next()) |v| {
        dpr("[{}, {}] ", .{v[0], v[1]});
    }

    dpr("\n", .{});
}

fn chc(a: anytype, i: anytype, j: anytype) bool {

    var k = a.keyIterator();

    while (k.next()) |v| {
        if (v.p[0] == i and v.p[1] == j)
            return true;
    }

    return false;
}

fn pra(a: anytype, s: anytype) void {

    pr("\n", .{});

    for (a.items(), 0..) |rr, i| {
        const r = rr.items;
    
        if (r.len <= 0) continue;
    
        pr("   ", .{});

        for (r, 0..) |l, j| {

            if (chc(s, i, j))
                pr("#", .{})
            else
                pr("{c}", .{con(l)});
        }

        pr("\n", .{});
    }

    pr("\n", .{});
}


// Main //
fn tmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

    const aoc = "16";
    const f = "data" ++ aoc ++ "-t.txt";

    const d = try ini(al, f, &n);
    defer al.free(d);

    if (n > 0) dbg.* = true;

    const a = try par(al, d);
    defer a.deinit();

//    out2("inp", a, null, con);

    const r = try run(al, a, n);
    res(r);
}


// Run //
pub fn main() !void {
//    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
//    defer are.deinit();
//    const al = are.allocator();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const al = gpa.allocator();

    try tmain(al, 0);
}


// Test //
test "main" {
    dbg.* = true;

    puts("", "");

    const al = std.testing.allocator;

    try tmain(al, 0);
}
