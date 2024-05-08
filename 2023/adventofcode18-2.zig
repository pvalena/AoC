
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
const wip = R.wip;
const pr = R.pr;
const dpr = R.dpr;

const lin = R.lin;
const out = R.out;
const eut = R.eut;
const out2 = R.out2;
const eut2 = R.eut2;

const Array = R.Array;
const HashMap = R.HashMap;
const HashArray = R.HashArray;

const gen = R.gen;
const num = R.num;


// Globals //
const dbg = &R.dbg;
const aoc = "18";

// Input //
const D = enum {
    U,
    R,
    D,
    L
};
const C = [3]u8;
fn dec(v: anytype) !D {
    return switch(v) {
        'U' => D.U,
        'R' => D.R,
        'D' => D.D,
        'L' => D.L,
        else => return error.type
    };
}
const I = struct {
    d: D,
    n: u64,
    c: C
};


// Output //
const T = enum {
    fre,
    set,
};
fn dis(t: anytype) u8 {
    return switch(t) {
        T.fre => '.',
        T.set => '#',
    };
}
//const O = struct {
//    p: [2]u64,
//    t: T,
//};


// Data //
const A = gen(I);
const B = gen(T);


// Logic //
fn par(al: anytype, d: []u8) !A {

    // Multi-Data
    var a = A.init(al);
    try a.new();

    // Line
    var ls = spl(d, "\n");
    while (ls.next()) |l| {

        // Empty line
        if (l.len == 0) {

//            if (a.l.items.len > 0) {
//                try a.new();
//            }
        
            continue;
        }

        // Per elems
        var ws = spl(l, " ");
        var i: u64 = 0;

        var z: I = undefined;

        while (ws.next()) |w| {
            defer i += 1;

            if (w.len == 0) {
                try err("zero", l);
                continue;
            }

//            puts("w", w);

            _ = switch(i) {
                0 => {
                    if (w.len > 1) try err("par: len", w);
                    z.d = try dec(w[0]);
                },
                1 =>
                    z.n = try num(w, u64),
                2 => 
                    z.c = try dat(w),
                else => 
                    try err("par: swi", l)
            };

        }

        try a.add(z);

//        break;
    }

    return a;
}

fn dat(v: anytype) !C {

    var c: C = undefined;

    var i: usize = 2;
    var n: usize = 0;

    while (n < 3) {
        defer n += 1;
        defer i += 2;

        const s = v[i..i+2];

        c[n] = fmt.parseUnsigned(u8, s, 16) catch |e| {
            err("Invalid hex", v) catch {};

            return e;
        };
    }

//    deb("dat", c);
//    try err("NYI", c);

    return c;
}


fn run(al: anytype, d: anytype, z: anytype) !u64 {

    // Unused //
//    _ = z;
//    _ = d;
//    _ = al;

    // Timestamp //
//    const t = tst();

    var b = B.init(al);
    try b.new();
    defer b.deinit();

    // Position //
    const o = 200;
    var p: [2]u64 = .{ o, o };

    // Initial trench //
    try b.set2(p, T.set);

    // Input - first array //
    const x = d.l;

    for (x.items, 0..) |l, i| {
//        _ = i;

        if (z == i and z > 0) {
            dbg.* = true;
            deb("run", l);
            pra(b);
        }

        try ply(&l, &p, &b);

        if (z == i and z > 0) {
            pra(b);
            return 0;
        }
    }

    pra(b);
    try fil(&b);

    return fin(&b);
//    return 0;
}

fn ply(
    l: anytype,
    p: anytype,
    o: anytype,
) !void {

//    deb("ply", .{p, l.d, l.n});

    for (0..l.n) |_| {

        _ = switch(l.d) {
            D.R =>
                p[1] += 1,

            D.L => {
                assert(p[1] > 0);
                p[1] -= 1;
            },

            D.D =>
                p[0] += 1,

            D.U => {
                assert(p[0] > 0);
                p[0] -= 1;
            }
        };

//        deb("set", p);

        try o.set2(p, T.set);
    }
}

fn fil(bb: anytype) !void {

    const b = bb.items();

    // left //
    for (b, 0..) |ll, i| {

        const l = ll.items;

        const j = chcL(l);

        if (j > 0) {
            filR(bb, i, j);
            break;
        }
    }

    pra(bb);
}

fn filR(bb: anytype, i: anytype, j: anytype) void {

    const b = bb.items();

    if (i < 1 or i >= b.len) return;

    var l = b[i].items;

    if (j < 1 or j >= l.len or l[j] != T.fre) return;

    l[j] = T.set;

    filR(bb, i, j+1);
    filR(bb, i, j-1);

    filR(bb, i+1, j);
    filR(bb, i-1, j);
}

fn chcL(l: anytype) usize {

    var i: usize = 0;

    if (l.len <= 0) return 0;

    while (l[i] == T.fre) {
        i += 1;

        if (i >= l.len) return 0;
    }
    if (l[i] != T.set) return 0;

    while (l[i] == T.set) {
        i += 1;

        if (i >= l.len) return 0;
    }
    if (l[i] != T.fre) return 0;

    const j = i;

    while (l[i] == T.fre) {

        i += 1;

        if (i >= l.len) return 0;
    }
    if (l[i] != T.set) return 0;

    return j;
}

//fn mov(
//    x: anytype, l: anytype, v: anytype, n: anytype,
//    h: anytype, r: anytype
//
//) !void {
//
//    const d = (l.d[0] == h and l.d[1] == r);
//    
//    if (d and l.m >= 3) return;
//
//    const p: K = .{ l.p[0] + h, l.p[1] + r };
//
//    if (p[0] < 0 or p[1] < 0) return;
//    if (p[0] >= x.h() or p[1] >= x.w()) return;
//
//    var z: L = undefined;
//    z.p = p;
//    z.d = .{h, r};
//    z.m = if (d) l.m + 1 else 1;
//
//    var w: V = undefined;
//
//    w.v = x.get2(p) + v.v;
//
//    w.p = try v.p.clone();
//
//    try w.p.append(z.p);
//
////    try err("mov", w.v);
//
//    // go //
//    _ = try lput(n, z, w);
//}
//
//fn lput(s: anytype, k: anytype, v: anytype) !bool {
//    const g = s.*.get(k);
//
//    if (g) |c| {
//        if (v.v < c.v) {
//            // Current bad //
//            c.p.deinit();
//            try s.*.put(k, v);
//   
//        } else {
//            // Current good //
//            v.p.deinit();
//            return false;
// 
//        }
//
//    } else {
//        // New entry //
//        try s.*.putNoClobber(k, v);
//
//    }
//
//    return true;
//}

fn fin(b: anytype) !u64 {

    var n: u64 = 0;

    for (b.items()) |l| {

        for (l.items) |v| {
            if (v == T.set) n += 1;
        }

    }
    
    return n;
}


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


fn pra(a: anytype) void {

    pr("\n", .{});

    for (a.items(), 0..) |rr, i| {

        _ = i;

        const r = rr.items;
    
        if (r.len <= 0) continue;
    
        pr("   ", .{});

        for (r, 0..) |l, j| {

            _ = j;

            pr("{c}", .{dis(l)});
        }

        pr("\n", .{});
    }

    pr("\n", .{});
}


// Main //
fn tmain(al: anytype, nn: anytype) !void {
    puts("", "");

    var n: u64 = nn;

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

    // Fun! //
    var are = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer are.deinit();
    const al = are.allocator();

    // Speed! //
//    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
//    defer _ = gpa.deinit();
//    const al = gpa.allocator();

    try tmain(al, 0);
}


// Test! //
test "main" {
    dbg.* = true;

    puts("", "");

    const al = std.testing.allocator;

    try tmain(al, 0);
}
